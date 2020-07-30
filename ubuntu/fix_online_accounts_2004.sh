#!/bin/bash
sudo apt-get install -y gnome-control-center gnome-online-accounts
sudo rm /etc/netplan/*.yaml
printf "network:\n  version: 2\n  renderer: NetworkManager\n" |sudo tee -a /etc/netplan/01-bruce.yaml
sudo netplan generate
sudo netplan apply
sudo service network-manager restart

