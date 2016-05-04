#!/bin/bash
###################################################################
# 
# Install a basic gui desktop 
#
###################################################################
sudo -i export DEBIAN_FRONTEND=noninteractive
echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
sudo timedatectl set-timezone America/New_York
sudo apt-get -y  update
sudo apt-get -y  upgrade 
sudo apt-get -y   dist-upgrade
sudo apt-get install -y -f grub-legacy-ec2
sudo grub-install --recheck /dev/vda
sudo apt-get  -y install
sudo apt-get install -y  -f xubuntu-desktop
sudo /usr/share/debconf/fix_db.pl
sudo apt-get -f -y install
sudo apt-get install -y -f grub-legacy-ec2
sudo apt-get -f -y install
sudo grub-install --recheck /dev/vda
sudo apt-get -f -y install
sudo apt-get install -y -f dictionaries-common
sudo apt-get install -y -f libreoffice
sudo apt-get install -y -f grub-legacy-ec2
sudo grub-install --recheck /dev/vda
sudo apt-get -f install
sudo apt-get install -y -f dictionaries-common
sudo apt-get install -y -f libreoffice
sudo apt-get install -y  -f man manpages manpages-dev freebsd-manpages funny-manpages gmt-manpages man2html manpages-posix manpages-posix-dev asr-manpages
sudo apt-get install -f -y xvfb python-psutil xbase-clients xrandr
sudo apt-get install -f -y  gtk2-engines-pixbuf
sudo apt-get install -f -y libxss1 libappindicator1 libindicator7 
sudo apt-get -f -y install
sudo apt-get -y autoremove
sudo apt-get remove -y light-locker
sudo apt-get remove -y gnome-screensaver
sudo apt-get remove -y xscreensaver
sudo apt-get remove -y abiword
sudo apt-get remove -y gnumeric
echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
sudo timedatectl set-timezone America/New_York
echo PATH=\"$PATH\"| sudo tee /etc/environment


#sudo echo "America/New_York" | sudo tee /etc/timezone >/dev/null
#sudo dpkg-reconfigure -f noninteractive tzdata
sudo /usr/local/bin/ACG-Package-Suite/install_chrome_and_remote_desktop.sh

sudo rm /var/crash/*

