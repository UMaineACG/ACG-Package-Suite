#!/bin/bash
#ignore
###################################################################
# 
# add a user 
#
# call should be of the form 
# printf "id\npass"|/usr/local/bin/ACG-Package-Suite/add_user.sh
# where id is username and pass is password (with a \n between)
#
###################################################################
echo "Please enter a user name"
read USERNAME
echo "Username is $USERNAME"
echo "Please enter a password"
read PASSWORD
echo "Password is $PASSWORD"

sudo useradd -m -U -G adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev -s /bin/bash $USERNAME
echo "$USERNAME:$PASSWORD" | sudo chpasswd
sudo chage -d 0 $USERNAME
echo "Password much be changed on first login"
echo "startxfce4" | sudo tee /home/$USERNAME/.chrome-remote-desktop-session
echo "export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768" | sudo tee -a /home/$USERNAME/.bashrc
echo "export TZ=America/New_York" | sudo tee -a /home/$USERNAME/.bashrc
