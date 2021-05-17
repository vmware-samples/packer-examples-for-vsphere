#!/bin/bash

BASEDIR=$(pwd)

menu_option_1() {
  cd builds/linux/photon-server-4/
  echo -e "\nCONFIRM: Build a VMware Photon OS 4 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a VMware Photon OS 4 Template for VMware vSphere ###
  echo "Building a VMware Photon OS 4 Template for VMware vSphere ..."
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
  echo -e "\nCONFIRM: Build a VMware Photon OS 3 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a VMware Photon OS 3 Template for VMware vSphere ###
  echo "Building a VMware Photon OS 3 Template for VMware vSphere ..."
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

  ### Build a Ubuntu Sever 20.04 LTS Template for VMware vSphere ###
  echo "Building a Ubuntu Sever 20.04 LTS Template for VMware vSphere ..."
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
  echo -e "\nCONFIRM: Build a Red Hat Enerprise Linux Server 8 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build an Red Hat Enerprise Linux Server 8 Template for VMware vSphere ###
  echo "Building an Red Hat Enerprise Linux Server 8 Template for VMware vSphere ..."
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
  echo -e "\nCONFIRM: Build a Red Hat Enerprise Linux Server 7 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build an Red Hat Enerprise Linux Server 7 Template for VMware vSphere ###
  echo "Building an Red Hat Enerprise Linux Server 7 Template for VMware vSphere ..."
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
  cd builds/linux/centos-server-8/
  echo -e "\nCONFIRM: Build a CentOS Server 8 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build n CentOS 8 Template for VMware vSphere ###
  echo "Building a CentOS Server 8 Template for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_8() {
  cd builds/linux/centos-server-7/
  echo -e "\nCONFIRM: Build a CentOS Server 7 Template for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build a CentOS Server 7 Template for VMware vSphere ###
  echo "Building a CentOS Server 7 Template for VMware vSphere ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .

  ### All done. ###
  echo "Done."
}

menu_option_9() {
  cd builds/windows/windows-server-2019/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2019 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_10() {
  cd builds/windows/windows-server-2019/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2019 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Standard Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-standard-dexp,vsphere-iso.windows-server-standard-core \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_11() {
  cd builds/windows/windows-server-2019/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2019 Datacenter Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      --only vsphere-iso.windows-server-datacenter-dexp,vsphere-iso.windows-server-datacenter-core \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_12() {
  cd builds/windows/windows-server-2016/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2016 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2016 Templates for VMware vSphere  ..."
  rm -f output-vmware-iso/*.ova

  ### Apply the HashiCorp Packer Build ###
  echo "Applying the HashiCorp Packer Build ..."
  packer build -force \
      -var-file="../../../vsphere.pkrvars.hcl" .
      
  ### All done. ###
  echo "Done."
}

menu_option_13() {
  cd builds/windows/windows-server-2016/
  echo -e "\nCONFIRM: Build Microsoft Windows Server Standard 2016 Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Standard Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2016 Standard Templates for VMware vSphere  ..."
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
  cd builds/windows/windows-server-2016/
  echo -e "\nCONFIRM: Build Microsoft Windows Server 2016 Datacenter Templates for VMware vSphere."
  echo -e "\nContinue? (y/n)"
  read REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi

  ### Build Microsoft Windows Server 2016 Datacenter Templates for VMware vSphere ###
  echo "Building Microsoft Windows Server 2016 Datacenter Templates for VMware vSphere  ..."
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

info() {
  echo "GitHub Repository: github.com/rainpole/packer-vsphere/"
  echo "Maintainer: code@rainpole.io"
  echo "License: Apache License Version 2.0,"
  echo ""
  echo "Microsoft Windows Server builds include both Core and Desktop Experience."
  echo ""
  echo "UEFI based are not enabled by default for Microsoft Windows Server 2019/2016 and Red Hat Enterprise Linux 8 due to a known issue with cloning from the vSphere Content Library."
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
  echo "    	 1  -  VMware Photon OS 4"
  echo "    	 2  -  VMware Photon OS 3"
  echo "    	 3  -  Ubuntu Server 20.04 LTS"
  echo "    	 4  -  Ubuntu Server 18.04 LTS"
  echo "    	 5  -  Red Hat Enterprise Linux Server 8"
  echo "    	 6  -  Red Hat Enterprise Linux Server 7"
  echo "    	 7  -  CentOS Server 8"   
  echo "    	 8  -  CentOS Server 7" 
  echo ""
  echo ""
  echo "      Microsoft Windows:"
  echo ""
  echo "    	 9  -  Windows Server 2019 - All"
  echo "    	10  -  Windows Server 2019 - Standard Only"
  echo "    	11  -  Windows Server 2019 - Datacenter Only"
  echo "    	12  -  Windows Server 2016 - All" 
  echo "    	13  -  Windows Server 2016 - Standard Only"
  echo "    	14  -  Windows Server 2016 - Datacenter Only"
  echo ""
  echo ""
  echo "      Other:"
  echo ""
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
    I ) clear ; info ; press_enter ;;
    Q ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
