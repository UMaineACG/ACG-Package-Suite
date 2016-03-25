#!/bin/bash
sudo apt-get update
sudo apt-get install -f -y git
cd /usr/local/bin
sudo git clone https://github.com/UMaineACG/ACG-Package-Suite.git
export PATH=$PATH:/usr/local/bin/ACG-Package-Suite
cd ACG-Package-Suite
echo PATH=$PATH | sudo tee /etc/environment
for SCRIPT in *.sh
   do sudo chmod 755 $SCRIPT;
done
echo "0 0 * * * /usr/local/bin/ACG-Package-Suite/update_suite.sh" | sudo crontab -

