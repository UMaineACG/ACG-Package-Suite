#!/bin/bash
#MySQL

echo "Updating software sources..."
sudo apt-get update
wait
echo "Software sources updated!"

echo "Installing MySQL Server..."
sudo apt-get install -y mysql-server
wait
echo "MySQL Server installed!"
