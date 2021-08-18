# Maintainer: code@rainpole.io
# CentOS Linux 8 variables for the Packer Builder for VMware vSphere (vsphere-iso).

##################################################################################
# VARIABLES
##################################################################################

// Guest Operating System Metadata
vm_guest_os_family  = "linux"
vm_guest_os_vendor  = "centos-linux"
vm_guest_os_member  = "server"
vm_guest_os_version = "8"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "centos8_64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "sata"
vm_cpu_sockets           = 2
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 2048
vm_mem_hot_add           = false
vm_disk_size             = 40960
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_file     = "iso-linux-centos-linux-8.iso"
iso_checksum = "ff1164dc26ba47616f2b26a18158398a7d7930487770a8bb9e573d5758e01255ebc11db68c22976abe684a857083a0fae445e9d41d11a24a2073cdb1b500ae9a"

// Boot Settings
http_directory = "../../../configs/linux/redhat-variant"
http_file      = "ks.cfg"
vm_boot_order  = "disk,cdrom"
vm_boot_wait   = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"

// Provisioner Settings
scripts = ["../../../scripts/linux/redhat-variant.sh"]
inline  = []