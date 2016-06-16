#!/bin/bash
#Archivematica Server
# Setup docker repo & install docker
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee -a /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install -y docker-engine

# Install docker composer
curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` | sudo dd of=/usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone docker git repo and setup archivematica docker
git clone https://github.com/sevein/archivematica.git
cd archivematica/ci
echo "exit 0" >> build-prod.sh # Make it so that the script exits properly
sudo ./build-prod.sh