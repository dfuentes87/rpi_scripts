#!/bin/bash

### Setup a Raspberry Pi (on Debian/Raspbian/Ubuntu) with Ubiquiti UniFi Controller ###

color='\033[1;31m'
nocolor='\033[0m'

echo -e "${color}By using this script, you'll fully update the system and install the UniFi Controller.\n\n${nocolor}"
read -rp "Proceed?: (ctrl+C to cancel)" answer

echo -e "${color}\n\nThe system will now upgrade all the software, as well as clean up old/unused \
packages.\n\n${nocolor}"
apt update && apt upgrade -y && apt autoremove && apt autoclean

echo -e "${color}\n\nBefore installing the UniFi Controller, we need to first install OpenJDK 8.\n\n${nocolor}"
apt install openjdk-8-jre-headless -y

echo -e "${color}\n\nIn order to fix an issue which can cause a slow start for the UniFi controller, \
'haveged' is installed.\n\n${nocolor}"
apt install haveged -y

echo -e "${color}\n\nThe UniFi Controller will now be installed.\n\n${nocolor}"
apt install ca-certificates apt-transport-https
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | \
tee /etc/apt/sources.list.d/100-ubnt-unifi.list
wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
apt update && apt install unifi -y
