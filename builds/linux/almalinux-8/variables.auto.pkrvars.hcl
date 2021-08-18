# Maintainer: code@rainpole.io
# AlmaLinux 8 variables for the Packer Builder for VMware vSphere (vsphere-iso).

##################################################################################
# VARIABLES
##################################################################################

// Guest Operating System Metadata
vm_guest_os_family  = "linux"
vm_guest_os_vendor  = "almalinux"
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
iso_file     = "iso-linux-almalinux-8.iso"
iso_checksum = "44f56b309fa0cccf41f4d8a5ca3c9b91bb7da510ff8d8faf93fadef9262df872cb824aa7499c5ada5a7ae743be6b38261ed458c465d84e2504e38ca6f05107d7"

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