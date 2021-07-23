# Maintainer: code@rainpole.io
# Packer variables for Red Hat Enterprise Linux 8 Server.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings 

http_directory = "../../../configs/linux/redhat-server"
http_file      = "ks-v8.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "redhat"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "8"
vm_guest_os_type            = "rhel8_64Guest" 
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

iso_file     = "iso-linux-redhat-server-8.iso"
iso_checksum = "3b3f4ad5a0b8ef289643bf8cb7f6f5a0fa7b2cbca747dc0ed6b588f574f38bee8c741b76519b8d0bf7dd4328d9ecc950bad443c22ddc8347837a4c58cd85b3a7"

# Scripts

shell_scripts = ["../../../scripts/linux/redhat-server-cleanup.sh"]