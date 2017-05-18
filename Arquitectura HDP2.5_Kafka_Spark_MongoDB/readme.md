
# Instalación de Arquitectura
1.	Instalar Hortonworks (HDP 2.5) en Virtualbox SandBox VM y encenderla.
2.	Conectar por ssh con la VM. 127.0.0.1, puerto 2222, user:root, password:hadoop
3.	Te pide password nuevo. Una vez realizado esto, se hace un ambari-admin-password-reset 
4.	Una vez realizado esto, ya se puede entrar a http://127.0.0.1:8080/ y hacer login como admin/password nuevo.

![Image1](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari1.png)

5.	Desde Ambari, selecciona desde el menú Kafka

![Image2](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari2.png)

6.	Click en Kafka Broker

![Image3](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari3.png)

7.	Selecciona Start desde el menú de Kafka Borker

![Image4](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari4.png)

8.	Se espera unos segundos hasta que arranque todo

![Image5](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari5.png)

9.	Después de esto, ir a Spark > Config > Advanced spark-log4j-properties
Y cambiar donde pone:
log4j.rootCategory=INFO -----> log4j.rootCategory=ERROR


![Image6](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari6.png)

10.	Click en Save y hacer un Restart All Components

![Image7](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari7.png)

**Por defecto, el servicio de Spark ya viene iniciado, si por lo que fuese no fuera así, seguir los mismos pasos de Kafka (5,7 y 8) pero para Spark.

11.	Crear el fichero /etc/yum.repos.d/mongodb-org-3.2.repo para la instalación mediante yum.
12.	Entrar en el fichero creado, escribir y guardar:
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
13.	Instalar el repositorio creado de MongoDB
sudo yum install -y mongodb-org
14.	Arrancar el servicio
sudo service mongod start
15.	Para que arranque el servicio automáticamente
sudo chkonfig mongod on
16.	Instalar el servicio de MongoDB en Ambari para una mejor gestión.
cd /var/lib/ambari-server/resources/stacks/HDP/2.5/services
git clone https://github.com/nikunjness/mongo-ambari.git
sudo service ambari restart
sudo service ambari-server restart
17.	Dentro del Dashboard de Ambari
Actions -> Add service -> check MongoDB -> Next -> Next -> Next -> Deploy


![Image8](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari8.png)
![Image9](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari9.png)
![Image10](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari10.png)
![Image11](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari11.png)
![Image12](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari12.png)

18.	Una vez instalado con éxito, el servicio aparecerá a la derecha de Ambari.

![Image13](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari13.png)

19.	Cambiaremos el puerto de MongoDB. Hay que ir a la pestaña de configuración y vemos que por defecto es el 27017. Le pondremos el puerto 8993. Éste es el puerto por defecto de Solr pero como en este proyecto no lo usamos, aprovechamos que la VM lo tiene abierto para que MongoDB establezca conexión por ese puerto.

![Image14](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari14.png)
![Image15](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Arquitectura%20HDP2.5_Kafka_Spark_MongoDB/Ambari/ambari15.png)

** A veces con Ambari hay problemas con el servicio de mongodb (suele suceder cuando paras de golpe la VM), te dice que está encendido pero no es así. Para solucionar esto hay que hacer:
	cd /var/run/mongodb
	rm mongodb.pid
	sudo chown mongod:mongod /tmp/mongodb-8993.sock

** Si se descuadra la hora de la máquina virtual con la de la localización hacer lo siguiente:
        rm -f /etc/localtime
	ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
