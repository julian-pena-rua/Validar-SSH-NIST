#!/bin/bash  
#-------------------------------------------------------------------------------------------
# RUTINA # 1
# NIVEL: BÀSICO
# 
# AUTOR: 	Julian A. Peña
# VERSIÓN: 	1.0.0
# SITIO: 	
# DESCRIPCIÓN:	
# Rutina con mensaje de bienvenida al usuario
# 	
#-------------------------------------------------------------------------------------------


#===================
# VARIABLES
#===================

	IP=$(hostname -I)
	FECHA_ACTUAL=$(date +"%d/%m/%Y %H:%M:%S")
	VERSION=1.0.0

#===================
# MENSAJE BIENVENIDA
#===================

	echo "============================================================="
	echo "=								   "
	echo "=	BIEVENIDO AL SERVIDOR SSH				   "
	echo "= 							   "
	echo "=				USUARIO: 	$USER		   "
	echo "=				VERSION: 	$VERSION	   "	 
	echo "============================================================="
	echo ""
	echo ""
	echo ""

	echo "$FECHA_ACTUAL - $USER - $IP - Conexion aprobada" >> registro_auth.txt
		
	
#===================
# OPERACIONES
#===================

	echo "============================================================="
	echo "=	INICIANDO OPERACIONES					   "	 
	echo "============================================================="

	echo ""
	echo ""
	echo ""
	echo "Listando directorios y archivos disponibles..."
	echo "#####                     (33%)"
	echo "#############             (66%)"
	echo "###################       (86%)"
	echo "#######################   (100%)"
	echo "Carga completa"

#===================
# FIN DE EJECUCIÒN
#===================
	echo "============================================================="
	echo "=								   "
	echo "=	FIN OPERACIONES AUTOMATIZADAS			   	   "
	echo "= 							   "
	echo "=				USUARIO: 	$USER		   "
	echo "=				VERSION: 	$VERSION	   "	 
	echo "============================================================="
	echo ""
	echo "Puede continuar navegando o utilizando los archivos listados..."
	echo ""
	echo ""
	ls
	
	#exit