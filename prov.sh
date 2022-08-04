#!/bin/bash

set -e

# Displays the given input including "=> " on the console.
log () {
	echo "=> $1"
}

log "Start provisioning."

# Updates
sudo apt update && sudo apt upgrade -y

# Java/JDK17
sudo apt-get install openjdk-17-jdk
java --version

log "Finished provisioning."
