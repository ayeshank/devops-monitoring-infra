#!/bin/bash

# Update package index
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx service to start on boot
sudo systemctl enable nginx

# Install Docker
sudo apt update
sudo apt upgrade -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Install Node.js version 20.x
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs