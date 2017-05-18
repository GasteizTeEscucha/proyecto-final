# Big Data - Clasificador de tweets en tiempo real
# ![imgnifi10](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/img/Diagram0.png)
Repositorio del proyecto final del curso Big Data y Business Intelligence de Vitoria-Gasteiz.
</br></br>
El proyecto surge como iniciativa de los propios alumnos, al ver posibilidad de gestionar de forma más eficaz las demandas de los usuarios en redes sociales en relación con organismos gubernamentales.
</br></br>
Se trata de un proyecto Big Data completo, donde se analizan tweets en tiempo real y mediante técnicas de machine learning los clasifican como queja o no_queja. Una vez clasificados se proporciona una visualización del análisis en diversas herramientas Business Intelligence. 
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
</br>
Equipo:
</br></br>
[Daniel Álvarez](https://www.linkedin.com/in/danielalvarezlopez/): Arquitectura con Hortonworks, Kafka, Spark y Nifi.</br>
[Jesús Fuerte](https://www.linkedin.com/in/jesus-fuerte-fernandez/): Arquitectura con Hortonworks, Kafka, Spark y Nifi.</br>
[Arkaitz Merino](https://www.linkedin.com/in/arkaitz-merino/): Programador Spark/Python.</br>
[Oscar Bartolomé](https://www.linkedin.com/in/obartolomep/): Programador Spark/Python.</br>
[Helton Borges](https://www.linkedin.com/in/heltonborges/): Programador Spark/Python.</br>
[Unai Barredo](https://www.linkedin.com/in/ubarredo/): Machine Learning con Python.</br>
[Odei Barredo](https://www.linkedin.com/in/odeibarredo/): Machine Learning con R.</br>
[Alexander Somovilla](https://www.linkedin.com/in/alexsomovilla/): Machine Learning con R.</br>
[Mikel Ramos](https://www.linkedin.com/in/mikel-ramos-6b5805107/): Bases de datos con MongoDB.</br>
Virginia Esquinas: Bases de datos con MongoDB.</br>
[Blanca Soto](https://www.linkedin.com/in/blanca-soto-salvador-a25b35134/): Bases de datos con MongoDB.</br>
[Esperanza García](https://www.linkedin.com/in/esperanza-garcia-moreno/): Divulgación en medios y documentación.</br>
[Jorge Iñiguez De Ciriano](https://www.linkedin.com/in/jorgeiniguez/): Documentación y diseño de BI.</br>
[Mónica Vázquez](https://www.linkedin.com/in/monicavazquezmu%C3%B1oz/): Branding y comunicación.</br> 
[Daniel Redondo](https://www.linkedin.com/in/daniel-redondo-iglesias/): Visualización y reporting con QlikView.</br>
[Miriam Insagurbe](https://www.linkedin.com/in/miriam-insagurbe-davies/): Visualización y reporting con Power BI. </br>
[Julen Manzano](https://www.linkedin.com/in/julenmanzano/): Tutor
# ![imgequipo](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/img/fotoequipo.jpg)
