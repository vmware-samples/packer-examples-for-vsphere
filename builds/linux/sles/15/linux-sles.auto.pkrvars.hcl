/*
    DESCRIPTION:
    SUSE Linux Enterprise Server 15 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_language = "en_US"
vm_guest_os_keyboard = "us"
vm_guest_os_timezone = "UTC"
vm_guest_os_family   = "linux"
vm_guest_os_name     = "sles"
vm_guest_os_version  = "15"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "sles15_64Guest"

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
iso_path           = "iso/linux/suse"
iso_file           = "SLE-15-SP3-Full-x86_64-GM-Media1.iso"
iso_checksum_type  = "sha256"
iso_checksum_value = "2a6259fc849fef6ce6701b8505f64f89de0d2882857def1c9e4379d26e74fa56"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
