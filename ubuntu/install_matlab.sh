#!/bin/bash
#Matlab
username=$(tempfile 2>/dev/null)
password=$(tempfile 2>/dev/null)
cd ~/
mkdir matlab && cd matlab
dialog --title "UMS Username" --clear --inputbox "Enter your username for your UMS account" 10 30 2> $username
dialog --title "UMS Password" --clear --passwordbox "Enter your password for your UMS account" 10 30 2> $password
curl -O -G --data-urlencode "username=$(cat $username)" --data-urlencode "password=$(cat $password)" http://204.197.0.108:5000/files/matlab.zip
unzip matlab.zip
sudo ./install
