#!/bin/bash
#Matlab

check_for_key() {
  read -s -n 1 key
}

printf  "\n\n This script was created based on the install procedure here\n"
printf  "\nhttps://umaine.edu/it/software/\n"
printf "\nIf you have trouble you should check it out\n"
printf "Several times during the install, firefox will be launched \nfor you to interact with the MathWorks web site.\n"
printf "\nAfter doing what needs to be done, close the browser to get \nback to this script\n"
printf  "\nPress enter to continue\n"
check_for_key
clear

echo "To install Matlab you must have an account with the mathworks."
echo "A firefox web browser will launch and take you to their site."
echo "You may either log in with an existing account or create a new one."
echo
echo "When you are done, please close the window."
echo "If you are already logged in, just close the window."
echo
echo "Press enter to continue"
check_for_key
firefox https://www.mathworks.com/login
clear

echo "Now you must download Matlab. A web browser will open up to the download page."
echo "You must sign in with your newly created account to download the installe r."
echo "Download the Linux (64-bit) version, and make sure to click 'Save File'"
echo "Once you have downloaded it, please close the browser window."
echo
echo "It may not be obvious that the download has taken place as it generally happens quickly"
echo
echo "Press enter to continue"
check_for_key
firefox http://www.mathworks.com/downloads/
clear

echo "The installer will now automatically install Matlab. When it completes," 
echo "it will open up and ask if you accept the license agreement (please do)"
echo "Next, you will need to sign in and selectthe UMaine license, choose an"
echo "installation folder (stick with the default), and select which products"
echo "to install.  Selecting more products increases the time to install and"
echo "the space required."
echo
echo "Finally, it will give you an option to"
echo ""\"Create symbolic links to MATLAB scripts in:\""
echo "please check the box (it is not checked by default) and leave the path as is"
echo
echo "Press enter to continue"
check_for_key
mkdir /tmp/matlab
unzip ~/Downloads/matlab*.zip -d /tmp/matlab
sudo /tmp/matlab/install
rm -f ~/Downloads/matlab*.zip
rm -rf /tmp/matlab
rmdir /tmp/matlab
sudo apt-get update
sudo apt-get install -y matlab-support
echo "Done"
