#!/bin/bash

echo "Updating software sources..."
sudo apt-get update > /dev/null &
wait
echo "Software sources updated!"

echo "Installing PHP..."
sudo apt-get install -y php5 libapache2-mod-php5 php5-mcrypt php5-mysql > /dev/null &
wait
echo "PHP installed!"
