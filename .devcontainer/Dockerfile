# Copyright 2023-2024 Broadcom. All Rights Reserved.
# SPDX-License-Identifier: BSD-2

# Use the base Ubuntu devcontainer image.
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install additional packages.
RUN apt-get update && \
    apt-get install -y apt-transport-https curl git jq software-properties-common unzip wget whois xorriso ca-certificates

RUN update-ca-certificates

# Install Packer using the latest release.
RUN PACKER_VERSION=$(curl -s https://api.github.com/repos/hashicorp/packer/releases/latest | jq -r .tag_name | sed 's/^v//') && \
    echo "Latest Packer Version: ${PACKER_VERSION}." && \
    PACKER_URL="https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" && \
    echo "Downloading Packer from ${PACKER_URL}..." && \
    wget --no-check-certificate -q -O packer_${PACKER_VERSION}_linux_amd64.zip ${PACKER_URL} || { echo "Error: Failed to download."; wget --no-check-certificate ${PACKER_URL}; exit 1; } && \
    echo "Installing Packer ${PACKER_VERSION}..." && \
    unzip -o packer_${PACKER_VERSION}_linux_amd64.zip || { echo "Failed to unzip the download."; exit 1; } && \
    mv packer /usr/local/bin/ || { echo "Error: Failed to move binary."; exit 1; } && \
    rm packer_${PACKER_VERSION}_linux_amd64.zip || { echo "Error: Failed to remove download."; exit 1; }

# Install Terraform using the latest release.
RUN TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r .tag_name | sed 's/^v//') && \
    echo "Latest Terraform Version: ${TERRAFORM_VERSION}." && \
    TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    echo "Downloading Terraform from ${TERRAFORM_URL}..." && \
    wget --no-check-certificate -q -O terraform_${TERRAFORM_VERSION}_linux_amd64.zip ${TERRAFORM_URL} || { echo "Error: Failed to download."; wget --no-check-certificate ${TERRAFORM_URL}; exit 1; } && \
    echo "Installing Terraform ${TERRAFORM_VERSION}..." && \
    unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip || { echo "Error: Failed to unzip the  download."; exit 1; } && \
    mv terraform /usr/local/bin/ || { echo "Error: Failed to the move binary."; exit 1; } && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip || { echo "Error: Failed to remove download."; exit 1; }

# Install Gomplate using the latest release.
RUN GOMPLATE_VERSION=$(wget --no-check-certificate -q -O - https://api.github.com/repos/hairyhenderson/gomplate/releases/latest | jq -r .tag_name | sed 's/^v//') && \
    echo "Latest Gomplate Version: ${GOMPLATE_VERSION}." && \
    GOMPLATE_URL="https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64" && \
    echo "Downloading Gomplate ${GOMPLATE_VERSION}..." && \
    wget --no-check-certificate -q -O gomplate_linux-amd64 ${GOMPLATE_URL} || { echo "Error: Failed to download."; exit 1; } && \
    echo "Installing Gomplate ${GOMPLATE_VERSION}..." && \
    chmod +x gomplate_linux-amd64 && \
    mv gomplate_linux-amd64 /usr/local/bin/gomplate || { echo "Error: Failed to move binary."; exit 1; }

# Install PowerShell using the latest release.
RUN PWSH_VERSION=$(wget --no-check-certificate -q -O - https://api.github.com/repos/PowerShell/PowerShell/releases/latest | jq -r .tag_name | sed 's/^v//') && \
    echo "Latest PowerShell Version: ${PWSH_VERSION}." && \
    PWSH_DEB_URL=$(wget --no-check-certificate -q -O - https://api.github.com/repos/PowerShell/PowerShell/releases/latest | jq -r '.assets[] | select(.name | endswith("amd64.deb")).browser_download_url' | head -n 1) && \
    echo "Downloading PowerShell ${PWSH_VERSION}..." && \
    wget --no-check-certificate -q $PWSH_DEB_URL || { echo "Error: Failed to download."; exit 1; } && \
    echo "Installing PowerShell ${PWSH_VERSION}..." && \
    dpkg -i $(basename $PWSH_DEB_URL) || { echo "Error: Failed to install PowerShell."; exit 1; } && \
    rm $(basename $PWSH_DEB_URL) || { echo "Error: Failed to remove download."; exit 1; }

# Install Python3 and Ansible.
RUN add-apt-repository --yes --update ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y python3 python3-pip ansible

# Cleanup.
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set PATH
ENV PATH="$HOME/.local/bin:$PATH"
