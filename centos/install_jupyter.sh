#!/bin/bash
#JupyterHub
echo "Installing base dependencies..."
sudo yum install python3 python3-pip npm nodejs-legacy openssl > /dev/null &
wait
echo "Base dependencies installed!"

echo "Installing node dependencies..."
sudo npm install -g configurable-http-proxy > /dev/null &
wait
echo "Node dependencies installed!"

echo "Installing JupyterHub and JupyterHub Notebook..."
sudo pip3 install jupyterhub > /dev/null &
wait
sudo pip3 install --upgrade notebook > /dev/null &
wait
echo "JupyterHub and JupyterHub Notebook installed!"

printf "\n\n\n"

echo "Configuring JupyterHub..."
sudo jupyterhub --generate-config
sudo mkdir -p /var/jupyterhub-data && cd /var/jupyterhub-data

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout server.key -out server.crt
echo "To start the JupyterHub server, run 'jupyterhub --ip 0.0.0.0 --port 443 --ssl-key /var/jupyterhub-data/server.key --ssl-cert /var/jupyterhub-data/server.crt' as root."
