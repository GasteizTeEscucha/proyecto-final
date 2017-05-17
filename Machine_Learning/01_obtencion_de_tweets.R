            
####################        OBTENCIÓN DE TWEETS          #####################

# Para poder conectarnos a la API de Twitter necesitamos la librería "twitterR"
library(twitteR)

### A) CONECTAR A TWITTER:

# Necesitaremos unos códigos específicos para la autorización a conectarnos con
# la API. Estos códigos se consiguen creando una aplicación en Twitter con 
# nuestra cuenta de usuario.
# Abajo se muestran los cuatro códigos que necesitamos. Hemos codificado las
# claves como "XXXXXXX" ya que son claves de usuario privados.
consumer_key <- "XXXXXXX"
consumer_secret <- "XXXXXXX"
access_token <- "XXXXXXX"
access_secret <- "XXXXXXX"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


### B) BÚSQUEDA TWEETS:
# Creamos una lista de palabras clave que queremos encontrar
vHastags <- c("accesibilidad", "accidente", "alcantarilla", "anillo verde", "aparcabicis", "asco", "ataque",
              "atasco", "autobus", "basura", "basurero", "bici", "bus", "calle", "ciclista", "contaminacion",
              "contenedor", "green", "jardines", "limpieza", "medio ambiente", "olor", "palomas", "papelera",
              "pelea", "pintada", "problema", "rata", "reciclaje", "reciclar", "renta", "robo", "rotonda",
              "ruido", "suciedad", "sucio", "trafico", "tranvia", "violencia",
              "vitoria", "gasteiz")

tweet_df <- data.frame() # dataframe donde iremos metiendo los tweets
for(s in vHastags){
  new_tweets <- searchTwitter(s,   # palabra de búsqueda
                              geocode='42.846718,-2.671635,10km', # localización de Gasteiz
                              n=1000) # cantidad de tweets a recoger
  if(length(new_tweets)>0){
    new_tweets <- strip_retweets(new_tweets) # elimina retweets
    tweet_df <- rbind(tweet_df, twListToDF(new_tweets)) # pasarlo a dataframe
  } 
}

# Guardamos los tweets originales en csv
write.csv(tweet_df, "tweets_originales.csv", quote = F, row.names = F)


