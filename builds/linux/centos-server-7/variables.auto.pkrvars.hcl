# Maintainer: code@rainpole.io
# Packer variables for CentOS Linux 7.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

http_directory = "../../../configs/linux/centos-server"
http_file      = "ks-v7.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "centos"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "7"
vm_guest_os_type            = "centos7_64Guest" 
vm_version                  = 18
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"

# ISO Objects

iso_file     = "iso-linux-centos-server-7.iso"
iso_checksum = "7f8a5ae81c002999ac5abb05d1fe8b68dc981f0ad4d2824e4d14bf7b2f31c6aafc352d5f727329b6738efd67935ae981216979644bbff297c53f8e81d96de8e3"

# Scripts

shell_scripts = ["../../../scripts/linux/centos-server-cleanup.sh"]