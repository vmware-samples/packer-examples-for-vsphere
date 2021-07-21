# Maintainer: code@rainpole.io
# Packer template for CentOS Server 8.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

http_directory = "../../../configs/linux/centos-server"
http_file      = "ks-v8.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "centos"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "8" 
vm_guest_os_type            = "centos8_64Guest" 
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

iso_file     = "iso-linux-centos-server-8.iso"
iso_checksum = "ff1164dc26ba47616f2b26a18158398a7d7930487770a8bb9e573d5758e01255ebc11db68c22976abe684a857083a0fae445e9d41d11a24a2073cdb1b500ae9a"

# Scripts

shell_scripts = ["../../../scripts/linux/centos-server-cleanup.sh"]