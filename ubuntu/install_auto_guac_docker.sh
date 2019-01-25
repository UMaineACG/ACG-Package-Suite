#!/bin/bash

# with grateful acknowledgement to:
#https://github.com/MysticRyuujin/guac-install/blob/master/docker-install.sh

cd /tmp
mkdir guac_install
cd -
cd /tmp/guac_install



# Version number of Guacamole to install
GUACVERSION="1.0.0"

# Get script arguments for non-interactive mode
while [ "$1" != "" ]; do
    case $1 in
        -m | --mysqlpwd )
            shift
            mysqlpwd="$1"
            ;;
        -g | --guacpwd )
            shift
            guacpwd="$1"
            ;;
    esac
    shift
done

# Get MySQL root password and Guacamole User password
if [ -n "$mysqlpwd" ] && [ -n "$guacpwd" ]; then
        mysqlrootpassword=$mysqlpwd
        guacdbuserpassword=$guacpwd
else
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
     while true
    do
        read -s -p "Enter the openstack password for the openstack user" openstackpassword
        echo
        read -s -p "Confirm openstack user Password: " password2
        echo
        [ "$openstackpassword" = "$password2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
    echo
fi

#Install Stuff
sudo apt-get update
sudo apt-get -y install docker.io mysql-client wget

# Set SERVER to be the preferred download server from the Apache CDN
SERVER="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUACVERSION}"

# Download Guacamole authentication extensions
wget -O guacamole-auth-jdbc-${GUACVERSION}.tar.gz ${SERVER}/binary/guacamole-auth-jdbc-${GUACVERSION}.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download guacamole-auth-jdbc-${GUACVERSION}.tar.gz"
    echo "${SERVER}/binary/guacamole-auth-jdbc-${GUACVERSION}.tar.gz"
    exit
fi

tar -xzf guacamole-auth-jdbc-${GUACVERSION}.tar.gz

# Start MySQL
sudo docker run --restart=always --detach --name=mysql --env="MYSQL_ROOT_PASSWORD=$mysqlrootpassword" --publish 3306:3306 mysql

# Sleep to let MySQL load (there's probably a better way to do this)
#echo "Waiting 30 seconds for MySQL to load"
#sleep 30
# just do other stuff
sudo apt-get install -y python-openstackclient
sudo apt-get install -y python-pip
sudo python -m pip install mysql-connector-python

# Create the Guacamole database and the user account
# SQL Code
SQLCODE="
create database guacamole_db; 
create user 'guacamole_user'@'%' identified by '$guacdbuserpassword'; 
GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'guacamole_user'@'%'; 
flush privileges;"

# Execute SQL Code
echo $SQLCODE | mysql -h 127.0.0.1 -P 3306 -u root -p$mysqlrootpassword

cat guacamole-auth-jdbc-${GUACVERSION}/mysql/schema/*.sql | mysql -u root -p$mysqlrootpassword -h 127.0.0.1 -P 3306 guacamole_db
SQLCODE="
replace into guacamole_connection(connection_id, connection_name, protocol) values(1,'guacamole_server','rdp');
replace into guacamole_connection_permission(entity_id,connection_id,permission) values(1,1,'READ'),values(1,1,'WRITE'),values(1,1,'DELETE'),values(1,1,'ADMINISTER');
replace into guacamole_connection_parameter(connection_id,parameter_name,parameter_value) values(1,'console-audio','true'),(1,'172.17.0.1','$temp2'),(1,'port','3389');
"
# Execute SQL Code
echo $SQLCODE | mysql -h 127.0.0.1 -P 3306 -u root -p$mysqlrootpassword


sudo docker run --restart=always --name guacd -d guacamole/guacd
sudo docker run --restart=always --name guacamole  --link mysql:mysql --link guacd:guacd -e MYSQL_HOSTNAME=127.0.0.1 -e MYSQL_DATABASE=guacamole_db -e MYSQL_USER=guacamole_user -e MYSQL_PASSWORD=$guacdbuserpassword --detach -p 8080:8080 guacamole/guacamole

sudo rm -rf guacamole-auth-jdbc-${GUACVERSION}*
cd -
sudo mkdir /etc/auto_guac
cd /etc/auto_guac
sudo git clone https://github.com/segee/auto_guac
sudo git clone https://gogs.acg.maine.edu/segee/Openstack_shell_scripts
cd -
cd /etc/auto_guac/Openstack_shell_scripts
echo "echo $openstackpassword > my_password" | sudo bash
sudo chmod 000 my_password
cd -

sudo cp /etc/auto_guac/auto_guac/auto_guac_for_docker.service /etc/systemd/system/.
sudo systemctl enable auto_guac_for_docker.service

echo 
echo
echo
echo "This is very important"
echo "we are almost done"
echo "but not quite"
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
echo
echo
echo
echo "Last step..."
echo "Log in to openstack and download the RC file for the project"
echo "go to project->access and security->API access"
echo "and click Download OpenStack RC file"
read -rsp $'Press any key to continue...\n' -n1 key
firefox http://openstack.acg.maine.edu
sudo cp ~/Downloads/*openrc.sh /etc/auto_guac/Openstack_shell_scripts/.
