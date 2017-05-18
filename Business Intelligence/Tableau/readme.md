# Tableau
# ![imgtableau](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Business%20Intelligence/Tableau/tableau.png)
El primer paso es instalar el conector MongoDB para BI. El conector y sus utilidades asociadas forman parte de MongoDB Enterprise Advanced.
Una vez completada la descarga, basta con descomprimir e instalar los paquetes que contiene.  
El siguiente paso es crear un usuario para el conector mediante la utilidad mongobiuser. Al comando create hay que pasarle el nombre del usuario y la conexión al servidor mongo, incluyendo el nombre del host, el puerto, y la base de datos donde se encuentran los datos que se desea utilizar. En nuestro caso el usuario se llamará usuariobi, y utilizaremos la base de datos bi del servidor que está corriendo en la máquina mongobi:

El conector necesita un fichero que mapee la estructura de los documentos MongoDB a un esquema relacional utilizando el DRDL.

Para generarlo automáticamente se utiliza el comando mongodrdl. Este comando necesita saber el nombre de la base de datos y, opcionalmente, el nombre de la colección, así como el nombre del fichero de salida, que en este caso es bi_estaciones.drdl

El último paso consiste en importar el fichero con el esquema en el conector, para lo que se utiliza la utilidad mongobischema. Al comando import hay que indicarle el nombre del usuario del conector y el fichero drdl en el que está almacenado el esquema.
Los datos ya están listos para ser utilizados desde Tableau. La conexión con la base de datos se realiza con el conector para PostgreSQL, y los datos dentro de la herramienta se pueden usar como si estuviesen almacenados en tablas relacionales

