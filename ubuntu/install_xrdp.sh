#!/bin/bash
# this is a wrapper for an xrdp install script by Griffon
# there have been multiple versions and they are quite thorough
# it is worth checking here:
# http://www.c-nergy.be/products.html


sudo apt-get install python3-pip
sudo pip3 install apt-mirror-updater
#apt-mirror-updater -a

mkdir /tmp/installxrdp
cd /tmp/installxrdp


curl http://www.c-nergy.be/downloads/xrdp-installer-1.2.2.zip --output xrdp.zip
unzip xrdp.zip 
chmod +x xrdp-installer-1.2.2.sh 
sed -i 's/be.archive/us.archive/' xrdp-installer-1.2.2.sh
sed -i 's/git clone/git clone --recursive/' xrdp-installer-1.2.2.sh

if [ "$1" = "-r" ] ;
then
	./xrdp-installer-1.2.2.sh -r
else
	 eval "./xrdp-installer-1.2.2.sh -s $@"
fi


cd /tmp/installxrdp
rm *
echo "pulseaudio -k" |sudo tee -a /etc/profile
