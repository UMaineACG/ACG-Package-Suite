#!/bin/bash
#Desktop Environment
sudo yum groupinstall "GNOME Desktop" "Graphical Administration Tools"
sudo yum install libreoffice

# Run GDM on system boot
sudo systemctl enable gdm.service
