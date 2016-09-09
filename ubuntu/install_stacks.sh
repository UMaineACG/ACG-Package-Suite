#!/bin/bash
#Stacks (with web interface)

wget http://catchenlab.life.illinois.edu/stacks/source/stacks-1.42.tar.gz
wait
tar -xf stacks-1.42.tar.gz
cd stacks-1.42
./configure
wait
make
wait
sudo make install
wait
echo "\n\n\nexecutables and perl scripts are in /usr/local/bin, and database and web interface files are in /usr/local/share/stacks\n\n\n"

echo "Installing prerequisites. This will take a while."
sudo apt-get update > /dev/null &
wait
sudo apt-get install -y mysql-server mysql-client php5 php5-mysqlnd libspreadsheet-writeexcel-perl > /dev/null &
wait
echo "Prerequisites installed!"
cd /usr/local/share/stacks/sql/
cp mysql.cnf.dist mysql.cnf

echo "User action required. If you've never used MySQL before on this machine, you can configure it with the following commands: \n mysql \n GRANT ALL ON *.* TO 'stacksuser'@'localhost' IDENTIFIED BY 'stackspassword';\n\nNow edit mysql.cnf to contain the username and password you gave to MySQL\n \n"
