#!/bin/bash
# Makes xrdp from source
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y
ansible-playbook /usr/local/bin/ACG-Package-Suite/ubuntu/playbooks/install_xrdp.yml --ask-sudo-pass
