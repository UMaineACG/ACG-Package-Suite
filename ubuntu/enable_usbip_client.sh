#!/bin/bash

echo "Making doubly-sure USB IP is installed..."
sudo apt-get install -y usbip > /dev/null &
wait
echo "Done!"

echo "Adding needed kernel modules..."
sudo modprobe vhci-hcd
echo "Kernel modules added!"

echo "But let's check to make sure..."
sudo lsmod | grep vhci-hcd
echo "Everything look good? Let's move on."

echo "Adding modules to /etc/modules..."
sudo echo "vhci-hcd" >> /etc/modules
echo "Modules added!"
