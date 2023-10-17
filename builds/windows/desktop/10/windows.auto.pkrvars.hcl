# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Microsoft Windows 10 build variables.
    Packer Plugin for VMware vSphere: 'vsphere-iso' builder.
*/

// Installation Operating System Metadata
vm_inst_os_language    = "en-US"
vm_inst_os_keyboard    = "en-US"
vm_inst_os_image_pro   = "Windows 10 Pro"
vm_inst_os_kms_key_pro = "W269N-WFGWX-YVC9B-4J6C9-T83GX"
vm_inst_os_image_ent   = "Windows 10 Enterprise"
vm_inst_os_kms_key_ent = "NPPR9-FWDCX-D2C8J-H872K-2YT43"

// Guest Operating System Metadata
vm_guest_os_language    = "en-US"
vm_guest_os_keyboard    = "en-US"
vm_guest_os_timezone    = "UTC"
vm_guest_os_family      = "windows"
vm_guest_os_name        = "desktop"
vm_guest_os_version     = "10"
vm_guest_os_edition_pro = "pro"
vm_guest_os_edition_ent = "ent"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "windows9_64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "sata"
vm_cpu_count             = 2
vm_cpu_cores             = 2
vm_cpu_hot_add           = false
vm_mem_size              = 4096
vm_mem_hot_add           = false
vm_disk_size             = 102400
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"
vm_video_ram             = 32768
vm_video_displays        = 1

// Removable Media Settings
iso_path = "iso/windows/desktop"
iso_file = "en-us_windows_10_business_editions_version_22h2_updated_oct_2023_x64_dvd_8fac2c2d.iso"

// Boot Settings
vm_boot_order       = "disk,cdrom"
vm_boot_wait        = "2s"
vm_boot_command     = ["<spacebar>"]
vm_shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Shutdown by Packer\""

// Communicator Settings
communicator_port    = 5985
communicator_timeout = "12h"

// Provisioner Settings
scripts = ["scripts/windows/windows-prepare.ps1"]
inline = [
  "Get-EventLog -LogName * | ForEach { Clear-EventLog -LogName $_.Log }"
]
