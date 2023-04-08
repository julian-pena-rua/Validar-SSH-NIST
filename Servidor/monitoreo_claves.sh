#!/bin/bash  
#-------------------------------------------------------------------------------------------
# Monitoreo de Claves
# NIVEL: BÀSICO
# 
# AUTOR: 				Julian A. Peña
# VERSIÓN: 				1.0.0
# FECHA CREACIÓN:		14/03/2023
# FECHA MODIFICACIÓN:	
# SITIO: 				
# DESCRIPCIÓN:	
# Este script monitorea los archivos de registro authorized_keys y id_rsa 
# para detectar intentos de acceso sospechosos a las claves públicas y privadas respectivamente.
# Cuando se detecta un intento sospechoso, el script revoca la clave SSH correspondiente 
# utilizando el comando ssh-keygen.

# El registro de las revocaciones se almacena en un archivo de registro separado llamado revoked_keys.log. 
# Además, se registran los accesos a las claves públicas y privadas en archivos de registro 
# separados llamados public_key_access.log y private_key_access.log.
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

	#!/bin/bash

	# Directorio donde se almacenan los archivos de registro
	LOG_DIR="/var/log/ssh/"
	
	# Archivo de registro de acceso a la clave pública
	PUBKEY_LOG="${LOG_DIR}authorized_keys"
	
	# Archivo de registro de acceso a la clave privada
	PRIVKEY_LOG="${LOG_DIR}id_rsa"
	
	# Dirección IP del servidor SSH
	SSH_SERVER_IP="$(ifconfig eth0 | grep 'inet addr' | awk -F ':' '{print $2}' | awk '{print $1}')"
	
	# Comando para revocar una clave SSH
	REVOKE_COMMAND="ssh-keygen -k -f ${LOG_DIR}revoked_keys -u "
	
	# Función para revocar una clave SSH
	revoke_key() {
		key="$1"
		$REVOKE_COMMAND "$key"
		echo "$(date) Key revoked: $key" >> "${LOG_DIR}revoked_keys.log"
	}
	
	# Monitoreo del acceso a la clave pública
	tail -f "$PUBKEY_LOG" | while read line; do
		key="$(echo $line | cut -d ' ' -f 2)"
		user="$(echo $line | cut -d ' ' -f 3)"
		ip="$(echo $line | cut -d ' ' -f 4)"
		if [[ "$ip" != "$SSH_SERVER_IP" ]]; then
			echo "$(date) Public key access by $user from $ip" >> "${LOG_DIR}public_key_access.log"
			revoke_key "$key"
		fi
	done &
	
	# Monitoreo del acceso a la clave privada
	tail -f "$PRIVKEY_LOG" | while read line; do
		key="$(echo $line | cut -d ' ' -f 2)"
		if [[ "$key" != "accepted" ]]; then
			echo "$(date) Private key access denied from $SSH_SERVER_IP" >> "${LOG_DIR}private_key_access.log"
			revoke_key "$key"
		fi
	done &

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