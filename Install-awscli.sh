#!/bin/bash

# Download AWS CLI v2 installer
echo "Downloading AWS CLI v2 installer..."
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"

# Install unzip if not installed
if ! command -v unzip &> /dev/null; then
  echo "unzip not found. Installing unzip..."
  sudo apt install unzip -y
fi

# Unzip the downloaded file
echo "Unzipping the AWS CLI installer..."
unzip -q awscliv2.zip

# Install AWS CLI
echo "Installing AWS CLI..."
sudo ./aws/install

# Verify the installation
echo "Verifying AWS CLI installation..."
aws --version

# Clean up the installer files
echo "Cleaning up installer files..."
rm -rf awscliv2.zip aws/

echo "AWS CLI installation complete."
