#!/bin/bash
#Enable USBIP client
mod=vhci-hcd
file=/etc/modules

echo "Adding needed kernel modules..."
sudo modprobe $mod
echo "Kernel modules added!"

echo "But let's check to make sure..."
sudo lsmod | grep vhci-hcd
echo "Everything look good? Let's move on."

echo "Adding modules to /etc/modules..."
grep -Fqx $mod $file || echo $mod |sudo tee -a  $file
echo "Modules added!"
