#!/bin/bash
#Moose multiphysics framework
/usr/local/bin/ACG-Package-Suite/ubuntu/install_ansible.sh
ansible-playbook playbooks/moose.yml --ask-sudo-pass
