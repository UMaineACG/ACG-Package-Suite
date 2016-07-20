#!/bin/bash
#LAMP Stack

echo "Installing LAMP stack..."
sh install_apache.sh > /dev/null &
wait
sh install_mysql.sh > /dev/null &
wait
sh install_php.sh > /dev/null &
echo "LAMP stack installed!"
