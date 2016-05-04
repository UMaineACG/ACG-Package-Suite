#!/bin/bash

if $(cat /etc/*-release) == *"Ubuntu"*; then
  sh /usr/local/bin/ACG-Package-Suite/ubuntu/install_xfce_desktop.sh
else
  sh /usr/local/bin/ACG-Package-Suite/centos/install_gnome_desktop.sh
fi