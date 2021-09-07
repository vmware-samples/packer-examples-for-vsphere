/*
    DESCRIPTION: 
    Rocky Linux 8 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_family  = "linux"
vm_guest_os_vendor  = "rocky-linux"
vm_guest_os_member  = "server"
vm_guest_os_version = "8"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "centos8_64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "bios"
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
iso_file     = "iso-linux-rocky-linux-8.iso"
iso_checksum = "dbfacdbbfd50059a0dda5c19071bc2f55496f3651279eafa6f50d2ea2d941fdd8b43b8710e2187cdbfe630fa7efb5d3b047ee0cdbc2f8d09bd5f68a7014e0d0c"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"

// Provisioner Settings
scripts = ["../../../scripts/linux/redhat-variant.sh"]
inline  = []