#!/bin/bash
###################################################################
# 
# add a user 
#
# call should be of the form 
# echo "id pass"|/usr/local/bin/ACG-Package-Suite/add_user.sh
#
###################################################################
echo "Please enter a user name"
read USERNAME
echo "Username is $USERNAME"
echo "Please enter a password"
read PASSWORD
echo "Password is $PASSWORD"

sudo useradd -m -s /bin/bash $USERNAME -gsudo
echo "$USERNAME:$PASSWORD"|sudo chpasswd
sudo echo echo "startxfce4" >>/home/$USERNAME/.chrome-remote-desktop-session

