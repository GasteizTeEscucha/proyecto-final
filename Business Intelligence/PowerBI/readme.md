# PoweBI
![imgPowerBi](https://github.com/GasteizTeEscucha/proyecto-final/blob/master/Business%20Intelligence/PowerBI/powerBi.jpg)
Microsoft Power BI permite la visualización de los datos a través herramientas de análisis, lo que le permite analizar y compartir la información fácilmente.

Una vez tenemos instalado MongoDB, hay que descargar e instalar el controlador DataDirect para MongoDB ODBC correspondiente a nuestra versión de Power BI.

Seguir las indicaciones de instalación y hacer click en Administrador ODBC, después seleccionar la pestaña de "Usuario DSN" o "Sistema DSN" y  pinchar el botón de "Agregar"

Seleccionar "DataDirect 8.0 MongoDB"

Ahora, se configura rellenando un nombre de origen de los datos, el host, el puerto y la base de datos dentro de MongoDB a la que queremos conectarnos (o puede dejarse en blanco). La ruta se generará automáticamente.

Una vez terminada la configuración, se puede crear un nuevo proyecto en Power Bi y conectar a la base de datos simplemente eligiendo la opción "ODBC">MongoDB dentro de la pestaña para elegir la fuente de los datos y elegir los que deseemos trabajar.