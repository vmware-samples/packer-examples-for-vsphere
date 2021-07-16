# Maintainer: code@rainpole.io
# Packer template for Rocky Linux Server 8.

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

http_directory = "../../../configs/linux/rocky-server"
http_file      = "ks.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "rocky"
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

iso_file     = "iso-linux-rocky-server-8.iso"
iso_checksum = "dbfacdbbfd50059a0dda5c19071bc2f55496f3651279eafa6f50d2ea2d941fdd8b43b8710e2187cdbfe630fa7efb5d3b047ee0cdbc2f8d09bd5f68a7014e0d0c"

# Scripts

shell_scripts = ["../../../scripts/linux/rocky-server-cleanup.sh"]