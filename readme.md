# Big Data - Clasificador de tweets en tiempo real
Repositorio del proyecto final del curso Big Data y Business Intelligence de Vitoria-Gasteiz.
</br></br>
El proyecto surge como iniciativa de los propios alumnos, al ver posibilidad de gestionar de forma más eficaz las demandas de los usuarios en redes sociales (en este caso, Twitter) en relación con organismos gubernamentales.
</br></br>
Se trata de una proyecto Big Data completo, donde se analizan tweets en tiempo real y mediante técnicas de machine learning los clasifican como queja o no_queja. Un vez clasificados proporciona una visualización del análisis en diversas herramientas Business Intelligence. 
</br></br></br>
### Herramientas:
* [Servidor Hortonworks](https://github.com/GasteizTeEscucha/proyecto-final/tree/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB)
* [Apache Nifi](https://github.com/GasteizTeEscucha/proyecto-final/tree/master/NiFi)
* Apache Kafka
* [Apache Spark: PySpark, Spark Streaming](https://github.com/GasteizTeEscucha/proyecto-final/tree/master/Spark)
* [Machine Learning: Algoritmo Naive Bayes](https://github.com/GasteizTeEscucha/proyecto-final/tree/master/Machine_Learning)
* Base de datos NoSQL: MongoDB
* [Business Intelligence: QlikView, Tableau, PowerBI](https://github.com/GasteizTeEscucha/proyecto-final/tree/master/Business%20Intelligence)
</br></br>
### El proyecto tiene la siguiente estructura:
* Mediante la API de Twitter se establece un streaming de tweets con Nifi.
* Se cargan lo tweets desde Nifi a Kafka.
* Mediante Spark Streamin se establece un streaming de tweets con Kafka.
* Se hace una predicción mediante un algortimo Naive Bayes Classifier que clasifica los tweets (queja, no_queja).
* Los tweets clasificados se cargan en Kafka mediante un Producer en PySpark.
* Con Nifi se cargan los tweets clasificados desde Kafka a MongoDB.
* Desde las herramientas de Business Intelligence se utiliza la API Simba para establecer una conexión con MongoDB para la visualización   de los datos.
</br></br>
</br></br>
</br>
Organización del equipo:
</br></br>
Daniel Álvarez: Arquitectura con Hortonworks, Kafka, Spark y Nifi.</br>
Jesús Fuerte: Arquitectura con Apache Nifi y Hortonworks.</br>
Arkaitz Merino: Development con Spark.</br>
Oscar Bartolomé: Development con Spark.</br>
Helton Borges: Development con Spark.</br>
Unai Barredo: Machine Learning con Python.</br>
Odei Barredo: Machine Learning con R.</br>
Alexander Somovilla: Machine Learning con R.</br>
Mikel Ramos: Bases de datos con MongoDB.</br>
Virginia Esquinas: Bases de datos con MongoDB.</br>
Blanca Soto: Bases de datos con MongoDB.</br>
Esperanza García: Divulgación en medios y documentación.</br>
Jorge Iñiguez De Ciriano: Documentación y diseño de BI.</br>
Mónica Vázquez: Branding y comunicación.</br> 
Daniel Redondo: Visualización y reporting con QlikView.</br>
Miriam Insagurbe: Visualización y reporting con Power BI. </br>
