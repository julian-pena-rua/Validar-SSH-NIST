#!/bin/bash
# La primera línea del script es el [shebang](http://en.wikipedia.org/wiki/Shebang_(Unix)) que le indica al sistema 
# cómo ejecutar el script.
#-------------------------------------------------------------------------------------------
# GUIA CREACION ARCHIVO .BAT 
# NIVEL: 				BÁSICO
# AUTOR: 				Julian A. Peña
# VERSIÓN: 				1.0.0
# FECHA CREACIÓN:       22/02/2023
# FECHA MODIFICACIÓN:   07/03/2023
# SITIO: 				https://julian-pena-rua.github.io/cv/
# DESCRIPCIÓN:	
# 	Guía de cómo crear un programa Bat basado en los siguientes recursos:
#       - https://github.com/Idnan/bash-guide
#		- https://github.com/Am0rphous/Bash
#		- https://learnxinyminutes.com/docs/es-es/bash-es/
#-------------------------------------------------------------------------------------------
		
# Como te habrás dado cuenta, los comentarios en shell empiezan con #.

# Ejemplo sencillo para imprimir hola mundo:
echo "¡Hola mundo!"

# Cada comando empieza con una nueva línea, o después de un punto y coma:
echo 'Esta es la primera línea'; echo 'Esta es la segunda línea'

# ==============
# VARIABLES
# ===============

# Para declarar una variable se hace lo siguiente:
VARIABLE="Mi string"

# Pero no así:
VARIABLE = "Mi string"

# Variables constantes, o llamadas Estáticas
NombreAutor="Julian Andres Peña"
	
# Usando la variable:
echo $VARIABLE
echo "$VARIABLE"
echo '$VARIABLE'

# Cuando la variable es usada - o asignada, exportada, etcétera - se
# escribe su nombre sin $. Si se quiere saber el valor de la variables,
# entonces sí se usa $. Note que ' (comilla simple) no expandirá las 
# variables.	

# Para leer un valor del input, también llamadas variables Dinámicas
echo "¿Cuál es tu nombre?"
read NombreUsuario # Note que no necesitamos declarar una variable como otros lenguajes

clear # limpia la pantalla dejandola en blanco	
	
# ==============
# IMPRIMIENDO MENSAJES
# ===============
# imprime el mensaje después de echo
echo =============================================================
echo =								 
echo =	BIEVENIDO $NombreUsuario AL MINI PROGRAMA BASH 	 
echo =				POR: $NombreAutor		 
echo =============================================================	
# pausa la ejecución y muestra mensaje "presione tecla para continuar"
pause						

clear

# ==============
# OPERACIONES CON VARIABLES
# ===============
set numero1=2
ser numero2=43
# Podemos multiplicarlas, sumarlas, etc... con /a:
set /a suma= %numero1% + %numero2%  		
echo %suma%
pause

# ==============
# OPERACIONES TIPO SHELL
# ===============
# A diferencia de otros lenguajes de programación, bash es shell , así que
# funciona en un contexto de directorio actual. 

# Puedes listar archivos y directorios en un directorio actual con el comando 'ls':
ls

# Estos comandos tienen opciones que controlan su ejecución:
ls -l # Lista todos los archivos y directorios en líneas distintas.


# ==============
# OPERACIONES CON CONDICIONALES IF
# ===============
# Tenemos la estructura 'if' usual:
# use 'man test' para más información sobre condicionales

if [ $NombreUsuario -ne $USER ]
then
    echo "Tu nombre es tu usuario."
else
    echo "Tu nombre no es tu usuario."
fi

# También hay ejecuciones condicionadas.
echo "Siempre ejecutado" || echo "Sólo ejecutado si el primer comando falla"
echo "Siempre ejecutado" && echo "Sólo ejecutado si el primer comando NO falla"

# Para usar && y || con condicionales, se necesitan 
# múltiples pares de corchetes:
if [ $NombreUsuario == "Steve" ] && [ $EDAD -eq 15 ]
then
    echo "Esto correrá si $NombreUsuario es Steve Y $EDAD es 15."
fi

if [ $NombreUsuario == "Daniya" ] || [ $NombreUsuario == "Zach" ]
then
    echo "Esto correrá si $NombreUsuario es Daniya O Zach."
fi


# ==============
# OPERACIONES CON CONDICIONALES CASE
# ===============
# Bash usa una estructura de casos similar al switch de Java o C++:
case "$VARIABLE" in 
    # Lista de patrones que las condiciones deben cumplir: 
    0) echo "Hay un cero.";;
    1) echo "Hay un uno.";;
    *) echo "No es null.";;
esac


# ==============
# OPERACIONES CON CICLOS FOR
# ===============
# Para los ciclos, se usa la estructura 'for'. Cicla para cada argumento dado:
# El contenido de $VARIABLE se imprime tres veces.
for VARIABLE in {1..3}
do
    echo "$VARIABLE"
done

# ciclos while:
while [true]
do
    echo "cuerpo del ciclo..."
    break
done


# ==============
# OPERACIONES CON FUNCIONES
# ===============
# También se pueden definir sub-rutinas (funciones)
# Definición:
function miFuncion ()
{
    echo "Los argumentos trabajan igual que argumentos de script: $@"
    echo "Y: $1 $2..."
    echo "Esto es una función"
    return 0
}

# O simplemente:
miOtraFuncion ()
{
    echo "¡Otra forma de declarar funciones!"
    return 0
}

# Para llamar a tu función
foo "Mi nombre es:" $NOMBRE


# cierra ventana, termina ejecución
exit						
