#!/bin/bash

# Update the system
sudo yum update -y

# Install yum-utils
sudo yum install -y yum-utils

# Add Docker's official GPG key and set up the stable repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

# Install Docker and Docker Compose
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service
sudo systemctl start docker

# Install Docker Compose
DOCKER_COMPOSE_VERSION="v2.20.2"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make Docker Compose executable
sudo chmod +x /usr/local/bin/docker-compose

# Create a symbolic link to Docker Compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Final update to ensure all packages are up to date
sudo yum update -y

# Verify installation
docker --version
docker-compose --version
