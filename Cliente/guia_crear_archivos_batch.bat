::-------------------------------------------------------------------------------------------
:: GUIA CREACION ARCHIVO .BAT 
:: NIVEL: 					BÁSICO
:: AUTOR: 					Julian A. Peña
:: VERSIÓN: 				1.0.0
:: FECHA CREACIÓN:       	22/02/2023
:: FECHA MODIFICACIÓN:   	13/03/2023
:: SITIO: 					https://julian-pena-rua.github.io/cv/
:: DESCRIPCIÓN:
:: 	NO ES UN ARCHIVO EJECUTABLE REAL	
:: 	Guía de cómo crear un programa Bat basado en los siguientes recursos:
::  	- https://www.cristalab.com/tutoriales/programacion-batch-con-archivos-.bat-c48410l/
::		- https://learn.microsoft.com/es-mx/windows-server/administration/windows-commands/echo
::-------------------------------------------------------------------------------------------

:: Como te habrás dado cuenta, los comentarios en Batch Shell empiezan con ::

:: ==============
:: MENSAJES POR CONSOLA
:: ===============
:: Ejemplo sencillo para imprimir hola mundo:
echo "¡Hola mundo!"

:: Cada comando empieza con una nueva línea, o después de un punto y coma:
echo 'Esta es la primera línea'; echo 'Esta es la segunda línea'

:: elimina el eco, la repetición de la ruta en cada línea
@echo off 					

echo 'Soy una línea que no muestra ruta' 

:: limpia la pantalla dejandola en blanco	
cls 

echo 'Hola mundo. Soy una nueva línea en la pantalla'

