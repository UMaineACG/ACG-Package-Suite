#!/bin/bash
###################################################################
# 
# add a user 
#
# call should be of the form 
# echo "id pass"|/usr/local/bin/ACG-Package-Suite/add_user.sh
#
###################################################################
read USERNAME
read PASSWORD

sudo useradd -m -s /bin/bash $USERNAME -gsudo
sudo echo "$USERNAME:$PASSWORD"|chpasswd
sudo echo echo "startxfce4" >>/home/$USERNAME/.chrome-remote-desktop-session

