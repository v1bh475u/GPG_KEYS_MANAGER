#!/bin/bash
configure(){

if ! command -v lolcat &> /dev/null
then
echo "lolcat is not installed. Please give permission to install it."
sudo apt-get update
sudo apt-get install lolcat
fi
if ! command -v  figlet &> /dev/null
then
echo "figlet is not installed. Please give permission to install it."
sudo apt-get update
sudo apt-get install figlet
fi

}