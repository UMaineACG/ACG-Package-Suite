#!/bin/bash
#LAMP Stack

echo "Installing LAMP stack..."
sh ${BASH_SOURCE%/*}/install_apache.sh
wait
sh ${BASH_SOURCE%/*}/install_mysql.sh
wait
sh ${BASH_SOURCE%/*}/install_php.sh
echo "LAMP stack installed!"
