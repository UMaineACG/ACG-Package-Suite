#!/bin/bash
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

sudo useradd -m -s /bin/bash $USERNAME -gsudo
echo "$USERNAME:$PASSWORD"|sudo chpasswd
echo "startxfce4"| sudo tee /home/$USERNAME/.chrome-remote-desktop-session
echo "export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768"|sudo tee /home/$USERNAME/.bashrc

