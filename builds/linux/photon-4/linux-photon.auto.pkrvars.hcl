/*
    DESCRIPTION:
    VMware Photon OS 4 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating Systtem Metadata
vm_guest_os_family  = "linux"
vm_guest_os_vendor  = "photon"
vm_guest_os_member  = "server"
vm_guest_os_version = "4"

// Virtual Machine Guest Operating Systtem Setting
vm_guest_os_type = "vmwarePhoton64Guest"

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
iso_file     = "iso-linux-photon-4.iso"
iso_checksum = "9cb0ae0329a50733f56e921c1e220ce3e9d328499890b8202e05991daec34c4184ef03606caf706e9058035115c23fef1cacbb184200fca8ec577a191ad3f394"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"

// Provisioner Settings
scripts = ["scripts/linux/photon.sh"]
inline  = []