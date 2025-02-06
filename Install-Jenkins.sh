#!/bin/bash
# For Ubuntu 22.04 or newer

# Update package list
sudo apt update -y

# Install OpenJDK 17 (or any newer version you need)
if ! java -version 2>&1 | grep -q "openjdk 17"; then
  echo "Installing OpenJDK 17..."
  sudo apt install openjdk-17-jre -y
else
  echo "OpenJDK 17 is already installed."
fi

# Set OpenJDK 17 as the default Java version
echo "Setting OpenJDK 17 as the default Java..."
sudo update-alternatives --config java
sudo update-alternatives --config javac

# Verify Java installation
java -version

# Installing Jenkins
echo "Adding Jenkins repository..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update -y
sudo apt-get install jenkins -y

# Ensure Jenkins service starts automatically
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check Jenkins status
sudo systemctl status jenkins --no-pager

echo "Jenkins installation completed, using OpenJDK 17."
