/*
    DESCRIPTION:
    Microsoft Windows Server 2022 Standard variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_language      = "en-US"
vm_guest_os_keyboard      = "en-US"
vm_guest_os_timezone      = "UTC"
vm_guest_os_vendor        = "microsoft"
vm_guest_os_family        = "windows"
vm_guest_os_member        = "server"
vm_guest_os_version       = "2022"
vm_guest_os_ed_standard   = "standard"
vm_guest_os_ed_datacenter = "datacenter"
vm_guest_os_exp_minimal   = "core"
vm_guest_os_exp_desktop   = "dexp"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "windows2019srv_64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "sata"
vm_cpu_sockets           = 2
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 2048
vm_mem_hot_add           = false
vm_disk_size             = 102400
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path           = "iso/windows"
iso_file           = "en-us_windows_server_version_2022_updated_sep_2021_x64_dvd_ae6b4843.iso"
iso_checksum_type  = "sha256"
iso_checksum_value = "DC6877B430A559DBC3440C65F4B5B1C685E71B4B19934AC049C8ED0E00206CD0"

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