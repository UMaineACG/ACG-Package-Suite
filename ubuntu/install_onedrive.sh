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
echo " list the onedrive folders you wish to sync, one per line in that file"
echo "***********************************************"
