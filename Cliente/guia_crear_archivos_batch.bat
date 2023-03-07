::-------------------------------------------------------------------------------------------
:: GUIA CREACION ARCHIVO .BAT 
:: NIVEL: 		BÁSICO
:: FECHA:       22/02/2023
:: AUTOR: 		Julian A. Peña
:: VERSIÓN: 	1.0.0
:: SITIO: 		https://julian-pena-rua.github.io/cv/
:: DESCRIPCIÓN:	
:: 	Guía de cómo crear un programa Bat basado en los siguientes recursos:
::  	- https://www.cristalab.com/tutoriales/programacion-batch-con-archivos-.bat-c48410l/
::		- https://learn.microsoft.com/es-mx/windows-server/administration/windows-commands/echo
::      - https://github.com/Idnan/bash-guide
::		- https://github.com/Am0rphous/Bash
::		- https://learnxinyminutes.com/docs/es-es/bash-es/
::-------------------------------------------------------------------------------------------

:: elimina el eco, la repetición de la ruta en cada línea
@echo off 					


:: ==============
:: VARIABLES
:: ===============

:: Estáticas
set NombreAutor= Julian Andres Peña

:: Dinámicas, Si quieres que tu Variable sea dinámica, osea que el Usuario la elija antepones /p:
set /p NombreUsuario=Escriba su Nombre:
	
:: ==============
:: MENSAJE BIENVENIDA
:: ===============
:: imprime el mensaje después de echo
echo =============================================================
echo =								 
echo =	BIEVENIDO %NombreUsuario% AL MINI PROGRAMA BASH 	 
echo =				POR: %NombreAutor%		 
echo =============================================================	
:: pausa la ejecución y muestra mensaje "presione tecla para continuar"
pause						

:: ==============
:: OPERACIONES CON VARIABLES
:: ===============
set numero1=2
ser numero2=43
:: Podemos multiplicarlas, sumarlas, etc... con /a:
set /a suma= %numero1% + %numero2%  		
echo %suma%
pause

:: cierra ventana, termina ejecución
exit						
