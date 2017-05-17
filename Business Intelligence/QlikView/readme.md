# QlikView
![imgQlik](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Business%20Intelligence/QlikView/Qlik.PNG)
## Conexión de Qlik – MongoDB
 
 1) Antes de nada debemos instalar en nuestra máquina MondoDB y en esta ocasión se ha optado por instalar una interfaz como es RoboMongo.
 2) Después de instalar MongoDB, hay que arrancarlo a través de consola (Windows cmd) ? Ejecutar mongod.exe, de esta forma arrancaremos MongoDB.
 3) Ahora toca hacer la conexión en RoboMongo. Para esto necesitaremos conectar RoboMongo a nuestro Localhost mediante el puerto 127.0.0.1
 4) Ya tenemos MongoDB y la conexión funcionando, así que ahora pasamos a instalar la API de SIMBA para la conexión con BI.
 5) Una vez instalada la API, pasamos a configurar la conexión ODBC Administrador – agregar conexión DNS – SIMBA Mongo Sample. De esta forma ya tenemos el conector de 
 Mongo a Qlik encendido y configurado.
 6) Para finalizar sólo falta ir a QlikView y en el Script hacer una conexión ODBC que ya nos aparecerá en la lista. Una vez conectados, escogemos los datos de la BD +
 que queremos cargar y los procesamos.

## Cuadros de selección

Primeramente se han creado unos cuadros de selección para distinguir y acotar nuestras búsquedas. En esta primera fase de proyecto, se ha decidido agrupar las quejas 
por:
 1. Barrios
 2. Temas
 3. Localización de la queja
 4. Fecha

Una vez discernidos estos cuadros de selección, se han empezado a estudiar los datos que recoge el sistema a través de MongoDB.
Para la conexión de QlikViem con MongoDB se ha utilizado la API SIMBA en versión de prueba. Para ello, tendremos que seguir los siguientes pasos.

## Procesamiento de los Datos

Para empezar, se ha añadido un mapa para la localización de las quejas mediante conexión con la API de Yahoo y los campos ‘Longitud’ y ‘Latitud’.
Para finalizar se han ido añadiendo gráficos para el estudio de las quejas sacando porcentajes de los temas que más quejas generan, distinguiendo las quejas por 
barrios y un gráfico de tarta en el que se ha sacado los porcentajes de los tweets que sí son quejas y los que no.
