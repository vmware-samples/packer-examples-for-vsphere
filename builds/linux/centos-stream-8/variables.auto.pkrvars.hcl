# Maintainer: code@rainpole.io
# Packer template for CentOS Stream 8 Server.
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# HTTP Endpoint for Kickstart

http_directory = "../../../configs/linux/centos-server"
http_file      = "ks-v8.cfg"

# Virtual Machine Settings

vm_guest_os_family          = "linux" 
vm_guest_os_vendor          = "centos"
vm_guest_os_member          = "stream" 
vm_guest_os_version         = "8" 
vm_guest_os_type            = "centos8_64Guest" 
vm_version                  = 18
vm_firmware                 = "bios"
# Firmware for EFI.
# vm_firmware               = "efi-secure"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 40960
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_boot_wait                = "2s"

# ISO Objects

iso_file     = "iso-linux-centos-stream-8.iso"
iso_checksum = "552cf5dcdc9d3db41791a2b3bbbd18335d75607ca54e7aa8bf28a6ea1d49ce914a55da0bd839123aa96654b7de6db65cc786beb71e6233982ea96ce456a47035"

# Scripts

shell_scripts = ["../../../scripts/linux/centos-server-cleanup.sh"]