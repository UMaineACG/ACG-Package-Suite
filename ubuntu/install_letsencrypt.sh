#!/bin/bash
CONFIG_DIR_BASE="/opt/ACG/letsencrypt"
DOCKER_COMPOSE_FILE="$CONFIG_DIR_BASE/docker-compose.yml"
DOCUMENTATIONSTR="Documentation available at https://docs.google.com/document/d/1kQ6GJrnDsTZccCvpy_T3DQ8XsS2p3nGrIB29r3LNcc4"

LETSENCRYPT=$(sudo docker ps -a | grep letsencrypt)
if [ -e "$DOCKER_COMPOSE_FILE" ]
then
	echo "letsencrypt docker-compose file already exists at $DOCKER_COMPOSE_FILE"
	echo "$DOCUMENTATIONSTR"
	exit
fi

echo
echo "Before beginning, make sure to do the following
    1)  Assign a floating IP to the VM.
    2)  Assign security groups and rules to open ports 80 and 443 (must be publicly accessible to use letsencrypt).
    2)  If using a self supplied FQDN, create DNS entries to allow letsencrypt to generate the certificates (not necessary when using floating IP based naming scheme)."

echo
read -p "Enter email address for SSL Certificate Generation: " EMAIL
echo
read -p "Enter FQDN (leave blank to use floating IP based naming scheme): " FQDN
echo

if [ -z "$FQDN" ]
then
	IPINFO_IP=$(wget http://ipinfo.io/ip -qO -); 
	while true
	do
		echo
		read -p "Enter valid floating IP (leave blank to use found IP '$IPINFO_IP'): " FLOATING_IP
		echo
		if [ -z "$FLOATING_IP" ]
		then
			FLOATING_IP=$IPINFO_IP
		elif [ "$FLOATING_IP" != "$IPINFO_IP" ]
		then
			echo "ERROR:  Floating IP '$FLOATING_IP' does not match actual IP '$IPINFO_IP'"
			continue
		fi
		FLOATING_IP=$(echo "$FLOATING_IP" | sed 's/\./-/g')
		FQDN="acg-floating-$FLOATING_IP.acg.maine.edu"
		break
	done
fi

#echo "$FQDN"
#echo "$EMAIL"

# get the uuid of the user
PUID=$(id -u)
# get the guid of the user
GUID=$(id -g)

# create the nginx configuration directory structure in the users home config directory
CONFIG_DIR_NAME="nginx"
CONFIG_NAME="$CONFIG_DIR_BASE/$CONFIG_DIR_NAME"
# make the directory and sub-directories if necessary
if [ ! -d "$CONFIG_NAME" ]
then
	# get the username
	USERNAME=$(id -nu)
	# get the group
	GROUPNAME=$(id -ng)
	# make the configuration directory
	sudo mkdir -p "${CONFIG_NAME}"
	# change the ownership to the user
	cmd="sudo chown -R ${USERNAME}:${GROUPNAME} ${CONFIG_DIR_BASE}"
	eval "$cmd"
fi

# construct the docker-compose file
DOCKER_COMPOSE_DATA="version: '3'

services:
  letsencrypt:
    image: linuxserver/swag
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
    volumes:
      - ./$CONFIG_DIR_NAME:/config
    environment:
      - PUID=$PUID
      - PGID=$GUID
      - TZ=America/New_York
      - URL=$FQDN
      - VALIDATION=http
      - EMAIL=$EMAIL
#      - EXTRA_DOMAINS=
      - STAGING=false
    ports:
      - 443:443
      - 80:80"

# write the docker-compose.yml file to the config directory
echo "$DOCKER_COMPOSE_DATA" > $DOCKER_COMPOSE_FILE

# install docker-compose
sudo apt update
sudo apt -y install docker docker-compose wget

# bring up the containers
sudo docker-compose -f $DOCKER_COMPOSE_FILE up -d

echo ""
echo ""
echo ""
echo "Important Information"
echo "    FQDN: $FQDN"
echo "    Site Directory: $CONFIG_NAME/www/\n"
echo "$DOCUMENTATIONSTR"
