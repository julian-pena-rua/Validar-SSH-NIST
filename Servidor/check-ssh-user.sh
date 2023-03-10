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
# Este script verifica si el usuario que inicia sesión se encuentra 
# en la lista de usuarios o grupos autorizados en el archivo 
#    /etc/ssh/authorized_users 
#  Si el usuario no está autorizado, el script registra un 
#  evento de IDS en el archivo de registro de eventos y rechaza la conexión.
# 	
#-------------------------------------------------------------------------------------------


#===================
# VARIABLES
#===================

	

#===================
# MENSAJE BIENVENIDA
#===================

	echo "============================================================="
	echo "=								   "
	echo "=	BIEVENIDO	   "
	echo "= 							   "
	echo "============================================================="
	echo ""

	
#===================
# OPERACIONES
#===================

	echo "============================================================="
	echo "=	INICIANDO OPERACIONES					   "	 
	echo "============================================================="
	echo ""
	echo ""

	# Verificar si el usuario es un usuario o grupo autorizado
	if [[ $(grep -c "$SSH_USER" /etc/ssh/authorized_users) -eq 0 ]]; then
		logger -p local7.notice "Intento de inicio de sesión fallido para el usuario $SSH_USER"
		exit 1
	fi

	# Devolver la lista de claves SSH del usuario
	cat /home/$SSH_USER/.ssh/authorized_keys


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