#!/bin/bash

# Script to install AtoM for Archivematica
git clone https://github.com/nh-99/docker-atom.git
sudo docker build -t arv3054/atom docker-atom
sudo docker run -i -t -d -p 80:80 --name atom arv3054/atom
sudo docker exec -i -t atom /create-db.sh
