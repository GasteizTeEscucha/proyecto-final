
###################      CLASIFICACIÓN DE TEMA      #########################

# Seguimos los mismos pasos que con la clasificación de "queja/no-queja"
# excepto por el balanceo del dataset según la clasificación

# Librería necesaria
library(e1071)
library(caret)
library(clusterSim)
library(RTextTools)
library(tm)

# Cargamos los datos
data <- read.csv("data_tema.csv", header = T, sep = ";")
summary(data) # un vistazo a cuántos tweets son de cada temática


### A) CREACIÓN DE LA MATRIZ TÉRMINO DOCUMENTO

# Creamos un corpus con todos los tweets y escogemos las palabras que se 
# repitan más al menos 2 veces para reducir la matriz

texto <- as.character(data$tweet)
mycorpus <- Corpus(VectorSource(texto))
dtm1 <- DocumentTermMatrix(mycorpus)
keywords <- findFreqTerms(dtm1, 2)
length(keywords)
dtm2 <- DocumentTermMatrix(mycorpus, control = list(dictionary=keywords))
datos <- data.frame(as.matrix(dtm2))

# Convertimos los datos a categóricos como 0 y 1 (ocurrencia):
convert_count <- function(x) {
  y <- ifelse(x > 0, 1,0)
  y <- factor(y, levels=c(0,1))
  return(y)
}

dt_conv <- data.frame(apply(datos, 2, convert_count))
dt_conv <- data.frame(apply(dt_conv,2,as.factor)) # factorizamos las columnas

# Le añadimos una columna que contenga la clasificación     
dt_conv$zzz <- as.factor(data$tema)


### B) PRUEBA DE RESULTADOS CON NAIVE BAYES

pruebabayes = function(datos,laplace){
  #set.seed(123)
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

### C) GUARDAR DATOS

nb_model <- resultado # modelo de entreno de Naive Bayes
save(nb_model, file = "nb_temas.Rdata")

train <- resultado # matriz de entreno
write.csv(train, "temas_train.csv", quote = F, row.names = F)


# Tabla de probabilidades de Naive Bayes
list_admin <- vector()
list_deli <- vector()
list_esp <- vector()
list_lim <- vector()
list_mov<- vector()

for(i in 1:length(nm_model$tables)){
  list_admin <- append(list_admin, c(nm_model$tables[[i]][1], nm_model$tables[[i]][6]))
  list_deli <- append(list_deli, c(nm_model$tables[[i]][2], nm_model$tables[[i]][7]))
  list_esp <- append(list_esp, c(nm_model$tables[[i]][3], nm_model$tables[[i]][8]))
  list_lim <- append(list_lim, c(nm_model$tables[[i]][4], nm_model$tables[[i]][9]))
  list_mov <- append(list_mov, c(nm_model$tables[[i]][5], nm_model$tables[[i]][10]))
} 

palabras <- rep(colnames(full[-ncol(full)]), each=2)
ocurrencia <- rep(c(0,1), ncol(full)-1)
entreno <- data.frame("palabra" = palabras,"ocurrencia" = as.factor(ocurrencia),
                      "administracion"=list_admin , "delincuencia" = list_deli,
                      "espaciopublico" = list_esp, "limpieza"=list_lim,
                      "movilidad"=list_mov)

apriori_df <- data.frame("palabra" = "apriori","ocurrencia"=as.factor(NA),
                         "administracion"=0.12 , "delincuencia" = 0.14,
                         "espaciopublico" = 0.14, "limpieza"=0.24,
                         "movilidad"=0.36)
entreno <- rbind(apriori_df, entreno)

write.csv(entreno, "temas_NaiveBayes.csv", quote = F, row.names = F)

