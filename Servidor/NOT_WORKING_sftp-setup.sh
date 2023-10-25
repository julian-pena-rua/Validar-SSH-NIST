#!/bin/bash

# 'Descripcion'
#	En este script, primero configuramos el archivo sshd_config para incluir la directiva Match Group sftp, que 
#   restringe el acceso SFTP a un grupo específico de usuarios. 
# 	Luego agregamos las opciones ForceCommand, ChrootDirectory, X11Forwarding, y AllowTcpForwarding 
#	para configurar la chroot jail para los usuarios del grupo sftp.
#
#	Luego creamos los directorios necesarios dentro del directorio de chroot, establecemos los permisos y 
# 	la propiedad adecuados en los directorios de chroot y los directorios internos, y finalmente reiniciamos el servicio SSH para que los cambios tengan efecto.
#	Puedes guardar este script en un archivo llamado sftp-setup.sh, hacerlo ejecutable (chmod +x sftp-setup.sh) y luego ejecutarlo usando sudo ./sftp-setup.sh.

# Configurar el archivo sshd_config
sudo sed -i 's/#Subsystem/Subsystem/g' /etc/ssh/sshd_config
sudo sed -i '/Subsystem sftp/a Match Group sftp\nForceCommand internal-sftp\nChrootDirectory /home/%u/sftp\nX11Forwarding no\nAllowTcpForwarding no\n' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Crear el directorio de chroot y los directorios internos
sudo mkdir -p /home/BichoJ/sftp/data
sudo chown root:root /home/BichoJ/sftp
sudo chmod 755 /home/BichoJ/sftp
sudo chown root:root /home/BichoJ/sftp/data
sudo chmod 755 /home/BichoJ/sftp/data