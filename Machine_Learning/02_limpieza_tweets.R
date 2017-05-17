
###################        LIMPIEZA DE TWEETS          #####################

# Cargamos los datos de los tweets en sucio:
data <- read.csv("tweets_sucios_clasificados.csv", header = T, sep = ";")


### A) Limpieza de carácteres extraños:

limpieza <- function(x) {
  x = gsub("@\\w+", "", x) # elimina tags
  x = gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", x)  # elimina links
  x = gsub("[[:punct:]]", " ", x) # elimina signos de puntuacion
  x = gsub("[[:digit:]]", "\b", x) # elimina números
  x = gsub("[ |\t]{2,}", " ", x) # elimina tabs
  x = gsub("^ ", "", x)  # elimina espacios al principio
  x = gsub(" $", "", x)  # elimina espacios al final
  x = gsub("[^[:alnum:]///' ]", replacement = "", x) # elimina carácteres no alfanúmericos
  x = tolower(x)  # pasarlo a minúsculas
  x = gsub("^\\s*<U\\+\\w+>\\s*", "", x)  # elimina emoticonos
  x = gsub(" +", " ", x)  # elimina espacios en blanco
}

# En la función "clean_text" debemos meter como "x" los tweets
texto <- data$tweet
texto_limpio <- limpieza(texto)


### B) Lematizacion de las palabras:

# En la funcion "lematizador" debemos meter como "x" los textos de
# los tweets tokenizados (es decir, separando las palabras)
# y como "y" el diccionario

lematizador <- function(x, y){
  res <- list()  
  for(j in 1:length(x)){
    frase_lematizada <- vector()
    length_tweet <- length(x[[j]])
    for(i in 1:length_tweet){
      if(x[[j]][i] %in% y$palabra){
        frase_lematizada[i] <- as.character(y$lema[match(x[[j]][i], y$palabra)])
      }else{
        frase_lematizada[i] <- x[[j]][i]
      }
      resultado <- paste(frase_lematizada, collapse = " ")
    }
  res[j] <- resultado
  }
  return(unlist(res))
}

# Cargamos el fichero que contiene el diccionario de palabras:
diccionario <- read.csv("diccionario.csv", header = T, sep = ";")

# Separamos cada tweet por palabras:
tw_token <- strsplit(texto_limpio, " ")

# Lematizacion:
texto_lematizado <- lematizador(tw_token, diccionario)


### C) Eliminar palabras comunes ("stopwords"):

# Para esta fase utilizamos la libreria "tm"
library(tm)

# Debemos crear un corpus con nuestro texto y luego eliminar los stopwords
mycorpus <- Corpus(VectorSource(texto_lematizado))
mycorpus <- tm_map(mycorpus, removeWords, stopwords("spanish"))
texto_final <- mycorpus$content

# Eliminamos espacios en blanco que se hayan podido crear
texto_final <- gsub(" +", " ", texto_final)
texto_final <- gsub("^ ", "", texto_final) 
texto_final <- gsub(" $", "", texto_final) 
                                            
head(texto_final,5) # comprobamos el resultado

data_resultado <- data.frame("tweet"=texto_final, "demanda" = data$demanda, "tema"=data$tema)



write.csv(data_resultado, "tweets_limpios.csv", quote = F, row.names = F) 
  


