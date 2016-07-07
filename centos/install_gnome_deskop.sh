#!/bin/bash
#Desktop Environment
sudo yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools"
sudo yum install -y libreoffice

# Run GDM on system boot
sudo systemctl -f enable gdm.service
