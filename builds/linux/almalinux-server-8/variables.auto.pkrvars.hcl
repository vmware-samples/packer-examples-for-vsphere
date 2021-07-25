# Maintainer: code@rainpole.io
# Packer variables for AlmaLinux 8 Server.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

http_directory = "../../../configs/linux/almalinux-server"
http_file      = "ks.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "almalinux"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "8" 
vm_guest_os_type            = "centos8_64Guest" 
vm_version                  = 18
vm_firmware                 = "efi-secure"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"

# ISO Objects

iso_file     = "iso-linux-almalinux-server-8.iso"
iso_checksum = "44f56b309fa0cccf41f4d8a5ca3c9b91bb7da510ff8d8faf93fadef9262df872cb824aa7499c5ada5a7ae743be6b38261ed458c465d84e2504e38ca6f05107d7"

# Scripts

shell_scripts = ["../../../scripts/linux/almalinux-server-cleanup.sh"]
