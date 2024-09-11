#!/bin/sh

apt-get update && \
apt-get install -y \
unzip

# Get the latest release URL from GitHub API
latest_release_url=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r '.assets[] | select(.browser_download_url | contains("linux_amd64.zip")) | .browser_download_url')

# Download Terraform
wget -O terraform.zip "$latest_release_url"

# Extract Terraform
sudo unzip terraform.zip -d /usr/local/bin/

# Verify installation
terraform --version
