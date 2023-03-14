#!/bin/bash  
#-------------------------------------------------------------------------------------------
# Personalizar el mensaje de bienvenida con información adicional sobre el servidor
# NIVEL: BÀSICO
# 
# AUTOR: 				Julian A. Peña
# VERSIÓN: 				1.0.0
# FECHA CREACIÓN:		14/03/2023
# FECHA MODIFICACIÓN:	
# SITIO: 				
# DESCRIPCIÓN:	
# Este script creará un archivo banner.txt con información del sistema y 
# lo utilizará como mensaje de bienvenida personalizado en el servidor SSH. 
# También actualizará automáticamente el archivo sshd_config para utilizar el nuevo 
# banner y reiniciará el servicio sshd para que los cambios surtan efecto.
# 	
#-------------------------------------------------------------------------------------------


#===================
# VARIABLES
#===================

	IP=$(hostname -I)
	FECHA_ACTUAL=$(date +"%d/%m/%Y %H:%M:%S")
	VERSION=1.0.0
	
	# Obtener la información del sistema
	hostname=$(hostname)
	os=$(uname -s)
	kernel=$(uname -r)
	arch=$(uname -m)
	

#===================
# MENSAJE BIENVENIDA
#===================

	echo "============================================================="
	echo "=								   "
	echo "=	MONITOREO CLAVES SSH		   "
	echo "= 							   "
	echo "============================================================="
	echo ""
	echo ""
	echo ""

	echo "$FECHA_ACTUAL - $USER - $IP - Conexion aprobada" >> registro_auth.txt
		
	
#===================
# OPERACIONES
#===================

	# Crear el archivo banner
	sudo touch /etc/ssh/banner.txt
	
	# Agregar el mensaje de bienvenida personalizado
	echo "Bienvenido al servidor $hostname." | sudo tee /etc/ssh/banner.txt
	echo "Sistema operativo: $os" | sudo tee -a /etc/ssh/banner.txt
	echo "Kernel: $kernel" | sudo tee -a /etc/ssh/banner.txt
	echo "Arquitectura: $arch" | sudo tee -a /etc/ssh/banner.txt
	
	# Actualizar el archivo sshd_config para usar el nuevo banner
	sudo sed -i 's/^#Banner/Banner/' /etc/ssh/sshd_config
	sudo sed -i 's/^Banner.*/Banner \/etc\/ssh\/banner.txt/' /etc/ssh/sshd_config
	
	# Reiniciar el servicio sshd para que los cambios surtan efecto
	sudo service sshd restart

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
	
	#exit