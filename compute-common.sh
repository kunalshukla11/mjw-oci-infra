#!/bin/bash

echo "Running common script for compute"
# Remove apparmor if present
apt-get remove --quiet --assume-yes --purge apparmor

# Update and upgrade system packages
apt-get update -y && apt-get upgrade -y

# Install Git
apt-get install -y git

# Install Docker
apt-get install -y docker.io

# Install acl to manage access for postgres directory
apt-get install acl

# Add docker group if not already present
groupadd docker || true

# Add ubuntu user to docker group to run docker without sudo
usermod -aG docker ubuntu

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install vim
sudo apt install vim -y

# Install firewalld to manage firewall and open ports
sudo apt -y install firewalld

# Check Docker Compose version
docker-compose version

echo "Done running common script for compute"
