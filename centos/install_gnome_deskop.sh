#!/bin/bash
#Desktop Environment
yum groupinstall "GNOME Desktop" "Graphical Administration Tools"

# Run GDM on system boot
ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target