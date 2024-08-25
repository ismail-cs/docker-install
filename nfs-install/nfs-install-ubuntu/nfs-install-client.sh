#!/bin/bash

# Update the system
sudo apt update -y

# Install NFS utilities
sudo apt install nfs-common -y

# Create the NFS mount directory
sudo mkdir -p /mnt/nfs_client

# Prompt the user for the NFS server IP address
read -p "Enter the NFS server IP address: " SERVER_IP

# Add the NFS mount entry to /etc/fstab
echo "${SERVER_IP}:/mnt/nfs_server /mnt/nfs_client nfs defaults 0 0" | sudo tee -a /etc/fstab

# Reload the systemd daemon to apply changes
sudo systemctl daemon-reload

# Mount all filesystems mentioned in /etc/fstab
sudo mount -a

# Display disk space usage to confirm the NFS mount
df -h

echo "NFS client setup is complete."
