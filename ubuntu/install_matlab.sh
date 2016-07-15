#!/bin/bash
#Matlab

check_for_key() {
  read -s -n 1 key
}

printf  "This script was created based on the install procedure here\n"
printf  "\nhttps://umaine.edu/it/software/\n"
printf "\nIf you have trouble you should check it out\n"
printf "Several times during the install, firefox will be launched \nfor you to interact with the MathWorks web site.\n"
printf "\nAfter doing what needs to be done, close the browser to get \nback to this script\n"
printf  "\nPress any key to continue\n"
check_for_key
clear

echo "To install Matlab you must have an account with the mathworks."
echo "A firefox web browser will launch and take you to their site."
echo "You may either log in with an existing account or create a new one. When you are done, please close the window."
echo "Press any key to continue"
check_for_key
firefox https://www.mathworks.com/login
clear

echo "Now you must download Matlab. A web browser will open up to the download page."
echo "You must sign in with your newly created account to download the installer."
echo "You need to download the Linux (64-bit) version, and make sure to click 'Save File'"
echo "Once you have downloaded it, please close the browser window."
echo "It may not be obvious that the download has taken place as it generally happens quickly"
echo "Press any key to continue"
check_for_key
firefox http://www.mathworks.com/downloads/
clear

echo "The installer will now automatically install Matlab. When it completes, it will open up"
echo "It will ask if you accept the license agreement and you will need to sign in and select"
echo "the UMaine license, choose an installation folder (stick with the default), and select"
echo "which products to install.  Selecting more products increases the time to install and"
echo "the space required."
echo "Finally, it will give you an option to \"Create symbolic links to MATLAB scripts in:\""
echo "please check the box (it is not checked by default) and leave the path as is"
echo "Press any key to continue"
check_for_key
mkdir /tmp/matlab
unzip ~/Downloads/matlab*.zip -d /tmp/matlab
sudo /tmp/matlab/install
rm -f ~/Downloads/matlab*.zip
rm -rf /tmp/matlab
rmdir /tmp/matlab
sudo apt-get install matlab-support
echo "Done"
