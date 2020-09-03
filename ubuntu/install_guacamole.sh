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
    read -s -p "Enter FQDN for SSL Certificate Generation (leave blank to use public IP): " FQDN
    echo

sudo apt-get -y install docker.io mysql-client wget
mkdir /tmp/guacamole
cd /tmp/guacamole
# sudo ufw disable
wget https://raw.githubusercontent.com/MysticRyuujin/guac-install/master/docker-install.sh
chmod +x docker-install.sh
sed -i 's/sleep 30/sleep 90/' docker-install.sh
sed -i 's/Waiting 30/Waiting 90/' docker-install.sh
sed -i 's%guacamole/guacd%-v /tmp:/home guacamole/guacd%' docker-install.sh

sudo ./docker-install.sh -m "$mysqlrootpassword" -g "$guacdbuserpassword" 

##############################################
# Setup nginx with a self signed certificate #
##############################################
# create the nginx configuration directory structure in the local users home config directory
CONFIG_DIR=$HOME/.config/ACG/nginx
# make the directory and sub-directories if necessary
if [ ! -d $CONFIG_DIR/certs ]
then
	mkdir -p $CONFIG_DIR/certs
fi

# configure nginx with https as a reverse proxy and make guacamole available at the base address and /guacamole
NGINX_CONFIG='server {
	listen 80 default_server;
	server_name _;
	return 301 https://$host$request_uri;
}

server {

	listen 443 ssl default_server;
	listen [::]:443 ssl default_server;

	ssl_certificate /etc/nginx/conf.d/certs/server.crt;
	ssl_certificate_key /etc/nginx/conf.d/certs/server.key;

	location /guacamole {
		proxy_pass http://guacamole:8080/guacamole/;
		proxy_buffering off;
		proxy_http_version 1.1;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection $http_connection;
		access_log off;
	}

	location / {
		proxy_pass http://guacamole:8080/guacamole/;
		proxy_buffering off;
		proxy_http_version 1.1;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection $http_connection;
		proxy_cookie_path /guacamole/ /;
		access_log off;
	}

}'

echo -e "$NGINX_CONFIG" > $CONFIG_DIR/default.conf

if [ -z "$FQDN" ]
then
	# find the external IP address to generate the 1 year self signed SSL cert and place it in the configuration directory structure
	FQDN=$(wget http://ipinfo.io/ip -qO -); 
fi

openssl req -newkey rsa:2048 -nodes -keyout $CONFIG_DIR/certs/server.key -x509 -days 365 -out $CONFIG_DIR/certs/server.crt -subj "/C=US/ST=ME/L=Orono/O=Univserity of Maine System/OU=Advanced Computing Group/CN=$FQDN"

# start up the nginx container with 
#    ports 80 and 443 bound to the host ports
#    mounted with the configuration directory created above
#    linked to the guacamole container
sudo docker run --restart=always --name nginx-ssl -p 80:80 -p 443:443 -v $CONFIG_DIR:/etc/nginx/conf.d  --link guacamole:guacamole -d nginx

sudo systemctl enable --now docker.service

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
echo "Guacamole is currently installed with a self-signed"
echo "SSL certificate and browsers will show the connection"
echo "as being insecure. If you need a valid certificate/FQDN"
echo "please reach out to us at acg@maine.edu."
echo
echo "CLOSE THE BROWSER WHEN DONE"
read -rsp $'Press any key to continue...\n' -n1 key
firefox https://localhost

