#!/bin/bash

# Install wget and gpg if not already installed
for pkg in wget gnupg; do
  if ! command -v $pkg &> /dev/null; then
    echo "$pkg not found. Installing..."
    sudo apt install -y $pkg
  fi
done

# Add the HashiCorp GPG key to the keyring
wget -qO- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update apt package list and install Terraform
sudo apt update -y
sudo apt install terraform -y

# Verify Terraform installation
terraform version
