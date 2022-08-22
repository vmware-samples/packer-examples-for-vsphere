/*
    DESCRIPTION:
    Rocky Linux 9 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_language = "en_US"
vm_guest_os_keyboard = "us"
vm_guest_os_timezone = "UTC"
vm_guest_os_family   = "linux"
vm_guest_os_name     = "rocky"
vm_guest_os_version  = "9"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "other5xLinux64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi"
vm_cdrom_type            = "sata"
vm_cpu_count             = 2
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 2048
vm_mem_hot_add           = false
vm_disk_size             = 40960
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_url            = null
iso_path           = "iso/linux/rocky"
iso_file           = "Rocky-9.0-x86_64-dvd.iso"
iso_checksum_type  = "sha256"
iso_checksum_value = "55dbf904b35969be9f6d96f042b7470d1a3cb5c953bba47ab8f79740560d8a8d"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
