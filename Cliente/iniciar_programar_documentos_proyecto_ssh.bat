::-------------------------------------------------------------------------------------------
:: EJECUTAR PRORAMAS DE PROYECTO SSH
:: NIVEL: 		BÁSICO
:: FECHA:       22/02/2023
:: AUTOR: 		Julian A. Peña
:: VERSIÓN: 	1.0.0
:: SITIO: 		https://julian-pena-rua.github.io/cv/
:: DESCRIPCIÓN:	
:: 	Guía de cómo crear un programa Bat
::  	https://www.cristalab.com/tutoriales/programacion-batch-con-archivos-.bat-c48410l/
::		https://learn.microsoft.com/es-mx/windows-server/administration/windows-commands/echo
::-------------------------------------------------------------------------------------------

:: elimina el eco, la repetición de la ruta en cada línea
	@echo off 					


:: ==============
:: VARIABLES
:: ===============

:: Estáticas
	set NombreAutor=Julian Andres Peña
	set Version=1.0.0

:: Dinámicas, Si quieres que tu Variable sea dinámica, osea que el Usuario la elija antepones /p:
	::set /p NombreUsuario=Escriba su Nombre:
	
:: ==============
:: MENSAJE BIENVENIDA
:: ===============
:: imprime el mensaje después de echo
	echo =============================================================
	echo =								 
	echo =	BIEVENIDO %NombreUsuario% AL MINI PROGRAMA BASH 
	echo = 	ESTE PROGRAMA SE ENCARGA DE AUTOMATIZAR EJECUCIÓN 
	echo =	DE PROGRAMAR Y DOCUMENTOS REQUERIDOS PARA PROYECTO SSH
	echo =				POR: 		%NombreAutor%		 
	echo =				VERSION: 	%Version%		 
	echo =============================================================	

:: pausa la ejecución y muestra mensaje "presione tecla para continuar"
	pause						


:: ==============
:: INICIAR PROCESOS
:: ===============

	:: Mensaje de carga de programas
	echo Cargando los programas...
	:: Mensaje de avance en carga de programas
	echo "#####                     (33%)"
		:: Documento OneNote - Cuaderno ingeniero
		start "https://comunidadiushedu.sharepoint.com/:o:/s/Grupo_GEPI/Ekmx86jehu5Cv8P6gfycsV0BMr9ZN7hHUarsOx-w4g4GtQ?e=mw2ybY"
		:: Documento Word - Instalar Servidor SSH
		start microsoft-edge:"https://comunidadiushedu.sharepoint.com/:w:/s/Grupo_GEPI/EUqU4W4ZCXNAsq0qWjvNg7UBzCMK3mhwyJvEiKQycTVL8A?e=xkeLv0"
		:: Documento Excel- Configuraciones SSH
		start microsoft-edge:"https://comunidadiushedu.sharepoint.com/:x:/s/Grupo_GEPI/EaAHis5RHWpAm58qBGsF4loBSumE2NRESksdk7P3DwrV2w?e=lImSCO"
		

	echo "#############             (66%)"
		:: Documento Word - Programa GEPI 2021
		start microsoft-edge:"https://comunidadiushedu.sharepoint.com/:w:/s/Grupo_GEPI/EXJX99ES0h9OgUTKJT7jDfMBKcPPwyempSj3BGx8EhroTQ?e=28W3li"
		:: Documento Word - Derrotero
		start microsoft-edge:"https://comunidadiushedu.sharepoint.com/:w:/s/Grupo_GEPI/EYhpHm_4UtBBt0hr3bwPs78BFBUKTOuQfyZLQVzZyFh7Hg?e=CgIXCI"
		
		start microsoft-edge:"www.google.com"
	
	echo "###################       (86%)"
		:: Visual Studio Code en Carpeta de proyecto
		start code C:\Users\Usuario\Desktop\bash_codes

	:: Mensaje de finalización de carga de programas
	echo "#######################   (100%)"

	echo "\n"
	echo Carga de programas completa
	pause


:: ==============
:: MATAR PROCESOS
:: ===============

	echo =============================================================
	echo =								 
	echo =	CERRANDO PROCESOS DE MINI PROGRAMA BASH 	 
	echo =								 
	echo =============================================================	

:: /f Fuerza el término del proceso.
	::taskkill /f /im vscode C:\xampp\htdocs\HistoriasClinicasVeterinarias-POO 		

	pause

:: ==============
:: FIN DE EJECUCIÓN
:: ===============

	echo =============================================================
	echo =								 
	echo =	SALIENDO DE MINI PROGRAMA BASH 	 
	echo =				POR: 		%NombreAutor%		 
	echo =				VERSION: 	%Version%		 
	echo =============================================================	
	
	pause

:: cierra ventana, termina ejecución
	exit