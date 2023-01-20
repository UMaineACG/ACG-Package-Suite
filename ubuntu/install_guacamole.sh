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
#    echo
#    read -s -p "Enter FQDN for SSL Certificate Generation (leave blank to use public IP): " FQDN
#    echo

sudo apt-get -y install docker mysql-client wget
mkdir /tmp/guacamole
cd /tmp/guacamole
# sudo ufw disable
wget https://raw.githubusercontent.com/MysticRyuujin/guac-install/master/docker-install.sh
chmod +x docker-install.sh
#sed -i 's/sleep 30/sleep 90/' docker-install.sh
#sed -i 's/Waiting 30/Waiting 90/' docker-install.sh
sed -i 's%guacamole/guacd%-v /tmp:/home guacamole/guacd%' docker-install.sh

sudo ./docker-install.sh -m "$mysqlrootpassword" -g "$guacdbuserpassword" 

##############################################
# Setup nginx with a self signed certificate #
##############################################
# create the nginx configuration directory structure in the /opt/ACG directory
#CONFIG_DIR=$HOME/.config/ACG/nginx
DOCKER_COMPOSE_CONFIG_DIR=/opt/ACG/letsencrypt
CONFIG_DIR=$DOCKER_COMPOSE_CONFIG_DIR/nginx/nginx/site-confs
DOCKER_COMPOSE_FILE=$DOCKER_COMPOSE_CONFIG_DIR/docker-compose.yml

# add a connection to this machine
SQLCODE="
use guacamole_db;
replace into guacamole_connection(connection_id, connection_name, protocol) values(1,'guacamole_server','rdp');
replace into guacamole_connection_permission(entity_id,connection_id,permission) values(1,1,'READ'),(1,1,'UPDATE'),(1,1,'DELETE'),(1,1,'ADMINISTER');
replace into guacamole_connection_parameter(connection_id,parameter_name,parameter_value) values(1,'console-audio','true'),(1,'hostname','172.17.0.1'),(1,'port','3389'),(1,'ignore-cert','true');
"
# Execute SQL Code
echo $SQLCODE | mysql -h 127.0.0.1 -P 3306 -u root -p$mysqlrootpassword

# configure nginx with https as a reverse proxy and make guacamole available at the base address and /guacamole
REPLACESTR='location \/guacamole {
        proxy_pass http:\/\/guacamole:8080\/guacamole\/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$http_connection;
        access_log off;
    }

    location \/ {
        proxy_pass http:\/\/guacamole:8080\/guacamole\/;
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$http_connection;
        proxy_cookie_path \/guacamole\/ \/;
        access_log off;
    }'

# install letsencrypt and nginx in a docker container
/usr/local/bin/ACG-Package-Suite/ubuntu/install_letsencrypt.sh

# wait for the letsencrypt container to create the necessary files
echo "Waiting for letsencrypt container to be ready"
while [ ! -f $CONFIG_DIR/default.conf ]
do
       sleep 1
done

# stop the container to change the configuration
sudo docker-compose -f $DOCKER_COMPOSE_FILE down

# add the guacamole location sections
perl -0777 -pi -e "s#location / {\s+\# enable.*?}#$REPLACESTR#s" $CONFIG_DIR/default.conf

# Use the same network as the other containers and link to guacamole
REPLACESTR='    external_links:
      - guacamole:guacamole
    network_mode: bridge'
echo "$REPLACESTR" >> $DOCKER_COMPOSE_FILE

# restart the container with the new configuration
sudo docker-compose -f $DOCKER_COMPOSE_FILE up -d

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
echo "CLOSE THE BROWSER WHEN DONE"
read -rsp $'Press any key to continue...\n' -n1 key
firefox https://localhost

