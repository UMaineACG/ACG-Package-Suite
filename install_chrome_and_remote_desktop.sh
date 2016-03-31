#!/bin/bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo dpkg -i google-chrome*.deb
sudo apt-get install -f -y xvfb-randr  xbase-clients python-psutil libappindicator1 

sudo wget http://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg -i chrome-remote-desktop*.deb
sudo apt-get -f -y install
sudo apt-get install -f -y xvfb python-psutil xbase-clients xrandr
sudo dpkg -i chrome-remote-desktop*.deb
for USER in '/home/*' 
   do echo "startxfce4" >>$USER/.chrome-remote-desktop-session
    echo "export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1024x768">>$USER/.bashrc
done
