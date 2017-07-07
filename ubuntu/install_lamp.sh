#!/bin/bash
#LAMP Stack

echo "Installing LAMP stack..."
sh /usr/local/bin/ACG-Package-Suite/ubuntu/install_apache.sh
wait
sh /usr/local/bin/ACG-Package-Suite/ubuntu/install_mysql.sh
wait
sh /usr/local/bin/ACG-Package-Suite/ubuntu/install_php.sh
echo "LAMP stack installed!"
