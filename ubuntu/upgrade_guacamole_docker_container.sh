#!/bin/bash

echo "Only run this if guacamole was deployed with install_guacamole.sh."
echo "It assumes docker is installed, the user is part of the docker group,"
echo "and that the containers are using the default naming." 

read -p "Continue [y/N] " ANSWER
if [ "$ANSWER" != "y" -a "$ANSWER" != "Y" -a "$ANSWER" != "yes" -a "$ANSWER" != "Yes" ]
then
	exit
fi

# get the mysql root password
MYSQL_ROOT_PASSWORD=$(docker inspect --format '{{ index (index .Config.Env)}}' mysql | sed -E 's/.*MYSQL_ROOT_PASSWORD=//' | awk '{print $1}')

# get the mysql guacamole_user password
MYSQL_GUACAMOLE_USER_PASSWORD=$(docker inspect --format '{{ index (index .Config.Env)}}' guacamole | sed -E 's/.*MYSQL_PASSWORD=//' | awk '{print $1}')

# get the mysql volume name
MYSQL_VOLUME_NAME=$(docker inspect --format '{{ index (index .Mounts)}}' mysql | awk '{print $2}')


# pull new container images
echo "Pulling new images"
docker pull nginx
docker pull mysql
docker pull guacamole/guacd
docker pull guacamole/guacamole
echo ""

# stop all container
echo "Stopping current containers"
docker stop nginx-ssl
docker stop guacamole
docker stop guacd
docker stop mysql
echo ""

# rm all container
echo "Removing old containers"
docker rm nginx-ssl
docker rm guacamole
docker rm guacd
docker rm mysql
echo ""

# start new containers
echo "Starting new mysql container"
docker run --restart=always --detach --name=mysql --env="MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --publish 3306:3306 -v $MYSQL_VOLUME_NAME:/var/lib/mysql mysql
echo ""

# make sure there's time for the update to happen, 30 seconds might not be enough
echo "Waiting 30 seconds for database update to complete"
echo ""

sleep 30
echo "Starting new guacd container"
docker run --restart=always --name guacd -d guacamole/guacd
echo ""

echo "Starting new guacamole container"
docker run --restart=always --name guacamole  --link mysql:mysql --link guacd:guacd -e MYSQL_HOSTNAME=127.0.0.1 -e MYSQL_DATABASE=guacamole_db -e MYSQL_USER=guacamole_user -e "MYSQL_PASSWORD=$MYSQL_GUACAMOLE_USER_PASSWORD" --detach -p 8080:8080 guacamole/guacamole
echo ""

echo "Starting new nginx container"
docker run --restart=always --name nginx-ssl -p 80:80 -p 443:443 -v $HOME/.config/ACG/nginx:/etc/nginx/conf.d --link guacamole:guacamole -d nginx
echo ""

echo "Upgrade finished"
