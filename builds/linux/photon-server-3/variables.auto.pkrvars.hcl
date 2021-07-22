# Maintainer: code@rainpole.io
# Packer variables for VMware Photon OS 3 Server.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

http_directory = "../../../configs/linux/photon-server"
http_file      = "ks.json"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "photon"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "3"
vm_guest_os_type            = "vmwarePhoton64Guest" 
vm_version                  = 18
vm_firmware                 = "bios"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"

# ISO Objects

iso_file     = "iso-linux-photon-server-3.iso"
iso_checksum = "72fe0580e4d0e8e9bed8127f7a6dcd991dbbe4690a225ea13364379e4282bdd250ccde7a27d1a89eefaeb327b3cbb72026326b841d9377aa81399bcd16a2dfb3"

# Scripts

shell_scripts = ["../../../scripts/linux/photon-server-cleanup.sh"]