#!/bin/bash

#Make sure we're running as root.
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi


echo "Updating software sources..."
apt-get update &
wait
echo "Software sources updated!"

echo "Installing base dependencies..."
apt-get install python3 python3-pip npm nodejs-legacy &
wait
echo "Base dependencies installed!"

echo "Installing node dependencies..."
npm install -g configurable-http-proxy &
wait
echo "Node dependencies installed!"

echo "Installing JupyterHub and JupyterHub Notebook..."
pip3 install jupyterhub &
wait
pip3 install --upgrade notebook &
wait
echo "JupyterHub and JupyterHub Notebook installed!"

echo "To start the JupiyterHub server, run 'jupyterhub' as root."
