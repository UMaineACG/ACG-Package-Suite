#!/bin/bash
sudo yum update -y
sudo yum install epel-release -y
sudo yum install ansible -y
ansible-playbook /usr/local/bin/ACG-Package-Suite/centos/playbooks/install_xrdp.yml --ask-sudo-pass
