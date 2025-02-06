#!/bin/bash

# Install required dependencies if not already installed
for pkg in wget apt-transport-https gnupg lsb-release; do
  if ! command -v $pkg &> /dev/null; then
    echo "$pkg not found. Installing..."
    sudo apt-get install -y $pkg
  fi
done

# Add the Trivy GPG key and repository
echo "Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo tee /usr/share/keyrings/trivy.asc > /dev/null

echo "Adding Trivy repository..."
echo "deb [signed-by=/usr/share/keyrings/trivy.asc] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null

# Update apt package list
echo "Updating package list..."
sudo apt-get update -y

# Install Trivy
echo "Installing Trivy..."
sudo apt-get install -y trivy

# Verify installation
echo "Verifying Trivy installation..."
trivy --version

# Optional: Clean up the apt cache
echo "Cleaning up apt cache..."
sudo apt-get clean

echo "Trivy installation complete."
