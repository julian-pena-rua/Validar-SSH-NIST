::-------------------------------------------------------------------------------------------
:: INSTALAR MODULO ANSICON
:: NIVEL: BASICO
:: 
:: AUTOR: 			Julian A. Peña
:: FECHA: 			1 MARZO 2023
:: VERSIÓN: 		1.0.0
:: SITIO: 			https://julian-pena-rua.github.io/cv/	
:: DESCRIPCIÓN:	
::			Este archivo de script verifica si Ansicon está instalado en el sistema comprobando 
::          si el archivo ansicon.exe se encuentra en la ruta predeterminada %ProgramFiles%\ANSICON\. 
::          Si el archivo existe, muestra un mensaje indicando que Ansicon ya está instalado. 
::          Si el archivo no existe, descarga la última versión de Ansicon desde GitHub utilizando PowerShell, 
::          descomprime el archivo descargado y lo instala utilizando el comando ansicon.exe -i. Luego, 
::          limpia los archivos temporales utilizados durante el proceso de instalación.
:: 	
::-------------------------------------------------------------------------------------------

@echo off
setlocal

rem Validar si Ansicon está instalado en el sistema
if exist "%ProgramFiles%\ANSICON\ansicon.exe" (
    echo Ansicon ya está instalado en el sistema.
    pause
) 
else (
rem Descargar la última versión de Ansicon desde GitHub
    echo Descargando la última versión de Ansicon...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/adoxa/ansicon/releases/download/v1.89/ansi189-bin.zip', 'ansi189.zip')"

rem Descomprimir el archivo descargado
    echo Descomprimiendo el archivo descargado...
    powershell -Command "Expand-Archive -LiteralPath ansi189.zip -DestinationPath ansicon"

rem Agregar ruta al PATH

	::set "RutaAnsicon=C:\MiPrograma"
	
	rem Valida si la ruta ya existe, sino la agrega
	::echo %PATH% | find /i "%RutaAnsicon%" > nul
	::if errorlevel 1 (
	::	set "PATH=%RutaAnsicon%;%PATH%"
	::	echo %PATH%
	::)


rem Instalar Ansicon
    echo Instalando Ansicon...
    cd ansicon
	cd x64
    ansicon.exe -i

rem Eliminar archivos temporales
    echo Limpiando archivos temporales...
    cd ..
	cd ..
    del ansi189.zip
    ::rmdir /s /q ansicon
	

    echo La instalación de Ansicon ha finalizado correctamente. El programa se cerrará automaticamente.
    pause
    exit
)