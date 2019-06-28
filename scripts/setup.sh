#!/bin/bash

# Install system dependencies
sudo apt update \
    && sudo apt install -y wget tmux

# Make Harmony home directory
mkdir -p ~/.hmy/keystore

# Download Harmony Scripts
wget https://harmony.one/wallet.sh && chmod u+x wallet.sh
wget https://harmony.one/node.sh && chmod u+x node.sh
