#!/usr/bin/env bash


# Install docker and setup
sudo apt update
sudo apt install docker.io
sudo chmod 666 /var/run/docker.sock

# build crank-agent
cd docker/azure_controller/
bash build.sh