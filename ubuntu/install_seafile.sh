#!/bin/bash
#Seafile Client
export SFCLIENT=seafile_5.1.0_amd64.deb
cd
sudo  apt-get update
sudo apt-get install -y libjansson4 libqt5test5
wget https://bintray.com/artifact/download/seafile-org/seafile/$SFCLIENT

sudo dpkg -i $SFCLIENT
