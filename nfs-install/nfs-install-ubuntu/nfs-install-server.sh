#!/bin/bash

# Update the system
sudo apt update -y

# Install NFS utilities
sudo apt install nfs-kernel-server -y

# Create the NFS export directory
sudo mkdir -p /mnt/nfs_server

# Set the ownership for the NFS export directory
sudo chown nobody:nogroup /mnt/nfs_server

# Prompt the user for the client IP address
read -p "Enter the client IP address to grant NFS access: " CLIENT_IP

# Add the NFS export entry to /etc/exports
echo "/mnt/nfs_server ${CLIENT_IP}(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports

# Export the NFS directory
sudo exportfs -a

# Start and enable the NFS server service
sudo systemctl start nfs-kernel-server
sudo systemctl enable nfs-kernel-server

# Allow NFS through the firewall
sudo ufw allow from ${CLIENT_IP} to any port nfs

# Enable the firewall (requires user confirmation)
echo "Enabling UFW firewall. You may need to confirm this action by typing 'y'."
sudo ufw enable

# Check the firewall status
sudo ufw status

echo "NFS server setup is complete."
