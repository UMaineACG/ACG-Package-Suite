#!/bin/bash
#Enable USBIP client

echo "Adding needed kernel modules..."
sudo modprobe vhci-hcd
echo "Kernel modules added!"

echo "But let's check to make sure..."
sudo lsmod | grep vhci-hcd
echo "Everything look good? Let's move on."

echo "Adding modules to /etc/modules..."
sudo echo "vhci-hcd" >> /etc/modules
echo "Modules added!"
