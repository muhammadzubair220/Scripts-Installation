#!/bin/bash
# For Ubuntu 22.04

# Update package list and install Java if not already installed
sudo apt update -y

# Check if OpenJDK 11 is already installed
if ! java -version 2>&1 | grep -q "openjdk 11"; then
  echo "Installing OpenJDK 11..."
  sudo apt install openjdk-11-jre -y
else
  echo "OpenJDK 11 is already installed."
fi

java --version

# Installing Jenkins

# Install curl if it's not installed
if ! command -v curl &> /dev/null; then
  echo "curl not found. Installing curl..."
  sudo apt install curl -y
fi

# Add Jenkins repository key and source
echo "Adding Jenkins repository..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update apt package list and install Jenkins
sudo apt-get update -y
echo "Installing Jenkins..."
sudo apt-get install jenkins -y

# Start Jenkins service if not already running
echo "Starting Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check Jenkins status
sudo systemctl status jenkins --no-pager

echo "Jenkins installation completed."
