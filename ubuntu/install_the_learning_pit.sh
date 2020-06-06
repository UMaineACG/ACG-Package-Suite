#!/bin/bash
#thelearningpit

check_for_key() {
  read  -s -n 1 key
}

printf  "\n\nThis script installs an older, 32 bit only windows program to\n"
printf  "run in a 32 bit wine environment.  If you already have wine\n"
printf "installed (and are using it), you should not proceed.  This \n"
printf "will interfere with an existing wine installation. \n\n"
printf "proceed? (Y/N)"

check_for_key

echo $key

if  [ "$key" != "Y" ] && [ "$key" != "y" ]
then
    echo "Bailing out"
    exit 1
fi

echo "Installing wine"

rm -rf ~/.wine
export WINEARCH=win32
echo "export WINEARCH=win32" >>~/.bashrc
sudo apt-get update
sudo apt-get install -y -f wine winetricks

echo
echo "installing necessary 32 bit libraries"
echo
winetricks -q mfc42
winetricks -q msvcirt
winetricks -q richtx32
winetricks -q vb6run
winetricks -q vcrun6sp6
echo
echo "installing the actual program"

cd
cd Desktop
wget http://thelearningpit.com/ftp/install.exe
wine install.exe




