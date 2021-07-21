# Maintainer: code@rainpole.io
# Packer variables for Red Hat Enterprise Linux 7 Server.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings 

http_directory = "../../../configs/linux/redhat-server"
http_file      = "ks-v7.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "redhat"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "7"
vm_guest_os_type            = "rhel7_64Guest" 
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

iso_file     = "iso-linux-redhat-server-7.iso"
iso_checksum = "825cebb770527c617e4b136543febfa407ecac7583126a0c468c0478c3a6f88f2dcf2156643498d344dad85f6a9b43c3fb1234954abd6ee9b7aa22b9f2d98b7"

# Scripts

shell_scripts = ["../../../scripts/linux/redhat-server-cleanup.sh"]