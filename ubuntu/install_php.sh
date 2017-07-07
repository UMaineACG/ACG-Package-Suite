#!/bin/bash
#PHP

echo "Updating software sources..."
sudo apt-get update
echo "Software sources updated!"

echo "Installing PHP..."
sudo apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-mcrypt php7.0-mysql
echo "PHP installed!"
