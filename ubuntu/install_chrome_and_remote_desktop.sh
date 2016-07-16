#!/bin/bash
#Google Chrome and Chrome Remote Desktop
mkdir /tmp/ACG
cd /tmp/ACG
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo dpkg -i google-chrome*.deb
sudo apt-get install -f -y xvfb-randr  xbase-clients python-psutil libappindicator1 

wget http://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg -i chrome-remote-desktop*.deb
sudo apt-get -f -y install
sudo apt-get install -f -y xvfb python-psutil xbase-clients x11-xserver-utils
sudo dpkg -i chrome-remote-desktop*.deb
rm *
rmdir /tmp/ACG
for USER in /home/*
   do 
     str1="startxfce4"
     file1=$USER/.chrome-remote-desktop-session
     str2="export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768"
     file2=$USER/.bashrc
    grep -Fqx "$str1" $file1 || echo  $str1 | sudo tee -a $file1
    grep -Fqx "$str2" $file2 || echo $str2 | sudo tee -a $file2
done
