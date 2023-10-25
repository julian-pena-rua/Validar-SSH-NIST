#!/bin/bash  
#-------------------------------------------------------------------------------------------
# RUTINA # 1
# NIVEL: BÀSICO
# 
# AUTOR: 		Julian A. Peña
# VERSIÓN: 		1.0.0
# FECHA: 		2023-03-10
# SITIO: 		https://julian-pena-rua.github.io/cv/
# DESCRIPCIÓN:	
# Este script define la ruta a la carpeta donde se encuentran las claves autorizadas, 
# que en este caso es /etc/ssh/authorized_keys. 
# También define un tiempo máximo en segundos que una clave puede estar autorizada, 
# que en este caso es de un año.
# 
# El script verifica si el usuario especificado como argumento es válido utilizando 
# el comando getent. Luego, verifica si el archivo de claves autorizadas 
# para el usuario existe y es legible. Si el archivo no existe o no es legible, 
# el script sale con un código de error.
# 
# El script también verifica si la clave de usuario ha expirado. 
# Utiliza el comando stat para obtener la fecha de última modificación del archivo de 
# claves autorizadas y compara esa fecha con la fecha actual para determinar si la clave
# ha expirado. Si la clave ha expirado, el script sale con un código de error.
# 
# Finalmente, si el usuario y la clave son válidos y no han expirado, 
# el script muestra la clave de usuario autorizada utilizando el comando cat.
# 	
#-------------------------------------------------------------------------------------------


#===================
# VARIABLES
#===================

	# Ruta a la carpeta donde se encuentran las claves autorizadas
	AUTHORIZED_KEYS_DIR="/etc/ssh/authorized_keys"

	# Tiempo máximo en segundos que una clave puede estar autorizada
	EXPIRATION_TIME=$((60*60*24*365)) # 1 año

#===================
# MENSAJE BIENVENIDA
#===================

	echo "============================================================="
	echo "=								   "
	echo "=	BIEVENIDO	   "
	echo "= 							   "
	echo "============================================================="
	echo ""
	echo ""
	echo ""

	
		
	
#===================
# OPERACIONES
#===================

	echo "============================================================="
	echo "=	INICIANDO OPERACIONES					   "	 
	echo "============================================================="
	echo ""
	
	
	# Verificar si el usuario especificado como argumento es válido
	if ! getent passwd "$1" >/dev/null 2>&1; then
		exit 1
	fi

	# Verificar si el archivo de claves autorizadas para el usuario existe y es legible
	if [ ! -f "${AUTHORIZED_KEYS_DIR}/$1" ] || [ ! -r "${AUTHORIZED_KEYS_DIR}/$1" ]; then
		exit 1
	fi

	# Verificar si la clave de usuario ha expirado
	if [ $(($(date +%s) - $(stat -c %Y "${AUTHORIZED_KEYS_DIR}/$1"))) -gt $EXPIRATION_TIME ]; then
		exit 1
	fi

	echo "Carga completa"

	# Mostrar la clave de usuario autorizada
	cat "${AUTHORIZED_KEYS_DIR}/$1"
	
	

#===================
# FIN DE EJECUCIÒN
#===================
	echo "============================================================="
	echo "=								   "
	echo "=	FIN OPERACIONES AUTOMATIZADAS			   	   "
	echo "=								   "
	echo "============================================================="
	echo ""
	echo ""
	echo ""

	
	#exit