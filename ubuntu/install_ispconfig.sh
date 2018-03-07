#!/bin/bash
#ISPConfig Web Panel
sudo apt-get update && apt-get upgrade
sudo apt-get install unzip
cd /tmp
wget --no-check-certificate https://github.com/servisys/ispconfig_setup/archive/master.zip
unzip master.zip
cd ispconfig_setup-master/
sudo ./install.sh
