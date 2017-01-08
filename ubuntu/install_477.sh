#!/bin/bash
# Install a base GUI
sudo apt-get update
sudo apt autoremove
sudo apt-get install xubuntu-core^

sudo rm /var/crash/*
sudo apt-get -y autoremove
sudo apt-get remove -y light-locker
sudo apt-get remove -y gnome-screensaver
sudo apt-get remove -y xscreensaver
sudo apt-get remove -y abiword
sudo apt-get remove -y gnumeric
sudo apt-get -y autoremove
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y autoremove

# Code to download, patch, and build avrdude 6.3 on Ubuntu
#
# 
export PREFIX=/usr/local
cd
sudo apt-get remove avrdude
sudo apt-get install -f   build-essential wget gcc libevent-dev libcurl3 python-gtk2-dev uuid-dev libsqlite0-dev libjansson-dev intltool cmake  libfuse-dev libtool  gcc

sudo apt-get install -f  make automake autoconf flex bison libusb-dev libusb-1.0-0-dev  libx11-dev libftdi1 subversion
wget http://download.savannah.gnu.org/releases/avrdude/avrdude-doc-6.3.pdf

mkdir avrdude
cd avrdude

svn co svn://svn.sv.gnu.org/avrdude/tags/RELEASE_6_3
#wget http://download.savannah.gnu.org/releases/avrdude/avrdude-6.3.tar.gz
#gunzip -c avrdude-6.3.tar.gz |tar xf -
cd RELEASE_6_3
wget http://savannah.nongnu.org/bugs/download.php?file_id=32171
patch < download.php\?file_id\=32171
./bootstrap
mkdir obj-avr
cd obj-avr
sudo ../configure --prefix=$PREFIX
sudo make
sudo make install

## Other avr stuff

sudo apt-get -f install
sudo apt autoremove

sudo apt-get -f install
sudo apt-get install gcc-avr
sudo apt-get -f install
sudo apt autoremove

sudo apt-get install binutils-avr
sudo apt-get install avr-libc

sudo apt autoremove



