#
# AUTOR: 		Julian A. Peña
# FECHA:		08/04/2023
# VERSION:	    	1.0.0
# SITIO: 		https://julian-pena-rua.github.io/cv/
#
# DESCRIPCION: 
#		Realizado siguiendo instructivo de:
#
#		https://askubuntu.com/questions/134425/how-can-i-chroot-sftp-only-ssh-users-into-their-homes
# ----------------------------------------------------------------------------------------

# VARIABLES
usuario=Julian


# OPERACIONES
sudo mkdir /home/$usuario
sudo useradd -d /home/$usuario -M -N -g users $usuario
sudo chown root:root /home/$usuario
sudo chmod 755 /home/$usuario