# Nifi
![imgnifi9](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi9.jpg)
# Instalación y configuración
Entrar en Ambari: http://127.0.0.1:8080
![imgnifi1](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi1.jpg)
Instalar el servicio de NiFi 1.0 (Actions----Add Service), de esta manera la máquina virtual abre los puertos 9090 para la comunicación. Una vez arrancado se para el servcio.
![imgnifi2](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi2.jpg)
![imgnifi3](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi3.jpg)
![imgnifi4](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi4.jpg)
Se descarga el nuevo NiFi mediante un wget http://apache.uvigo.es/nifi/1.2.0/nifi-1.2.0-bin.tar.gz a la carpeta /opt/
Descomprimir :
cd opt/
tar zxf nifi-1.2.0-bin.tar.gz
Se configura el archivo /opt/nifi-1.2.0/conf/nifi.propierties:
nifi.remote.input.socket.port=9098
nifi.web.http.port=9090
Si no se tiene java instalado, se instala:
	yum install java
	export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk-1.8.0.131-2.b11.el7_3.x86_64
Activar el servicio automáticamente siempre para los posibles reinicios
sudo chkconfig nifi on
Y se ejecuta /opt/nifi-1.2.0/bin/nifi.sh start
Se espera 30-60 segundos ya que arrancar el servicio de NiFi tarda un rato.
Se entra por web http://127.0.0.1:9090/nifi/

![imgnifi5](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi5.jpg)

Se descarga la “template.xml” realizada para este proyecto y se carga en NiFi. Primero se busca la template, se carga y luego se carga en la Dashboard la template.

![imgnifi6](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi6.jpg)
![imgnifi7](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi7.jpg)
![imgnifi8](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/NiFi/imagenesNifi/nifi8.jpg)

Dar al Play. NiFi arrancará todos los procesadores y empezará a funcionar.
**Crear dos carpetas dentro de /opt/nifi-1.2.0/ para recoger los archivos de tráfico y climatología.
cd /opt/nifi-1.2.0/
mkdir trafico
mkdir tiempo
