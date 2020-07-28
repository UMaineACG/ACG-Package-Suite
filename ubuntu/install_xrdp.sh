#!/bin/bash
# this is a wrapper for an xrdp install script by Griffon
# there have been multiple versions and they are quite thorough
# it is worth checking here:
# http://www.c-nergy.be/products.html


sudo apt-get install python3-pip
sudo pip3 install apt-mirror-updater
apt-mirror-updater -a

mkdir /tmp/installxrdp
cd /tmp/installxrdp


curl http://www.c-nergy.be/downloads/xrdp-installer-1.2.zip --output xrdp.zip
unzip xrdp.zip 
chmod +x xrdp-installer-1.2.sh 
sed -i 's/be.archive/archive/' xrdp-installer-1.2.sh
./xrdp-installer-1.2.sh -s

cd /tmp/installxrdp
rm *
echo "pulseaudio -k" |sudo tee -a /etc/profile
