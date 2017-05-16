# -*- coding: utf-8 -*-
"""Programa principal que recoge los datos en tiempo atraves de un streaming de NIFI y los clasifica.
    Autor: Helton Borges, Oscar Bartolomé, Arkaitz Merino
    Note:
        Ultiliza un streaming creado con la herramienta NIFI. 
        Descripción: Ultilizando la herramienta NIFI en CLOUDERA se recogen tweets en tiempo real
        que son selecionados y enviados a este programa que los clasifica y los guarda en una base de datos
        noSQL <por definir> de rapida escritura, para su posterior explotación desde la herramienta de 
        business intelligence <por definir>.
        repositorio: <por definir>
        Autores implementación NIFI: Daniel Álvares, Jesús Fuerte 
    Args:
        StreamingNIFI: tweets sin clasificar
       
    Returns:
        tweets clasificados. 
    """

import re
import json
from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils
import json
from kafka import SimpleProducer, KafkaClient, KafkaProducer

#Setup
sc = SparkContext(appName="Complaind_Classifier")
ssc = StreamingContext(sc,5)

# funciones del programa complaind_classifier

#Cargar el dicionario de Lemas para el lematizador
lemasRDD = sc.textFile('file:///opt/clasificador_tweets/lema.csv')
dicLemas = dict(lemasRDD
             .map(lambda l: l.split(';'))
             .map(lambda x: (x[0], x[1]))
             .collect())


"""Remueve las puntuaciones, caracteres especiales, links y lo transforma a minuscula.
    Autores: Oscar Bartolomé
    Note:
        Ultiliza la siguiente librería. 
        Libreria: re.py
        repositorio: "https://github.com/python/cpython/blob/3.6/Lib/re.py"
    Ejemplo: "   @jose123, hoy hace un dia maravilloso:) 'http//:repimg.com/img1' mira que cielo" -> "jose123 hoy hace un dia maravilloso mira que cielo"
    Args:
        text (str): Un string.
    Returns:
        str: el conjunto de palabras depues de aplicar los filtros de las expresiones regulares
    """
def removePunctuation(tweetValue):
    text = tweetValue[0]
    text = ' '.join(re.sub(u"(@[A-Za-z]+)|([^a-zA-ZÁ-Úá-ú \t])|(\w+:\/\/\S+)",
                           " ", text).lower().split())
    return  (text, tweetValue[1])

"""Transforma las palabras a su raiz.
    Autores: Oscar Bartolomé, Helton Borges
    Note:
    Ejemplo: es -> ser; eres -> ser, las -> los, estoy -> estar
    Args:
        
       /FileStore/tables/ekaaqk2x1494588650989/lema.csv
    Returns:
        str: el conjunto de palabras en su raiz
    """
def lematizar(tweetValue, dic = dicLemas):
  tweetLematizado = tweetValue[0].split(' ')
  for i in range(1, len(tweetLematizado)):
    if dic.has_key(tweetLematizado[i]):
      tweetLematizado[i] = dic[tweetLematizado[i]]
  return (' '.join(tweetLematizado), tweetValue[1])

"""Busca si alguna referencia a barrios en los tweets.
    Autor: Helton Borges
    Note:
        De forma sencilla compara los posibles barrios de vitória con las palabras en el tweet.
    Ejemplo: "Esto es un tweet de queja en abetxuko" -> ("Esto es un tweet de queja en abetxuko", abetxuko)
    Args:
        tweetValues: El texto del tweet y su localización por defecto.
        
    Returns:
        (tweet, localidad): el tweet y su localización
    """
barriosVitoria = (u'abetxuko',u'adurtza',u'ali-Gobeo',u'arana', u'aranbizkarra', u'arantzabela', u'aretxabeleta', u'gardelegi', u'aretxabeleta-gardelegi', u'ariznabarra', u'arriaga-lakua', u'arriaga', u'lakua', u'casco viejo', u'coronación', u'coronacion', u'desamparados', u'el anglo', u'el pilar', u'ensanche', u'gazalbide', u'judimendi', u'judizmendi', u'lovaina', u'mendizorrotza', u'mendi', u'mendizorroza', u'salburua', u'san cristóbal', u'san cristobal', u'san martín', u'sansomendi', u'santa lucía', u'santa lucia', u'santiago', u'txagorritxu', u'zabalgana', u'zaramaga', u'zona rural este', u'zona rural noroeste', u'zona rural suroeste')

