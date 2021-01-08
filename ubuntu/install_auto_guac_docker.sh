#!/bin/bash

#Install Stuff
sudo apt-get update
sudo apt-get -y install docker.io mysql-client wget

sudo apt-get install -y python3-openstackclient
sudo apt-get install -y python3-pip
sudo python3 -m pip install mysql-connector-python

sudo mkdir /etc/auto_guac
cd /etc/auto_guac
sudo git clone https://github.com/segee/auto_guac
sudo git clone https://github.com/segee/Openstack_shell_scripts
cd -
cd /etc/auto_guac/Openstack_shell_scripts
cd -

sudo cp /etc/auto_guac/auto_guac/auto_guac_for_docker.service /etc/systemd/system/.
sudo systemctl enable auto_guac_for_docker.service

echo
echo
echo "Log in to openstack and download the RC file for the project"
echo "go to project->access and security->API access"
echo "and click Download OpenStack RC file"
read -rsp $'Press any key to continue...\n' -n1 key
firefox http://cloud.acg.maine.edu
sudo cp ~/Downloads/*openrc.sh /etc/auto_guac/Openstack_shell_scripts/.
echo
echo
echo
echo "Finally, to be able to access openstack to start and stop machines,"
echo "you need to create a file called my_password in the directory"
echo "/etc/Openstack_shell_scripts that contains your openstack password"
echo "please chmod 000 my_password to prevent inadvertent access"
