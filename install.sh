#!/bin/sh
apt-get update && \
apt-get install -y \
unzip

wget https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip && \
    unzip terraform*.zip && \
    mv terraform /usr/local/bin
    
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb
add-apt-repository universe && \
    apt-get update && \
    apt-get install -y \
      dotnet-sdk-6.0 \
      dotnet-sdk-8.0 \
      powershell && \
    rm -rf /var/lib/apt/lists/* && \
    rm packages-microsoft-prod.deb
