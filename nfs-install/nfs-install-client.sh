#!/bin/bash

sudo yum update -y

# Install NFS utilities and ACL tools
sudo dnf install nfs-utils nfs4-acl-tools -y

# Create the NFS mount directory
sudo mkdir -p /mnt/nfs_client

# Install vim for editing files (if not already installed)
sudo yum install vim -y

# Prompt the user for the NFS server IP address
read -p "Enter the NFS server IP address: " SERVER_IP

# Add the NFS mount entry to /etc/fstab
echo "${SERVER_IP}:/mnt/nfs_backup /mnt/nfs_client nfs defaults 0 0" | sudo tee -a /etc/fstab

# Reload the systemd daemon to apply changes
sudo systemctl daemon-reload

# Mount all filesystems mentioned in /etc/fstab
sudo mount -a

# Display disk space usage to confirm the NFS mount
df -h

echo "NFS client setup is complete."
