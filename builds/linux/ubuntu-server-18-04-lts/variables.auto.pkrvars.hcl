# Maintainer: code@rainpole.io
# Ubuntu Server 18.04 LTS variables using the Packer Builder for VMware vSphere (vsphere-iso).

##################################################################################
# VARIABLES
##################################################################################

// Guest Operating System Metadata
vm_guest_os_family  = "linux"
vm_guest_os_vendor  = "ubuntu"
vm_guest_os_member  = "server"
vm_guest_os_version = "18-04-lts"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "ubuntu64Guest"

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
iso_file     = "iso-linux-ubuntu-server-18-04-lts.iso"
iso_checksum = "43738d7dfd3e2661e4d55d2e0f9d8150f0687f4335af9b4dac047bf45fafcb4a4831685281fd5a318c5747681c351375d1129094d3f1bf38d88ab4bb49b6c457"

// Boot Settings
http_directory = "../../../configs/linux/ubuntu-server"
http_file      = "ks.cfg"
vm_boot_order  = "disk,cdrom"
vm_boot_wait   = "3s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"

// Provisioner Settings
scripts = ["../../../scripts/linux/ubuntu-server-18.sh"]
inline  = []