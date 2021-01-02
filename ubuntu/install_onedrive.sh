#!/bin/bash

# good info here https://launchpad.net/~yann1ck/+archive/ubuntu/onedrive
## and here:https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html

sudo apt-get remove onedrive
sudo add-apt-repository ppa:yann1ck/onedrive

sudo apt-get update

sudo apt-get install onedrive

echo
echo "***********************************************"
echo " onedrive is now installed, but it must be configured on a per user basis"
echo " There are good directions here: https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html
echo
echo " A word of caution is that the default is to synchronize all files (could be a lot)"
echo " After setting up onedrive, and before syncing, create a file in ~/.config/onedrive named sync_list"
 16:14:34 up 14 days,  1:25,  1 user,  load average: 0.00, 0.06, 0.03
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
bruce    :1       :1               Sun16   ?xdm?   3:17m  0.01s /usr/lib/gdm3/gdm-x-session --run-script env GNOME_SHELL_SESSION_MODE=ubuntu /usr/bin/gnome-session --systemd --session=ubuntu
echo "***********************************************"
