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
vm_guest_os_version  = "11"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "other4xLinux64Guest"

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
vm_disk_thin_provisioned = false
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path           = "iso/linux/debian"
iso_file           = "debian-11.4.0-amd64-netinst.iso"
iso_checksum_type  = "sha256"
iso_checksum_value = "d490a35d36030592839f24e468a5b818c919943967012037d6ab3d65d030ef7f"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "5s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
