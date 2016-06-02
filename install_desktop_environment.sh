#!/bin/bash

if grep -q "Ubuntu"  /etc/*-release; then
  sudo sh /usr/local/bin/ACG-Package-Suite/ubuntu/install_xfce4_desktop.sh
else
  sudo sh /usr/local/bin/ACG-Package-Suite/centos/install_gnome_desktop.sh
fi
