#!/usr/bin/env bash
# Copyright 2023 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

set -e

follow_link() {
  FILE="$1"
  while [ -h "$FILE" ]; do
    # On Mac OS, readlink -f doesn't work.
    FILE="$(readlink "$FILE")"
  done
  echo "$FILE"
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: script.sh [OPTIONS] [CONFIG_PATH]"
  echo ""
  echo "Options:"
  echo "  -h, --help    Show this help message and exit."
  echo "  -d, --debug   Run builds in debug mode."
  echo ""
  echo "Arguments:"
  echo "  CONFIG_PATH   Path to the configuration directory."
  echo ""
  echo "Examples:"
  echo "  ./build.sh"
  echo "  ./build.sh --help"
  echo "  ./build.sh --debug"
  echo "  ./build.sh config"
  echo "  ./build.sh us-west-1"
  echo "  ./build.sh --debug config"
  echo "  ./build.sh --debug us-west-1"
  exit 0
fi

if [ "$1" == "--debug" ] || [ "$1" == "-d" ]; then
  debug_mode=true
  debug_option="-debug"
  shift
else
  debug_mode=false
  debug_option=""
fi

SCRIPT_PATH=$(realpath "$(dirname "$(follow_link "$0")")")

if [ -n "$1" ]; then
  CONFIG_PATH=$(realpath "$1")
else
  CONFIG_PATH=$(realpath "${SCRIPT_PATH}/config")
fi

menu_banner=$(cat << "EOF"
    ____             __                ____        _ __    __     
   / __ \____ ______/ /_____  _____   / __ )__  __(_) /___/ /____ 
  / /_/ / __  / ___/ //_/ _ \/ ___/  / __  / / / / / / __  / ___/ 
 / ____/ /_/ / /__/ ,< /  __/ /     / /_/ / /_/ / / / /_/ (__  )  
/_/    \__,_/\___/_/|_|\___/_/     /_____/\__,_/_/_/\__,_/____/   
EOF
)

menu_message="Select a HashiCorp Packer build for VMware vSphere."

if [ "$debug_mode" = true ]; then
  menu_message+=" \e[31m(Debug Mode)\e[0m"
fi

menu_option_1() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/photon/5/
  echo -e "\nCONFIRM: Build a VMware Photon OS 5 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a VMware Photon OS 5 Template for VMware vSphere. ###
  echo "Building a VMware Photon OS 5 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_2() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/photon/4/
  echo -e "\nCONFIRM: Build a VMware Photon OS 4 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a VMware Photon OS 4 Template for VMware vSphere. ###
  echo "Building a VMware Photon OS 4 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_3() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/debian/12/
  echo -e "\nCONFIRM: Build a Debian 12 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Debian 12 Template for VMware vSphere. ###
  echo "Building a Debian 12 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_4() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/debian/11/
  echo -e "\nCONFIRM: Build a Debian 11 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Debian 11 Template for VMware vSphere. ###
  echo "Building a Debian 11 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_5() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/ubuntu/22-04-lts/
  echo -e "\nCONFIRM: Build a Ubuntu Server 22.04 LTS (cloud-init) Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Ubuntu Server 22.04 LTS (cloud-init) Template for VMware vSphere. ###
  echo "Building a Ubuntu Server 22.04 LTS (cloud-init) Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_6() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/ubuntu/20-04-lts/
  echo -e "\nCONFIRM: Build a Ubuntu Server 20.04 LTS (cloud-init) Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Ubuntu Server 20.04 LTS (cloud-init) Template for VMware vSphere. ###
  echo "Building a Ubuntu Server 20.04 LTS (cloud-init) Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_7() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/rhel/9/
  echo -e "\nCONFIRM: Build a Red Hat Enterprise Linux 9 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Red Hat Enterprise Linux 9 Template for VMware vSphere. ###
  echo "Building a Red Hat Enterprise Linux 9 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/rhsm.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_8() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/rhel/8/
  echo -e "\nCONFIRM: Build a Red Hat Enterprise Linux 8 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Red Hat Enterprise Linux 8 Template for VMware vSphere. ###
  echo "Building a Red Hat Enterprise Linux 8 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/rhsm.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_9() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/rhel/7/
  echo -e "\nCONFIRM: Build a Red Hat Enterprise Linux 7 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Red Hat Enterprise Linux 7 Template for VMware vSphere. ###
  echo "Building a Red Hat Enterprise Linux 7 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/rhsm.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_10() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/almalinux/9/
  echo -e "\nCONFIRM: Build a AlmaLinux OS 9 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a AlmaLinux OS 9 Template for VMware vSphere. ###
  echo "Building a AlmaLinux OS 9 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_11() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/almalinux/8/
  echo -e "\nCONFIRM: Build a AlmaLinux OS 8 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a AlmaLinux OS 8 Template for VMware vSphere. ###
  echo "Building a AlmaLinux OS 8 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_12() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/rocky/9/
  echo -e "\nCONFIRM: Build a Rocky Linux 9 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Rocky Linux 9 Template for VMware vSphere. ###
  echo "Building a Rocky Linux 9 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_13() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/rocky/8/
  echo -e "\nCONFIRM: Build a Rocky Linux 8 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Rocky Linux 8 Template for VMware vSphere. ###
  echo "Building a Rocky Linux 8 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_14() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/oracle/9/
  echo -e "\nCONFIRM: Build a Oracle Linux 9 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Oracle Linux 9 Template for VMware vSphere. ###
  echo "Building a Oracle Linux 9 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_15() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/oracle/8/
  echo -e "\nCONFIRM: Build a Oracle Linux 8 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Oracle Linux 8 Template for VMware vSphere. ###
  echo "Building a Oracle Linux 8 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_16() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/centos/9-stream/
  echo -e "\nCONFIRM: Build a CentOS Stream 9 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a CentOS Stream 9 Template for VMware vSphere. ###
  echo "Building a CentOS Stream 9 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_17() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/centos/8-stream/
  echo -e "\nCONFIRM: Build a CentOS Stream 8 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a CentOS Stream 8 Template for VMware vSphere. ###
  echo "Building a CentOS Stream 8 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_18() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/centos/7/
  echo -e "\nCONFIRM: Build a CentOS Linux 7 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a CentOS Linux 7 Template for VMware vSphere. ###
  echo "Building a CentOS Linux 7 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_19() {
  INPUT_PATH="$SCRIPT_PATH"/builds/linux/sles/15/
  echo -e "\nCONFIRM: Build a SUSE Linux Enterprise Server 15 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a SUSE Linux Enterprise Server 15 Template for VMware vSphere. ###
  echo "Building a SUSE Linux Enterprise Server 15 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/scc.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}


