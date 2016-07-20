#!/bin/bash
#Apache

echo "Updating software sources..."
sudo apt-get update > /dev/null &
wait
echo "Software sources updated!"

echo "Installing Apache Web Server..."
sudo apt-get install -y apache2 > /dev/null &
wait
echo "Apache Web Server installed!"
