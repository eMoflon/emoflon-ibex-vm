#!/bin/bash

set -e

# Displays the given input including "=> " on the console.
log () {
	echo "=> $1"
}

log "Start provisioning."

# Updates
sudo apt-get update
#sudo apt-get upgrade -y

# Java/JDK17
sudo apt-get install -y openjdk-17-jdk
java --version

log "Finished provisioning."
