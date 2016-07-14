#!/bin/bash
echo "Updating software sources..."
sudo apt-get update > /dev/null &
wait
echo "Software sources updated!"

echo "Installing MySQL Server..."
sudo apt-get install -y mysql-server > /dev/null &
wait
echo "MySQL Server installed!"
