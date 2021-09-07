/*
    DESCRIPTION: 
    Red Hat Enterprise Linux 8 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_family  = "linux"
vm_guest_os_vendor  = "redhat-linux"
vm_guest_os_member  = "server"
vm_guest_os_version = "8"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "rhel8_64Guest"

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
iso_file     = "iso-linux-redhat-linux-8.iso"
iso_checksum = "3b3f4ad5a0b8ef289643bf8cb7f6f5a0fa7b2cbca747dc0ed6b588f574f38bee8c741b76519b8d0bf7dd4328d9ecc950bad443c22ddc8347837a4c58cd85b3a7"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"

// Provisioner Settings
scripts = ["../../../scripts/linux/redhat-linux.sh"]
inline  = []