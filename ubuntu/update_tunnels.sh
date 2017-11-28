#!/bin/bash
if [ $1 -lt 0 ] || [ $1 -gt 255 ]
then
    echo Ip must be between 0-255
    exit
fi
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y
ansible-playbook /usr/local/bin/ACG-Package-Suite/ubuntu/playbooks/update_tunnels.yml --ask-sudo-pass --extra-vars "vm_ip=$1"
