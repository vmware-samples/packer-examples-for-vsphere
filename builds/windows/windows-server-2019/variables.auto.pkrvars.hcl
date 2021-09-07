/*
    DESCRIPTION: 
    Microsoft Windows Server 2019 Standard variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_vendor        = "microsoft"
vm_guest_os_family        = "windows"
vm_guest_os_member        = "server"
vm_guest_os_version       = "2019"
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
iso_file     = "iso-windows-server-2019.iso"
iso_checksum = "1c5e178d0aa403acf756ec2be356059ea833c662406a0bcc4531fce144bfc2c69212cb78bf138ecdbc23e7ed05c7d06603409943a2d93d8917a6bdbd01adc37b"

// Boot Settings
vm_boot_order       = "disk,cdrom"
vm_boot_wait        = "2s"
vm_boot_command     = ["<spacebar>"]
vm_shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Shutdown by Packer\""

// Communicator Settings
communicator_port    = 5985
communicator_timeout = "12h"

// Provisioner Settings
scripts = [
  "../../../scripts/windows/windows-server-prepare.ps1"
]
inline = [
  "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
  "choco feature enable -n allowGlobalConfirmation",
  "Get-EventLog -LogName * | ForEach { Clear-EventLog -LogName $_.Log }"
]