def buscarBarrio(tweetValue, barrios = barriosVitoria): 
  
  #tweetText = ' '.join(tweetValue[0])
  localidad =  tweetValue[1]
  for barrio in barrios:
    if tweetValue[0].find(barrio) > 0:
      localidad = barrio
  return (tweetValue[0], localidad)

"""Clasifica un tweet en castellano, aplicando reglas de un Clasificador bayesiano creado en R.
    Autor: Arkaitz Merino
    Note:
        Ultiliza reglas de un Algortimo Naive Bayes implementado en R.
        Descripción: Con tecnicas de Machine-Learning nuestros cientificos de datos han creado un algortimo que
        puede clasificar, si el tweet se trata de una queja o no.
        El algortimo está en versión de prueba y mejora.
        
        Autores algoritmo en R: Odei Barredo, Unai Barredo, Alex Somovilla, Arkaitz Merino, Oscar Bartolomé
        repositorio: "https://github.com/<Por definir>"
    Ejemplo: "Esto es un tweet de queja" -> ("Esto es un tweet de queja", 1)
             "Esto no es una queja" -> ("Esto no es una queja", 0)
    Args:
        tweet (str): un string.
    Returns:
        (tweet, Clasificacion): el tweet y su clasificacion
    """
dicNaiveBayes = {"rata":(0.15,0.85), "quejar":(0.8,0.1), "jamon":(0.3,0.7)}
def clasificar(tweetValue, dic = dicNaiveBayes): 
  probQueja = 1
  probNoQueja = 1 
  clasificacion = 0
  for palabra in tweetValue[0].split(" "):
    if dic.has_key(palabra):
      probQueja = probQueja * dic[palabra][0]
      probNoQueja = probNoQueja * dic[palabra][1]
  if probQueja > probNoQueja:
     clasificacion = 1
  return (tweetValue[0], clasificacion, tweetValue[1])

def paraJson(text):
    return (json.loads(text[1])['ID'],
            (json.loads(text[1])['texto'], json.loads(text[1])['barrio'])
            )

"""Escribe los datos del tweet y su clasificación en la base de datos noSQL <por definir>.
    Autores:
    Note:
        Ultiliza la siguiente librería. 
        Libreria: <por definir>
        autor: <por definir>
        repositorio: <por definir>
    Args:
        datos tweet: (id, tweet, clasificacion).
    Returns:
        escritura en la base de datos noSQL <por definir>.
    """
def guardarClasificacion(x):
  return str(u'{ "ID":"' + str(x[0]) + u'","texto":"' + str(x[1][0]) + u'", "clasificacion":"' + str(x[1][1]) + u'", "barrio":"' + str(x[1][2])+ u'"}')


#Conecta a kafka
kafka_Stream = KafkaUtils.createStream(ssc, "sandbox.hortonworks.com:2181", "spark_streaming", {"inter_transact": 1})
#tweetsClassifiedRDD = kafka_Stream.map(paraJson).mapValues(removePunctuation)#.mapValues(buscarBarrio).mapValues(lematizar).mapValues(clasificar)
#Transforma y clasifica los tweets
tweetsClassifiedRDD = (kafka_Stream.map(paraJson)  #Da formato a los tweets recibidos por kafka
                        .mapValues(removePunctuation)  #Remueve todos los caracteres especiales
                        .mapValues(buscarBarrio)       #Clasificador por barrios
                        .mapValues(lematizar)          #Transforma las palabras a Raiz
                        .mapValues(clasificar)         #Aplica el Clasificador bayesiano
                        .map(guardarClasificacion))    #Escribe los datos del tweet y su clasificación en el

#enviar tweets clasificados a kafka para que NiFi los recoja
producer = KafkaProducer(bootstrap_servers='sandbox.hortonworks.com:6667')
def handler(message):
    records = message.collect()
    for record in records:
        producer.send('spark.out', str(record))
        producer.flush()
		
tweetsClassifiedRDD.foreachRDD(handler)

tweetsClassifiedRDD.pprint()

ssc.start()
ssc.awaitTermination()

