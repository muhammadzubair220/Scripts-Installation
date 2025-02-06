#!/bin/bash

# Update package list
sudo apt update

# Check if docker is already installed, if not, install it
if ! dpkg -l | grep -q docker.io; then
  sudo apt install docker.io -y
else
  echo "Docker is already installed."
fi

# Add user to docker group (jenkins and ubuntu)
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

# Restart docker service to apply group changes
sudo systemctl restart docker

# Fix docker socket permissions more securely
sudo chmod 660 /var/run/docker.sock
sudo chown root:docker /var/run/docker.sock

echo "Docker setup complete."
