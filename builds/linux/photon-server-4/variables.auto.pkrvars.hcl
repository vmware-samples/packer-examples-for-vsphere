# Maintainer: code@rainpole.io
# Packer variables for VMware Photon OS 4 Server.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Kickstart Settings

http_directory = "../../../configs/linux/photon-server"
http_file      = "ks.json"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "photon"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "4"
vm_guest_os_type            = "vmwarePhoton64Guest" 
vm_version                  = 18
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"

# ISO Objects

iso_file     = "iso-linux-photon-server-4.iso"
iso_checksum = "4ff2eb8cf2903251850f27b9abc7ac5b05a24e01dc2afaa6378f7bef29bf7a758fd39d71c875e00627764aea594e1ca223259821021149acbc582a60b11d9368"

# Scripts

shell_scripts = ["../../../scripts/linux/photon-server-cleanup.sh"]
