#!/bin/sh

apt-get update && \
apt-get install -y \
unzip

# Function to find the latest Terraform version
get_latest_version() {
    curl -sL https://api.github.com/repos/hashicorp/terraform/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/'
}

# Variables
LATEST_VERSION=$(get_latest_version)
INSTALL_DIR="/usr/local/bin"
TEMP_DIR="/tmp/terraform_install"
OS=$(uname | tr '[:upper:]' '[:lower:]') # e.g., linux or darwin (macOS)
ARCH=$(uname -m)

# Map architecture to Terraform naming conventions
if [[ "$ARCH" == "x86_64" ]]; then
    ARCH="amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Download the latest Terraform version
DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${LATEST_VERSION}/terraform_${LATEST_VERSION}_${OS}_${ARCH}.zip"

echo "Downloading Terraform $LATEST_VERSION from $DOWNLOAD_URL..."
mkdir -p $TEMP_DIR
curl -Lo "$TEMP_DIR/terraform.zip" $DOWNLOAD_URL

# Extract and install
echo "Installing Terraform to $INSTALL_DIR..."
unzip -o "$TEMP_DIR/terraform.zip" -d "$TEMP_DIR"
sudo mv "$TEMP_DIR/terraform" "$INSTALL_DIR/terraform"

# Clean up
rm -rf "$TEMP_DIR"

# Verify installation
echo "Terraform installed successfully. Version:"
terraform -v