menu_option_20() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/server/2022/
  echo -e "\nCONFIRM: Build all Windows Server 2022 Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build all Windows Server 2022 Templates for VMware vSphere. ###
  echo "Building all Windows Server 2022 Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_21() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/server/2022/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2022 Standard Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build Microsoft Windows Server 2022 Standard Templates for VMware vSphere. ###
  echo "Building Microsoft Windows Server 2022 Standard Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-server-standard-dexp,vsphere-iso.windows-server-standard-core \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_22() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/server/2022/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2022 Datacenter Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build Microsoft Windows Server 2022 Datacenter Templates for VMware vSphere. ###
  echo "Building Microsoft Windows Server 2022 Datacenter Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-server-datacenter-dexp,vsphere-iso.windows-server-datacenter-core \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_23() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/server/2019/
  echo -e "\nCONFIRM: Build all Windows Server 2019 Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build all Windows Server 2019 Templates for VMware vSphere. ###
  echo "Building all Windows Server 2019 Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_24() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/server/2019/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere. ###
  echo "Building Microsoft Windows Server 2019 Standard Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-server-standard-dexp,vsphere-iso.windows-server-standard-core \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_25() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/server/2019/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere. ###
  echo "Building Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-server-datacenter-dexp,vsphere-iso.windows-server-datacenter-core \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_26() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/desktop/11/
  echo -e "\nCONFIRM: Build all Windows 11 Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build all Windows 11 Templates for VMware vSphere. ###
  echo "Building all Windows 11 Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_27() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/desktop/11/
  echo -e "\nCONFIRM: Build a Windows 11 - Enterprise Only Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Windows 11 - Enterprise Only Template for VMware vSphere. ###
  echo "Building a Windows 11 - Enterprise Only Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-desktop-ent \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_28() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/desktop/11/
  echo -e "\nCONFIRM: Build a Windows 11 - Professional Only Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Windows 11 - Professional Only Template for VMware vSphere. ###
  echo "Building a Windows 11 - Professional Only Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-desktop-pro \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_29() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/desktop/10/
  echo -e "\nCONFIRM: Build all Windows 10 Templates for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build all Windows 10 Templates for VMware vSphere. ###
  echo "Building all Windows 10 Templates for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_30() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/desktop/10/
  echo -e "\nCONFIRM: Build a Windows 10 - Enterprise Only Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Windows 10 - Enterprise Only Template for VMware vSphere. ###
  echo "Building a Windows 10 - Enterprise Only Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-desktop-ent \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_31() {
  INPUT_PATH="$SCRIPT_PATH"/builds/windows/desktop/10/
  echo -e "\nCONFIRM: Build a Windows 10 - Professional Only Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Windows 10 - Professional Only Template for VMware vSphere. ###
  echo "Building a Windows 10 - Professional Only Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  packer build -force -on-error=ask $debug_option \
      --only vsphere-iso.windows-desktop-pro \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

