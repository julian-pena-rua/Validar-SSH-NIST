# TITULO:       CONFIGURAR SERVIDOR CHROOT
# AUTOR: 	Julian A. Peña
# FECHA:	09/04/2023
# VERSION:	1.0.0
# SITIO: 	https://julian-pena-rua.github.io/cv/
#
# DESCRIPCION: 
#	Automatizacion para configurar servidor ChrootDirectory utilizando 
#       Protocolo de Transferencia de Archivos SSH o Protocolo de transferencia 
#       segura de archivos. SFPT proporciona funcionalidades de acceso a archivos, 
#       tranferencia de ficheros y adminitracion de los archivos sobre cualquier
#       flujo de datos confiable.
#
#       Al configurar el entorno chroot, solo los usuarios permitidos
#       estaran limitados a su directorio de inicio, o estaran en una celda o 
#       prision como un espacio de trabajo del cual nisiquiera pueden cambiar 
#       su directorio.
#       
#       realizado siguiendo instructivo de:
#
#		https://redessy.com/como-configurar-el-servidor-chroot-sftp-en-linux/
#
#       DirectorioChroot %h – Esta es la ruta (directorio de inicio 
#       del usuario predeterminado) que se usará para chroot después de 
#       que el usuario se autentique. Entonces, para Jack, esto será /home/jack.
#
#       ForceCommand interno-sftp – Esto fuerza la ejecución de internal-sftp e 
#       ignora cualquier comando que se mencione en el archivo ~/.ssh/rc.
#

# ----------------------------------------------------------------------------------------

# ===================
# VARIABLES
# ===================

NombreGrupo=sftp_users
NombreUsuario=javier
ContrasenaUsuario=123456789
Prision=/home/$NombreUsuario/prision

# ===================
# OPERACIONES
# ===================

# 1. Crear un grupo
sudo groupadd  $NombreGrupo

# 1.5. Verifica que el usuario exista
getent passwd $NombreUsuario > /dev/null 2>&1
if [ $? -eq 0 ]
then 
	echo "usuario existente"
	# 2. Para usuarios ya existentes
	#usermod -G sftp_users -s /sbin/nologin  jack
	usermod -G $NombreGrupo  $NombreUsuario
	echo "Agregado al grupo existosamente"
else 
	# 2. Crea usuario y asigna grupo secundario (sftp_users) al usuario
	echo "el usuario no existe"
	#sudo useradd  -G sftp_users -s /bin/nologin  jack --password 123456789
	sudo useradd  -G $NombreGrupo -s /bin/bash $NombreUsuario --password $ContrasenaUsuario -m	
	#sudo useradd  -G $NombreGrupo $NombreUsuario --password $ContrasenaUsuario -m
	echo "el usuario ha sido creado y agregado al grupo exitosamente"
	
	# 3. Crear la carpeta de prision y Establecer permisos necesarios
	echo "Creando la carpeta prision"
	sudo mkdir $Prision
	echo "Carpeta creada con Exito"
	
	echo "Estableciendo los permisos al usuario: "$NombreUsuario 
	chmod 755 '/home/'$NombreUsuario
	chown root '/home/'$NombreUsuario
	
	chgrp -R $NombreGrupo '/home/'$NombreUsuario
	
	chown root:root $Prision
	chmod 755 $Prision
	
	# Restringir acceso a la carpeta de prisión
	chown $NombreUsuario:$NombreUsuario $Prision
	chmod 700 $Prision
		
	echo "Modificacion de permisos completado exitosamente" 

	# 4. Montar la carpeta dentro de si misma, limitando màs el acceso.
	echo "Montando imagen"
	sudo mount --bind $Prision $Prision
	echo "Montada exitosamente"

	# Nota : Si desea cambiar el directorio de inicio predeterminado de usuarios, 
	# luego use '-D' opción en el comando useradd y usermod y configure permisos correctos.

	# 5. Crear archivo .bashrc en la carpeta de prisión para establecer la ruta de acceso
	echo "Creando Path"
	echo "PATH=\$PATH:/usr/local/bin" > $Prision/.bashrc
	echo "Path creado exitosamente"
	
	# 9. Ahora edite el archivo de configuración "/etc/ssh/sshd_config"
	# --------------------------------------------------------------------
	# = GENERADO AUTOMATICAMENTE
	# --------------------------------------------------------------------
	#Match Group sftp_users
	#X11Forwarding no
	#AllowTcpForwarding no
	#ChrootDirectory %h
	#ForceCommand internal-sftp
	
	echo "Editando archivo sshd_config" 
	cd /etc/ssh/
	echo '# --------------------------------------------------------------------' >> sshd_config
	echo '# # = GENERADO POR SCRIPT' >> sshd_config
	echo '# --------------------------------------------------------------------' >> sshd_config
	echo 'Match Group '$NombreGrupo' \n\tChrootDirectory /home/%u/'$NombreGrupo' \n\tX11Forwarding no \n\tAllowTcpForwarding no \n' >> sshd_config
	echo "AllowUsers $NombreUsuario" >> sshd_config

	
	echo "Edicion realizada con exito" 
	cd ..
	cd ..

	echo "Reiniciando servicio SSHD" 
	# 6. Reiniciar servicio SSHD
	# systemctl restart sshd
	sudo systemctl restart ssh
	echo "Reinicio completado exitosamente" 

	#7. Verificar el estado del servicio SSH
	sudo systemctl status ssh

	#8. Verificar la configuración de SSHD
	sudo sshd -t

	#10. Reiniciar el servicio SSHD
	sudo systemctl restart sshd

	echo "Proceso completo exitosamente"

	#11. Mostrar información de inicio de sesión para el usuario
	echo "Informacion de inicio de sesion:"
	echo "Servidor: <ip_del_servidor>"
	echo "Puerto: 543"
	echo "Usuario: "$NombreUsuario
	echo "Contraseña: "$ContrasenaUsuario
	echo "Directorio de inicio: prision/"

	#12. Dar un último recordatorio al usuario
	echo "¡Recuerde que su acceso está restringido a la carpeta de prision!"
	echo "No se permite el acceso a otras partes del servidor."
	echo "¡Gracias por usar nuestro servicio de transferencia de archivos seguro!"
	echo "¡Ten un buen día!"

	#13. Salir del script
	sleep 1m
	exit 
fi

# NOTA: recuerde que los permisos son: 
#   https://www.profesionalreview.com/2017/01/28/permisos-basicos-linux-ubuntu-chmod/

# 9. Si el usuario puede subir archivos, cree una carpeta de carga con los permisos:
# mkdir /home/jack/upload
# chown jack. /home/jack upload/