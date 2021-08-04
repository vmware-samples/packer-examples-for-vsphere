# Maintainer: code@rainpole.io
# Packer variables for Windows Server 2019 Standard and Datacenter - Desktop Experience and Core
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# VARIABLES
##################################################################################

# Virtual Machine Settings

vm_guest_os_family          = "windows"
vm_guest_os_member          = "server" 
vm_guest_os_version         = "2016"
vm_guest_os_edition_std     = "standard"
vm_guest_os_edition_dc      = "datacenter"
vm_guest_os_type            = "windows9Server64Guest"
vm_version                  = 18
vm_firmware                 = "efi-secure"
vm_boot_command             = ["<spacebar>"]
vm_boot_wait                = "2s"
vm_cdrom_type               = "sata"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_disk_size                = 102400
vm_disk_controller_type     = ["pvscsi"]
vm_network_card             = "vmxnet3"
vm_floppy_files_server_std_dexp = [
  "../../../configs/windows/windows-server-2016/standard/efi-secure/autounattend.xml",
  "../../../scripts/windows/",
  "../../../certificates/"
  ]
vm_floppy_files_server_std_core = [
  "../../../configs/windows/windows-server-2016/standard-core/efi-secure/autounattend.xml",
  "../../../scripts/windows/",
  "../../../certificates/"
  ]
vm_floppy_files_server_dc_dexp = [
  "../../../configs/windows/windows-server-2016/datacenter/efi-secure/autounattend.xml",
  "../../../scripts/windows/",
  "../../../certificates/"
  ]
vm_floppy_files_server_dc_core = [
  "../../../configs/windows/windows-server-2016/datacenter-core/efi-secure/autounattend.xml",
  "../../../scripts/windows/",
  "../../../certificates/"
  ]
vm_shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""

# ISO Objects

iso_file      = "iso-windows-server-2016.iso"
iso_checksum  = "12245fad2f514265732fa3f9a24bc72cfc44ba773f208b2c2eecd75ee4a1709e89a8ba2191b5d58f19cd34d5c8186f9879e58f0e1490a4521a88503767326dd2"

# PowerShell Provisioner Objects

powershell_scripts = [
  "../../../scripts/windows/windows-server-cleanup.ps1"
  ]
powershell_inline = [
  "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
  "choco feature enable -n allowGlobalConfirmation",
  "choco install googlechrome",
  "choco install firefox",
  "choco install postman",
  "choco install winscp",
  "choco install putty",
  "choco install vscode",
  "Get-EventLog -LogName * | ForEach { Clear-EventLog -LogName $_.Log }"
  ]