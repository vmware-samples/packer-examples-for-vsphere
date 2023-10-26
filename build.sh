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

menu_banner=Builder

menu_message="Select a HashiCorp Packer build for VMware vSphere."

if [ "$debug_mode" = true ]; then
  menu_message+=" \e[31m(Debug Mode)\e[0m"
fi

menu_option_1() {
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

menu_option_2() {
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

menu_option_3() {
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
  echo "      Microsoft Windows:"
  echo ""
  echo "    	 1  -  Windows Server 2022 - All"
  echo "    	 2  -  Windows Server 2022 - Standard Only"
  echo "    	 3  -  Windows Server 2022 - Datacenter Only"
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
    i|I ) clear ; info ; press_enter ;;
    q|Q ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
