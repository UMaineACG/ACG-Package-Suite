#!/bin/bash
#R

# Add sources entry & apt key
sudo sh -c 'echo "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" >> /etc/apt/sources.list'
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

sudo apt-get update
sudo apt-get -y install r-base
clear
echo "R is now installed. To run it, just run 'R' in the command line."
