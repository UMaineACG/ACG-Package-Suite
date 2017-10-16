#!/bin/bash
# Unity game engine
# see https://forum.unity.com/threads/unity-on-linux-release-notes-and-known-issues.350256/
# for more info and possibly later versions
mkdir /tmp/ACG
# don't need the sudo on the next command, but want to get it out of the way before 
# the download that takes some time
sudo cd /tmp/ACG
wget http://beta.unity3d.com/download/2b451a7da81d/unity-editor_amd64-2017.2.0xb6Linux.deb
sudo dpkg -i unity-editor*.deb
sudo apt-get install -f -y
sudo dpkg -i unity-editor*.deb
sudo apt-get install -f -y mono-complete

