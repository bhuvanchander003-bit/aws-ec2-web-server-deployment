#!/bin/bash

# ==========================================

# AWS EC2 Web Server Setup Script

# ==========================================

echo "=========================================="
echo "Starting AWS EC2 Web Server Setup"
echo "=========================================="

# Update Linux packages

echo "[1/5] Updating system packages..."
sudo dnf update -y

# Install Apache

echo "[2/5] Installing Apache HTTP Server..."
sudo dnf install httpd -y

# Start Apache

echo "[3/5] Starting Apache Web Server..."
sudo systemctl start httpd

# Enable Apache at system startup

echo "[4/5] Enabling Apache at boot..."
sudo systemctl enable httpd

# Copy website files

echo "[5/5] Deploying website..."

sudo cp ../website/index.html /var/www/html/index.html
sudo cp ../website/style.css /var/www/html/style.css

# Set permissions

sudo chmod 644 /var/www/html/index.html
sudo chmod 644 /var/www/html/style.css

echo "=========================================="
echo "Apache Web Server Setup Completed!"
echo "=========================================="

echo ""
echo "Apache Status:"
sudo systemctl status httpd --no-pager

echo ""
echo "Website Location:"
echo "/var/www/html/"

echo ""
echo "Open your EC2 Public IP in a browser:"
echo "http://YOUR-EC2-PUBLIC-IP"

echo ""
echo "=========================================="
echo "Deployment Successful!"
echo "=========================================="
