#!/bin/bash

sudo rm -rf /tem/ACG
mkdir /tmp/ACG
cd /tmp/ACG
wget https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb
sudo apt update
sudo apt-get update
sudo apt -y install r-base
sudo apt -y install gdebi-core
sudo gdebi rstudio-xenial-1.1.463-amd64.deb

