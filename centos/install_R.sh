#!/bin/bash
#R

sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y
sudo yum install R -y
clear
echo "R is now installed. To run it, just run 'R' in the command line."