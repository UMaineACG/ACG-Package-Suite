#!/bin/bash

# good info here https://launchpad.net/~yann1ck/+archive/ubuntu/onedrive
## and here:https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html

sudo apt-get remove -y onedrive
sudo add-apt-repository ppa:yann1ck/onedrive -y

sudo apt-get update

sudo apt-get install -y onedrive

echo
echo "***************************************************************************"
echo " onedrive is now installed, but it must be configured on a per user basis."
echo " There are good directions here:"

echo "https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html"
echo
echo ' A word of caution is that the default is to synchronize all files'
echo '(could be a lot).'
echo
echo " After setting up onedrive, and before syncing, create a file in"
echo "~/.config/onedrive named sync_list"
echo " list the onedrive folders you wish to sync, one per line in that file."
echo "**************************************************************************"
