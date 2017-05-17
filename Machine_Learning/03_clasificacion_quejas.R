
###################   CLASIFICACIÓN DE QUEJA/NO-QUEJA    #####################

# Librería necesaria
library(e1071)
library(caret)
library(clusterSim)
library(RTextTools)
library(tm)

# Cargamos los datos
data <- read.csv("tweets_limpios.csv", header = T, sep = ";")
data$demanda <- as.factor(data$demanda)


### A) CORRECCIÓN DEL DESBALANCEO QUEJA/NO-QUEJA:

# Separamos quejas y no-quejas
queja <- data[which(data$demanda==1), ]
noqueja <- data[which(data$demanda==0), ]

# De la "noqueja" cogemos aleatoriamente la misma cantidad de tweets 
# que hay en "queja" (en este caso 209)
indexes <- sample(1:nrow(noqueja), size = 209) 
noqueja <- noqueja[indexes,]

# Juntamos los dos en uno y comprobamos que tienen la misma cantidad de tweets
data <- rbind(queja, noqueja)
table(data$demanda)

# Mezclamos el dataset:
data <- data[sample(nrow(data)), ]


### B) CREACIÓN DE LA MATRIZ TÉRMINO DOCUMENTO

# Creamos un corpus con todos los tweets y escogemos las palabras que se 
# repitan más al menos 2 veces para reducir la matriz 

texto <- as.character(data$tweet)
mycorpus <- Corpus(VectorSource(texto))
dtm1 <- DocumentTermMatrix(mycorpus)
keywords <- findFreqTerms(dtm1, 2)
dtm2 <- DocumentTermMatrix(mycorpus, control = list(dictionary=keywords))

# Convertimos la matriz creada a data.frame
datos <- data.frame(as.matrix(dtm2)) 

# Le añadimos una columna que contenga la clasificación "queja/no-queja"
# Se ha optado por llamar a esta nueva columna como "zzz" para asegurarnos
# que no sea una palabra que ya exista como columna en la matriz
datos$zzz <- as.factor(data$demanda) 
                                      
# Convertimos los datos a categóricos como 0 y 1 (ocurrencia):
conversion <- function(x) {
  y <- ifelse(x > 0, 1,0)
  y <- factor(y, levels=c(0,1))
  return(y)
}

dt_conv <- data.frame(apply(datos, 2, conversion))
dt_conv <- data.frame(apply(dt_conv,2,as.factor)) # factorizamos las columnas


### C) PRUEBA DE RESULTADOS CON NAIVE BAYES

# Creamos una función en la que utilizando "createMultiFolds" entrenamos el 
# modelo Naive Bayes repetidas veces hasta dar con el máximo de acierto

pruebabayes = function(datos,laplace){
  # set.seed(123)
  indice = createMultiFolds(datos$zzz, k = 5, times = 1)
  acierto = c()
  for (i in 1:length(indice)){
    datostra = datos[ indice[[i]],]
    datostst = datos[-indice[[i]],]
    
    modelo=naiveBayes(zzz~.,datostra,laplace = laplace)
    prediccion = predict(modelo, datostst, type="class")
    restst = confusionMatrix(prediccion, datostst$zzz)$overall[1]
    acierto = rbind(acierto,restst)
  }
  return(colMeans(acierto))
}

resultado = pruebabayes(dt_conv,1)
resultado

### D) ELECCIÓN DE MATRIZ DE ENTRENO

# Despues de dar con el mejor resultado, de la misma función anterior podemos
# sacar los siguientes objetos (cambiando el obejto en "return"):

nb_model <- resultado # modelo de entreno de Naive Bayes
save(nb_model, file = "nb_quejas.Rdata") # lo podemos guardar para futuras pruebas

# también guardamos la matriz de entreno por si lo queremos utilizar en alguna ocasión
train <- resultado # matriz de entreno
write.csv(train, "quejas_train.csv", quote = F, row.names = F)

# *** ten en cuenta que debes jugar con la función "set.seed" para conseguir 
# estos objetos en la ocasión en la que consigas el mayor acierto


### E) GUARDAR LAS PROBABILIDADES DE NAIVE BAYES

# Debemos guardar estos valores para su utilización en Spark

list_no <- vector()
list_yes <- vector()

for(i in 1:length(nb_model$tables)){
  list_no <- append(list_no, c(nb_model$tables[[i]][1], nb_model$tables[[i]][3]))
  list_yes<- append(list_yes, c(nb_model$tables[[i]][2],nb_model$tables[[i]][4]))
} 

palabras <- rep(colnames(dt_conv[-ncol(dt_conv)]), each=2)
ocurrencia <- rep(c(0,1), ncol(dt_conv)-1)
entreno <- data.frame("palabra" = palabras,"ocurrencia" = as.factor(ocurrencia),
                      "noqueja"=list_no , "queja" = list_yes)
apriori_df <- data.frame("palabra" = "apriori","ocurrencia"=as.factor(NA),
                         "noqueja" = 0.5, "queja"= 0.5)
entreno <- rbind(apriori_df, entreno)

write.csv(entreno, "quejas_NaiveBayes.csv", quote = F, row.names = F)


