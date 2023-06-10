#! /bin/bash

printf "Updating...\n"
sudo apt-get update

printf "\nInstalling sqlite3\n"
sudo apt-get install sqlite3

printf "\nEditing pagen file permissions\n"
chmod +x pagen.sh

printf "\nPagen copy to /usr/bin/\n"
sudo cp pagen.sh /usr/bin/pagen

printf "\nCompleted!\n"