/*
    DESCRIPTION:
    Microsoft Windows Server 2016 variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Installation Operating System Metadata
vm_inst_os_language                 = "en-US"
vm_inst_os_keyboard                 = "en-US"
vm_inst_os_image_standard_core      = "Windows Server 2016 SERVERSTANDARDCORE"
vm_inst_os_image_standard_desktop   = "Windows Server 2016 SERVERSTANDARD"
vm_inst_os_kms_key_standard         = "WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
vm_inst_os_image_datacenter_core    = "Windows Server 2016 SERVERDATACENTERCORE"
vm_inst_os_image_datacenter_desktop = "Windows Server 2016 SERVERDATACENTER"
vm_inst_os_kms_key_datacenter       = "CB7KF-BWN84-R7R2Y-793K2-8XDDG"

// Guest Operating System Metadata
vm_guest_os_language           = "en-US"
vm_guest_os_keyboard           = "en-US"
vm_guest_os_timezone           = "UTC"
vm_guest_os_family             = "windows"
vm_guest_os_name               = "server"
vm_guest_os_version            = "2016"
vm_guest_os_edition_standard   = "standard"
vm_guest_os_edition_datacenter = "datacenter"
vm_guest_os_experience_core    = "core"
vm_guest_os_experience_desktop = "dexp"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "windows9Server64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "sata"
vm_cpu_sockets           = 2
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 4096
vm_mem_hot_add           = false
vm_disk_size             = 102400
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path           = "iso/windows/server"
iso_file           = "en_windows_server_2016_x64_dvd_9327751.iso"
iso_checksum_type  = "sha1"
iso_checksum_value = "7E33DF150CB4D1FE3503E23433A1867DDD79A6EE"

// Boot Settings
vm_boot_order       = "disk,cdrom"
vm_boot_wait        = "2s"
vm_boot_command     = ["<spacebar>"]
vm_shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Shutdown by Packer\""

// Communicator Settings
communicator_port    = 5985
communicator_timeout = "12h"

// Provisioner Settings
scripts = ["scripts/windows/windows-server-prepare.ps1"]
inline = [
  "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
  "choco feature enable -n allowGlobalConfirmation",
  "Get-EventLog -LogName * | ForEach { Clear-EventLog -LogName $_.Log }"
]