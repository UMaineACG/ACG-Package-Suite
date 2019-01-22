#!/bin/bash
#USB IP (Connect USB to server)
sudo apt-get update
sudo apt-get install -y linux-image-generic
#sudo apt-get install -y  linux-image-extra-$(uname -r)
sudo apt-get install -y linux-tools-common
sudo apt-get install -y linux-tools-generic
sudo apt-get install -y linux-cloud-tools-generic
#sudo apt-get install -y linux-tools-$(uname -r)
# Load Kernel modules for client and server
sudo modprobe usbip-core
sudo modprobe vhci-hcd
sudo modprobe usbip-host
# add them to /etc/modules
echo 'usbip-core' | sudo tee -a /etc/modules
echo 'vhci-hcd' | sudo tee -a /etc/modules
echo 'usbip-host' | sudo tee -a /etc/modules
# Start the daemon
sudo usbipd -D
# add it to /etc/rc.local
# first delete the last line which is exit 0
sudo sed -i '$ d' /etc/rc.local
# now append the line we need to add and append exit 0 after that
echo 'usbipd -D' |sudo tee -a /etc/rc.local
echo 'exit 0' |sudo tee -a /etc/rc.local