press_enter() {
  cd "$SCRIPT_PATH"
  echo -n "Press Enter to continue."
  read -r
  clear
}

info() {
  echo "Copyright 2023 VMware, Inc. All rights reserved."
  echo "License: BSD-2"
  echo ""
  echo "GitHub Repository: github.com/vmware-samples/packer-examples-for-vsphere/"
  read -r
}

incorrect_selection() {
  echo "Invalid selection, please try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo -e "$menu_banner"
  echo ""
  echo -e "$menu_message"
  echo ""
  echo "      Linux Distribution:"
  echo ""
  echo "    	 1  -  VMware Photon OS 5"
  echo "    	 2  -  VMware Photon OS 4"
  echo "    	 3  -  Debian 12"
  echo "    	 4  -  Debian 11"
  echo "    	 5  -  Ubuntu Server 22.04 LTS (cloud-init)"
  echo "    	 6  -  Ubuntu Server 20.04 LTS (cloud-init)"
  echo "    	 7  -  Red Hat Enterprise Linux 9"
  echo "    	 8  -  Red Hat Enterprise Linux 8"
  echo "    	 9  -  Red Hat Enterprise Linux 7"
  echo "    	10  -  AlmaLinux OS 9"
  echo "    	11  -  AlmaLinux OS 8"
  echo "    	12  -  Rocky Linux 9"
  echo "    	13  -  Rocky Linux 8"
  echo "    	14  -  Oracle Linux 9"
  echo "    	15  -  Oracle Linux 8"
  echo "    	16  -  CentOS Stream 9"
  echo "    	17  -  CentOS Stream 8"
  echo "    	18  -  CentOS Linux 7"
  echo "    	19  -  SUSE Linux Enterprise Server 15"
  echo ""
  echo "      Microsoft Windows:"
  echo ""
  echo "    	20  -  Windows Server 2022 - All"
  echo "    	21  -  Windows Server 2022 - Standard Only"
  echo "    	22  -  Windows Server 2022 - Datacenter Only"
  echo "    	23  -  Windows Server 2019 - All"
  echo "    	24  -  Windows Server 2019 - Standard Only"
  echo "    	25  -  Windows Server 2019 - Datacenter Only"
  echo "    	26  -  Windows 11 - All"
  echo "    	27  -  Windows 11 - Enterprise Only"
  echo "    	28  -  Windows 11 - Professional Only"
  echo "    	29  -  Windows 10 - All"
  echo "    	30  -  Windows 10 - Enterprise Only"
  echo "    	31  -  Windows 10 - Professional Only"
  echo ""
  echo "      Other:"
  echo ""
  echo "        I   -  Information"
  echo "        Q   -  Quit"
  echo ""
  read -r selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_1 ; press_enter ;;
    2 ) clear ; menu_option_2 ; press_enter ;;
    3 ) clear ; menu_option_3 ; press_enter ;;
    4 ) clear ; menu_option_4 ; press_enter ;;
    5 ) clear ; menu_option_5 ; press_enter ;;
    6 ) clear ; menu_option_6 ; press_enter ;;
    7 ) clear ; menu_option_7 ; press_enter ;;
    8 ) clear ; menu_option_8 ; press_enter ;;
    9 ) clear ; menu_option_9 ; press_enter ;;
    10 ) clear ; menu_option_10 ; press_enter ;;
    11 ) clear ; menu_option_11 ; press_enter ;;
    12 ) clear ; menu_option_12 ; press_enter ;;
    13 ) clear ; menu_option_13 ; press_enter ;;
    14 ) clear ; menu_option_14 ; press_enter ;;
    15 ) clear ; menu_option_15 ; press_enter ;;
    16 ) clear ; menu_option_16 ; press_enter ;;
    17 ) clear ; menu_option_17 ; press_enter ;;
    18 ) clear ; menu_option_18 ; press_enter ;;
    19 ) clear ; menu_option_19 ; press_enter ;;
    20 ) clear ; menu_option_20 ; press_enter ;;
    21 ) clear ; menu_option_21 ; press_enter ;;
    22 ) clear ; menu_option_22 ; press_enter ;;
    23 ) clear ; menu_option_23 ; press_enter ;;
    24 ) clear ; menu_option_24 ; press_enter ;;
    25 ) clear ; menu_option_25 ; press_enter ;;
    26 ) clear ; menu_option_26 ; press_enter ;;
    27 ) clear ; menu_option_27 ; press_enter ;;
    28 ) clear ; menu_option_28 ; press_enter ;;
    29 ) clear ; menu_option_29 ; press_enter ;;
    30 ) clear ; menu_option_30 ; press_enter ;;
    31 ) clear ; menu_option_31 ; press_enter ;;
    i|I ) clear ; info ; press_enter ;;
    q|Q ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
