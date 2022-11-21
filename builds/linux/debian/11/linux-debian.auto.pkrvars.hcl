/*
    DESCRIPTION:
    Debian 11 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_language = "en_US"
vm_guest_os_keyboard = "us"
vm_guest_os_timezone = "UTC"
vm_guest_os_family   = "linux"
vm_guest_os_name     = "debian"
vm_guest_os_version  = "11.5"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "other4xLinux64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
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
iso_path           = "iso/linux/debian"
iso_file           = "debian-11.5.0-amd64-netinst.iso"
iso_checksum_type  = "sha512"
iso_checksum_value = "6a6607a05d57b7c62558e9c462fe5c6c04b9cfad2ce160c3e9140aa4617ab73aff7f5f745dfe51bbbe7b33c9b0e219a022ad682d6c327de0e53e40f079abf66a"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "5s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
