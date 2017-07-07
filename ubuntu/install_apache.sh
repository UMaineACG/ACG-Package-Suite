#!/bin/bash
#Apache

echo "Updating software sources..."
sudo apt-get update
echo "Software sources updated!"

echo "Installing Apache Web Server..."
sudo apt-get install -y apache2
echo "Apache Web Server installed!"
