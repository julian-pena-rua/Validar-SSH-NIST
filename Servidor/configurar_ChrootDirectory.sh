# TITULO:       CONFIGURAR SERVIDOR CHROOT
# AUTOR: 		Julian A. Peña
# FECHA:		09/04/2023
# VERSION:	    1.0.0
# SITIO: 		https://julian-pena-rua.github.io/cv/
#
# DESCRIPCION: 
#		Automatizacion para configurar servidor ChrootDirectory utilizando 
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

# VARIABLES


# OPERACIONES


# 1. Crear un grupo
sudo groupadd  sftp_users

# 2. Asignar grupo secundario (sftp_users) al usuario
useradd  -G sftp_users -s /sbin/nologin  jack
passwd 123456789

# 2. Para usuarios ya existentes
#usermod –G sftp_users -s /sbin/nologin  jack

# Nota : Si desea cambiar el directorio de inicio predeterminado de usuarios, 
# luego use '-D' opción en el comando useradd y usermod y configure el permisos correctos.

# 3. Ahora edite el archivo de configuración "/etc/ssh/sshd_config"
# --------------------------------------------------------------------
# = GENERADO AUTOMATICAMENTE
# --------------------------------------------------------------------
#Match Group sftp_users
#X11Forwarding no
#AllowTcpForwarding no
#ChrootDirectory %h
#ForceCommand internal-sftp

# 3. Reiniciar servicio SSH
# systemctl restart sshd

# 4. Establecer permisos necesarios
# chmod 755 /home/jack
# chown root /home/jack
# chgrp -R sftp_users /home/jack

# NOTA: recuerde que los permisos son: 
#   https://www.profesionalreview.com/2017/01/28/permisos-basicos-linux-ubuntu-chmod/

# 5. Si el usuario puede subir archivos, cree una carpeta de carga con los permisos:
# mkdir /home/jack/upload
# chown jack. /home/jack upload/