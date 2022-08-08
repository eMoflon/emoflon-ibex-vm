#!/bin/bash

#
# Config
#

ECLIPSE_ARCHIVE=eclipse-emoflon-linux-user

set -e
START_PWD=$PWD

#
# Utils
#

# Displays the given input including "=> " on the console.
log () {
	echo "=> $1"
}

#
# Script
#

log "Start provisioning."

# Updates
log "Installing updates."
sudo apt-get update
sudo apt-get upgrade -y

# Java/JDK17
log "Installing OpenJDK."
sudo apt-get install -y openjdk-17-jdk
#java --version

# eMoflon Eclipse
log "Installing eMoflon Eclipse."
sudo apt-get install -y graphviz
mkdir -p ~/eclipse-apps
cd ~/eclipse-apps

# Get eclipse
if [[ ! -f "./$ECLIPSE_ARCHIVE.zip" ]]; then
	log "Downloading latest eMoflon Eclipse archive from Github."
	curl -s https://api.github.com/repos/eMoflon/emoflon-eclipse-build/releases/latest \
        | grep "$ECLIPSE_ARCHIVE.zip" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | wget -i - \
        || :
fi

if [[ ! -f "./$ECLIPSE_ARCHIVE.zip" ]]; then
        log "Download of eMoflon Eclipse archive failed."
        exit 1;
fi

unzip -qq -o $ECLIPSE_ARCHIVE.zip
rm -f $ECLIPSE_ARCHIVE.zip

# Create desktop launcher
printf "
[Desktop Entry]\n
Version=1.0
Name=eMoflon Eclipse
Comment=Use eMoflon Eclipse
GenericName=eMoflon Eclipse
Exec=/home/vagrant/eclipse-apps/eclipse/eclipse
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/home/vagrant/eclipse-apps/eclipse/icon.xpm
StartupNotify=true
" >> /home/vagrant/Desktop/emoflon.desktop
chmod u+x /home/vagrant/Desktop/emoflon.desktop

log "Finished provisioning."
