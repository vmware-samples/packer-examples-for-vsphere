/*
    DESCRIPTION: 
    CentOS Stream 8 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_family  = "linux"
vm_guest_os_vendor  = "centos-stream"
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
iso_file     = "iso-linux-centos-stream-8.iso"
iso_checksum = "552cf5dcdc9d3db41791a2b3bbbd18335d75607ca54e7aa8bf28a6ea1d49ce914a55da0bd839123aa96654b7de6db65cc786beb71e6233982ea96ce456a47035"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"

// Provisioner Settings
scripts = ["../../../scripts/linux/redhat-variant.sh"]
inline  = []