#!/bin/bash
echo
    while true
    do
        read -s -p "Enter a MySQL ROOT Password: " mysqlrootpassword
        echo
        read -s -p "Confirm MySQL ROOT Password: " password2
        echo
        [ "$mysqlrootpassword" = "$password2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
    echo
    while true
    do
        read -s -p "Enter a Guacamole User Database Password: " guacdbuserpassword
        echo
        read -s -p "Confirm Guacamole User Database Password: " password2
        echo
        [ "$guacdbuserpassword" = "$password2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
    echo

sudo apt-get -y install docker.io mysql-client wget
mkdir /tmp/guacamole
cd /tmp/guacamole
# sudo ufw disable
wget https://raw.githubusercontent.com/MysticRyuujin/guac-install/master/docker-install.sh
chmod +x docker-install.sh
sed -i 's/sleep 30/sleep 90/' docker-install.sh
sudo ./docker-install.sh -m "$mysqlrootpassword" -g "$guacdbuserpassword" 

# add a connection to this machine
SQLCODE="
use guacamole_db;
replace into guacamole_connection(connection_id, connection_name, protocol) values(1,'guacamole_server','rdp');
replace into guacamole_connection_permission(entity_id,connection_id,permission) values(1,1,'READ'),(1,1,'UPDATE'),(1,1,'DELETE'),(1,1,'ADMINISTER');
replace into guacamole_connection_parameter(connection_id,parameter_name,parameter_value) values(1,'console-audio','true'),(1,'hostname','172.17.0.1'),(1,'port','3389'),(1,'ignore-cert','true');
"
# Execute SQL Code
echo $SQLCODE | mysql -h 127.0.0.1 -P 3306 -u root -p$mysqlrootpassword



echo
echo
echo
echo "This is very important, we are almost done."
echo "but not quite."
echo "A web browser will launch and take you to the"
echo "guacamole instance you just installed"
echo
echo "please log in with the default credentials"
echo "guacadmin guacadmin"
echo "and change the password"
echo "feel free to add a user account for yourself as well"
echo
echo
echo "CLOSE THE BROWSER WHEN DONE"
read -rsp $'Press any key to continue...\n' -n1 key
firefox http://localhost:8080/guacamole