:: ==============
:: MENSAJES CON ESPAPE DE CARACTERES ESPECIALES
:: ===============
:: En Windows cmd, puede usar el comando echo junto con códigos de escape ANSI 
:: para mostrar texto con diferentes colores.
echo =============================================================
echo =								 
echo =	^[[31mTexto en rojo^[[0m
echo =				POR: Julian A. Peña
echo =				VER: 1.0.0
echo =============================================================	

:: Donde ^[[31m es el código de escape ANSI para el color rojo y
:: ^[[0m es el código para restablecer el color a su valor predeterminado.
:: Aquí hay algunos otros códigos de escape ANSI para diferentes colores:
::		Rojo: 		^[[31m
::		Verde: 		^[[32m
::		Amarillo: 	^[[33m
::		Azul: 		^[[34m
::		Morado: 	^[[35m
::		Cian: 		^[[36m

:: También puede combinar códigos de escape para crear diferentes efectos, 
:: como texto en negrita, subrayado o invertido. Por ejemplo, para mostrar 
:: texto en negrita y rojo, puede utilizar el siguiente comando:
echo ^[[1;31mTexto en negrita y rojo^[[0m

:: Aquí hay algunos otros códigos de escape ANSI para diferentes efectos:
::		Negrita: 	^[[1m
::		Subrayado: 	^[[4m
::		Invertido: 	^[[7m

:: NOTA Es posible que el símbolo de acento circunflejo (^) 
:: no se muestre correctamente en su sistema, lo que puede hacer que los 
:: códigos de escape ANSI no funcionen.

:: ==============
:: INTERRUMPIR EJECUCIÓN CONSOLA
:: ===============

:: pausa la ejecución y muestra mensaje "presione tecla para continuar"
pause					
:: pausa ejecución tiempo determinado (8 segundos) permitiendo presionar tecla para continuar
timeout /t 8
:: pausa ejecución tiempo determinado (5 segundos) 
timeout /t 5 /nobreak>nul

:: ==============
:: VARIABLES
:: ===============

:: Para declarar una variable se hace lo siguiente:
:: Estáticas
set NombreAutor="Julian Andres Peña"
:: Pero no así:
set NombreAutor = "Julian Andres Peña"

:: Usando la variable:
echo %VARIABLE%
echo "%VARIABLE%"
echo '%VARIABLE%'

:: Cuando la variable es usada - o asignada, exportada, etcétera - se
:: escribe su nombre sin %. Si se quiere saber el valor de la variables,
:: entonces sí se usa $. Note que ' (comilla simple) no expandirá las 
:: variables.	

:: Dinámicas, Si quieres que tu Variable sea dinámica, osea que el Usuario la elija antepones /p:
echo "¿Cuál es tu nombre?"
:: Note que no necesitamos declarar una variable como otros lenguajes
set /p NombreUsuario=Escriba su Nombre:

:: ==============
:: MENSAJES POR CONSOLA PERSONALIZADOS
:: ===============
:: imprime el mensaje después de echo
echo =============================================================
echo =								 
echo =	BIEVENIDO %NombreUsuario% AL MINI PROGRAMA BASH 	 
echo =				POR: %NombreAutor%		 
echo =============================================================					

:: ==============
:: OPERACIONES CON VARIABLES
:: ===============
set numero1=2
set numero2=43
:: Podemos multiplicarlas, sumarlas, etc... con /a:
set /a suma= %numero1% + %numero2%  		
echo %suma%
pause


:: ==============
:: FINALIZAR LA EJECUCIÓN 
:: ===============
:: cierra ventana, termina ejecución
exit						


:: ==============
:: OPERACIONES TIPO SHELL
:: ===============
:: A diferencia de otros lenguajes de programación, batch es shell , así que
:: funciona en un contexto de directorio actual. 
:: Puedes listar archivos y directorios en un directorio actual con el comando 'dir':
dir

:: Estos comandos tienen opciones que controlan su ejecución:
dir /a

:: ==============
:: OPERACIONES CON CONDICIONALES IF
:: ===============
:: La "condición" es una expresión que se evalúa como verdadera o falsa. 
:: Puede haber varias formas de expresar una condición, incluyendo:
:: 		EQU: Igual a. Por ejemplo, IF %var1% EQU %var2% (comando)
:: 		NEQ: No igual a. Por ejemplo, IF %var1% NEQ %var2% (comando)
::		LSS: Menor que. Por ejemplo, IF %var1% LSS %var2% (comando)
::		LEQ: Menor o igual que. Por ejemplo, IF %var1% LEQ %var2% (comando)
::		GTR: Mayor que. Por ejemplo, IF %var1% GTR %var2% (comando)
::		GEQ: Mayor o igual que. Por ejemplo, IF %var1% GEQ %var2% (comando)
set /p edad=Introduce tu edad: 
if %edad% GEQ 18 (
  echo Es mayor de edad
) else (
  echo Es menor de edad
)
:: También puede utilizar operadores lógicos para combinar múltiples 
:: condiciones. Algunos de los operadores lógicos que se pueden utilizar son:
:: 		&&: Y. Ejecuta el comando siguiente solo si la condición anterior se 
::		evalúa como verdadera. Por ejemplo, IF %var1% EQU %var2% && comando
::		||: O. Ejecuta el comando siguiente solo si la condición anterior se 
::		evalúa como falsa. Por ejemplo, IF %var1% NEQ %var2% || comando
set /p edad=Introduce tu edad: 
set /p voto=¿Has ejercido el derecho al voto? (s/n): 

if %edad% GEQ 18 (
  echo Es mayor de edad
  if /i "%voto%"=="s" (
    echo Puede reclamar carrito sanduchero
  ) else (
    echo No puede reclamar carrito sanduchero
  )
) else (
  echo Es menor de edad
)
:: Nota: La opción /i se utiliza en la segunda comparación de la condición 
:: del comando IF para hacer que la comparación sea insensible a mayúsculas 
:: y minúsculas. Esto significa que tanto "s" como "S" serán aceptados como 
:: respuesta válida.
  
:: ==============
:: OPERACIONES CON CONDICIONALES CASE NO EXISTE ESTRUCTURA EN BATCH
:: ===============
:: Se puede simular con mútilples sentencias IF
set /p dia=Introduce un número del 1 al 7: 

if %dia% EQU 1 (
  echo Lunes
) else if %dia% EQU 2 (
  echo Martes
) else if %dia% EQU 3 (
  echo Miércoles
) else if %dia% EQU 4 (
  echo Jueves
) else if %dia% EQU 5 (
  echo Viernes
) else if %dia% EQU 6 (
  echo Sábado
) else if %dia% EQU 7 (
  echo Domingo
) else (
  echo El número debe estar entre 1 y 7
)

:: ==============
:: OPERACIONES CON CICLOS FOR
:: ===============
:: El comando FOR se utiliza para repetir una serie de comandos para un rango de valores. 
:: En este caso, el comando FOR se configura con la opción /l para indicar que se repetirá 
:: un conjunto de comandos un número de veces especificado por un rango de números.
:: La sintaxis del comando FOR /L es la siguiente: 
::		for /l %%variable in (inicio, incremento, final) do (comando). 
::	Donde:
:: 		%%variable es una variable que se utiliza para almacenar el valor actual del rango.
::		inicio es el valor inicial del rango.
::		incremento es la cantidad en la que se incrementará la variable para cada iteración.
::		final es el valor final del rango.
for /l %%i in (1,1,30) do (
  echo Línea número %%i
)
:: En el ejemplo anterior, la variable %%i se utiliza para almacenar el valor actual del 
:: rango que comienza en 1, se incrementa en 1 en cada iteración, y finaliza en 30. 
:: El comando ECHO se utiliza para imprimir una línea de texto que indica el número 
:: de línea actual.

::Nota: En Batch, se utilizan dos símbolos de porcentaje (%%) para hacer referencia a una 
:: variable dentro de un bucle FOR. Si se utiliza el comando FOR en la línea de comandos 
:: en lugar de dentro de un script, se debe usar un solo símbolo de porcentaje (%).


:: ==============
:: OPERACIONES CON CICLOS WHILE NO EXISTE ESTRUCTURA EN BATCH
:: ===============
:: Se puede simular con estructura FOR
set /p opcion=Introduce una opción (escribe "salir" para salir): 

for /f "tokens=*" %%i in ("%opcion%") do (
  if /i "%%i"=="salir" (
    echo Saliendo del menú...
  ) else (
    echo Opción seleccionada: %%i
    echo Menú de opciones
	echo 1. Opción 1
	echo 2. Opción 2
	echo 3. Opción 3
	echo 4. Salir
	echo.
	set /p opcion=Introduce una opción (escribe "salir" para salir): 
  )
)


:: ==============
:: OPERACIONES CON FUNCIONES
:: ===============
:: Subrutinas (Funciones y procedimientos)
:: Los comandos CALL y GOTO se utilizan para llamar a las funciones y saltar a etiquetas 
:: dentro del mismo script. 
:: eof es una etiqueta predefinida en Windows Batch que significa "end of file" o "fin de archivo". 
:: Se utiliza para indicar el final de un script Batch y se puede usar para saltar al final 
:: de un archivo de script sin necesidad de especificar una línea específica de código.

:: un ejemplo de un script Batch que utiliza funciones para imprimir un menú y 
:: una pantalla de inicio (splash screen):
call :splash
call :menu
goto :eof

:splash
cls
echo ========================================
echo =              Mi Aplicación            =
echo ========================================
echo.
echo Cargando...
ping -n 2 127.0.0.1 > nul
echo.
goto :eof

:menu
cls
echo ========================================
echo =                Menú Principal         =
echo ========================================
echo.
echo 1. Opción 1
echo 2. Opción 2
echo 3. Opción 3
echo 4. Salir
echo.
set /p opcion=Introduce una opción:

if "%opcion%"=="1" call :opcion1 & goto :menu
if "%opcion%"=="2" call :opcion2 & goto :menu
if "%opcion%"=="3" call :opcion3 & goto :menu
if "%opcion%"=="4" goto :eof

echo Opción inválida.
pause
goto :menu

:opcion1
cls
echo Has seleccionado la opción 1.
pause
goto :eof

:opcion2
cls
echo Has seleccionado la opción 2.
pause
goto :eof

:opcion3
cls
echo Has seleccionado la opción 3.
pause
goto :eof