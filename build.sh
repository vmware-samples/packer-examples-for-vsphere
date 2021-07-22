#!/bin/bash

BASEDIR=$(pwd)

menu_option_1() {
  cd builds/linux/photon-server-4/
  echo -e "\nCONFIRM: Build a VMware Photon OS 4 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a VMware Photon OS 4 Server Template for VMware vSphere ###
  echo "Building a VMware Photon OS 4 Server Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_2() {
  cd builds/linux/photon-server-3/
  echo -e "\nCONFIRM: Build a VMware Photon OS 3 Server  Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a VMware Photon OS 3 Server Template for VMware vSphere ###
  echo "Building a VMware Photon OS 3 Server Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_3() {
  cd builds/linux/ubuntu-server-20-04-lts/
  echo -e "\nCONFIRM: Build a Ubuntu Server 20.04 LTS Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a Ubuntu Server 20.04 LTS Template for VMware vSphere ###
  echo "Building a Ubuntu Server 20.04 LTS Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_4() {
  cd builds/linux/ubuntu-server-18-04-lts/
  echo -e "\nCONFIRM: Build a Ubuntu Server 18.04 LTS Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a Ubuntu Server 20.04 LTS Template for VMware vSphere ###
  echo "Building a Ubuntu Server 18.04 LTS Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_5() {
  cd builds/linux/redhat-server-8/
  echo -e "\nCONFIRM: Build a Red Hat Enerprise Linux 8 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build an Red Hat Enerprise Linux 8 Server Template for VMware vSphere ###
  echo "Building a Red Hat Enerprise Linux 8 Server Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" \
      -var-file="../../../redhat.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_6() {
  cd builds/linux/redhat-server-7/
  echo -e "\nCONFIRM: Build a Red Hat Enerprise Linux 7 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build an Red Hat Enerprise Linux 7 Server Template for VMware vSphere ###
  echo "Building a Red Hat Enerprise Linux 7 Server Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" \
      -var-file="../../../redhat.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_7() {
  cd builds/linux/almalinux-server-8/
  echo -e "\nCONFIRM: Build an AlmaLinux 8 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build an AlmaLinux 8 Server Template for VMware vSphere ###
  echo "Building an AlmaLinux 8 Server Template for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_8() {
  cd builds/linux/rocky-server-8/
  echo -e "\nCONFIRM: Build a Rocky Linux 8 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a Rocky Linux 8 Server Template for VMware vSphere ###
  echo "Building a Rocky Linux 8 Server Template for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_9() {
  cd builds/linux/centos-stream-8/
  echo -e "\nCONFIRM: Build a CentOS Stream 8 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a CentOS Stream 8 Server Template for VMware vSphere ###
  echo "Building a CentOS Stream 8 Server Template for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_10() {
  cd builds/linux/centos-server-8/
  echo -e "\nCONFIRM: Build a CentOS Linux 8 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a CentOS Linux 8 Server Template for VMware vSphere ###
  echo "Building a CentOS Linux 8 Server Template for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_11() {
  cd builds/linux/centos-server-7/
  echo -e "\nCONFIRM: Build a CentOS Linux 7 Server Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a CentOS Linux 7 Template for VMware vSphere ###
  echo "Building a CentOS Linux 7 Server Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_12() {
  cd builds/windows/windows-server-2019/
  echo -e "\nCONFIRM: Build all Microsoft Windows Server 2019 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Templates for VMware vSphere ###
  echo "Building all Microsoft Windows Server 2019 Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_13() {
  cd builds/windows/windows-server-2019/
  echo -e "\nCONFIRM: Build a Microsoft Windows Server 2019 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere ###
  echo "Building a Microsoft Windows Server 2019 Standard Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-standard-dexp,vsphere-iso.windows-server-standard-core \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_14() {
  cd builds/windows/windows-server-2019/
  echo -e "\nCONFIRM: Build a Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere ###
  echo "Building a Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-dexp,vsphere-iso.windows-server-datacenter-core \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_15() {
  cd builds/windows/windows-server-2016/
  echo -e "\nCONFIRM: Build all Microsoft Windows Server 2016 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Templates for VMware vSphere ###
  echo "Building all Microsoft Windows Server 2016 Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_16() {
  cd builds/windows/windows-server-2016/
  echo -e "\nCONFIRM: Build a Microsoft Windows Server Standard 2016 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Standard Templates for VMware vSphere ###
  echo "Building a Microsoft Windows Server 2016 Standard Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-standard-dexp,vsphere-iso.windows-server-standard-core \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_17() {
  cd builds/windows/windows-server-2016/
  echo -e "\nCONFIRM: Build a Microsoft Windows Server 2016 Datacenter Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Datacenter Templates for VMware vSphere ###
  echo "Building a Microsoft Windows Server 2016 Datacenter Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-dexp,vsphere-iso.windows-server-datacenter-core \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

press_enter() {
  cd "$BASEDIR"
  echo -n "Press Enter to continue."
  read
  clear
}

plugins() {
  cd builds/windows/windows-server-2019/
  echo -e "\nCONFIRM: Initilize the Windows Update Plug-in."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Initilize the Windows Update Plug-in. ###
  echo "Initilizing the Windows Update Plug-in ..."
  rm -f output-vmware-iso/*.ova
  packer init windows-server-2019.pkr.hcl
      
  ### All done. ###
  echo "Done."
}

info() {
  echo "GitHub Repository: github.com/rainpole/packer-vsphere/"
  echo "Maintainer: code@rainpole.io"
  echo "License: Apache License Version 2.0,"
  echo ""
  echo "Microsoft Windows Server builds include both Core and Desktop Experience."
  echo ""
  echo "UEFI based are not enabled by default for Microsoft Windows Server 2019/2016 and Red Hat Enterprise Linux 8."
  echo ""
  echo "For more information, visit the repositiory or review the README."
  read
}

incorrect_selection() {
  echo "Do or do not. There is no try."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo "    ____             __                ____        _ __    __     "
  echo "   / __ \____ ______/ /_____  _____   / __ )__  __(_) /___/ /____ "
  echo "  / /_/ / __  / ___/ //_/ _ \/ ___/  / __  / / / / / / __  / ___/ "
  echo " / ____/ /_/ / /__/ ,< /  __/ /     / /_/ / /_/ / / / /_/ (__  )  "
  echo "/_/    \__,_/\___/_/|_|\___/_/     /_____/\__,_/_/_/\__,_/____/   "
  echo ""                                                                
  echo -n "  Select a HashiCorp Packer build for VMware vSphere:"
  echo ""
  echo ""
  echo "      Linux Distribution:"
  echo ""
  echo "    	 1  -  VMware Photon OS 4 Server"
  echo "    	 2  -  VMware Photon OS 3 Server"
  echo "    	 3  -  Ubuntu Server 20.04 LTS"
  echo "    	 4  -  Ubuntu Server 18.04 LTS"
  echo "    	 5  -  Red Hat Enterprise Linux 8 Server"
  echo "    	 6  -  Red Hat Enterprise Linux 7 Server"
  echo "    	 7  -  AlmaLinux 8 Server"
  echo "    	 8  -  Rocky Linux 8 Server"
  echo "    	 9  -  CentOS Stream 8 Server"
  echo "    	10  -  CentOS Linux 8 Server"
  echo "    	11  -  CentOS Linux 7 Server"
  echo ""
  echo ""
  echo "      Microsoft Windows:"
  echo ""
  echo "    	12  -  Windows Server 2019 - All"
  echo "    	13  -  Windows Server 2019 - Standard Only"
  echo "    	14  -  Windows Server 2019 - Datacenter Only"
  echo "    	15  -  Windows Server 2016 - All" 
  echo "    	16  -  Windows Server 2016 - Standard Only"
  echo "    	17  -  Windows Server 2016 - Datacenter Only"
  echo ""
  echo ""
  echo "      Other:"
  echo ""
  echo "        P   -  Initialize Plugins"
  echo "        I   -  Information"
  echo "        Q   -  Quit"
  echo ""
  read selection
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
    P ) clear ; plugins ; press_enter ;;
    I ) clear ; info ; press_enter ;;
    Q ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done