#!/bin/bash

# Update the system
sudo yum update -y

# Install NFS utilities
sudo dnf install nfs-utils -y

# Start and enable the NFS server service
sudo systemctl start nfs-server.service
sudo systemctl enable nfs-server.service

# Check the status of the NFS server service
sudo systemctl status nfs-server.service

# Create the NFS export directory
sudo mkdir -p /mnt/nfs_backup

# Set the ownership and permissions for the NFS export directory
sudo chown -R nobody: /mnt/nfs_backup
sudo chmod -R 777 /mnt/nfs_backup

# Restart the NFS utilities service
sudo systemctl restart nfs-utils.service

# Install vim for editing files (if not already installed)
sudo yum install vim -y

# Prompt the user for the client IP address
read -p "Enter the client IP address to grant NFS access: " CLIENT_IP

# Add the NFS export entry to /etc/exports
echo "/mnt/nfs_backup ${CLIENT_IP}(rw,sync,no_all_squash,root_squash)" | sudo tee -a /etc/exports

# Reload the NFS exports
sudo exportfs -arv

# Show the current NFS exports
sudo exportfs -s

# Install and configure firewalld
sudo yum install firewalld -y
sudo systemctl start firewalld
sudo systemctl enable firewalld

# Check the firewall status
sudo firewall-cmd --state

# Add necessary firewall rules for NFS
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --permanent --add-service=rpc-bind
sudo firewall-cmd --permanent --add-service=mountd
sudo firewall-cmd --reload

echo "============================="
echo "NFS server setup is complete."
echo "============================="
