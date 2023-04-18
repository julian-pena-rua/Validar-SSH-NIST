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

NombreGrupo='sftp_users'
NombreUsuario='javier'
ContrasenaUsuario='123456789'

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
	#usermod –G sftp_users -s /sbin/nologin  jack
	usermod –G $NombreGrupo  $NombreUsuario
	echo "Agregado al grupo existosamente"
else 
	# 2. Crea usuario y asigna grupo secundario (sftp_users) al usuario
	echo "el usuario no existe"
	#sudo useradd  -G sftp_users -s /sbin/nologin  jack --password 123456789
	sudo useradd  -G $NombreGrupo $NombreUsuario --password $ContrasenaUsuario
	echo "el usuario ha sido creado y agregado al grupo exitosamente"
fi

# Nota : Si desea cambiar el directorio de inicio predeterminado de usuarios, 
# luego use '-D' opción en el comando useradd y usermod y configure permisos correctos.

echo "Editando archivo sshd_config" 
# 3. Ahora edite el archivo de configuración "/etc/ssh/sshd_config"
# --------------------------------------------------------------------
# = GENERADO AUTOMATICAMENTE
# --------------------------------------------------------------------
#Match Group sftp_users
#X11Forwarding no
#AllowTcpForwarding no
#ChrootDirectory %h
#ForceCommand internal-sftp

#sudo sed -i 's/#Subsystem/Subsystem/g' /etc/ssh/sshd_config
cd /etc/ssh/
echo '# --------------------------------------------------------------------' >> sshd_config
echo '# # = GENERADO POR SCRIPT' >> sshd_config
echo '# --------------------------------------------------------------------' >> sshd_config
echo 'Match Group '$NombreGrupo' \n\tForceCommand internal-sftp \n\tChrootDirectory /home/%u/'$NombreGrupo' \n\tX11Forwarding no \n\tAllowTcpForwarding no \n' >> sshd_config
echo "Edicion realizada con exito" 
cd ..
cd ..

echo "Reiniciando servicio SSH" 
# 3. Reiniciar servicio SSH
# systemctl restart sshd
sudo systemctl restart ssh
echo "Reinicio completado exitosamente" 

# 4. Establecer permisos necesarios
# chmod 755 /home/jack
# chown root /home/jack
# chgrp -R sftp_users /home/jack

# NOTA: recuerde que los permisos son: 
#   https://www.profesionalreview.com/2017/01/28/permisos-basicos-linux-ubuntu-chmod/

# 5. Si el usuario puede subir archivos, cree una carpeta de carga con los permisos:
# mkdir /home/jack/upload
# chown jack. /home/jack upload/