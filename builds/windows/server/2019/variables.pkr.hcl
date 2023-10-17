# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Microsoft Windows Server 2019 input variables.
    Packer Plugin for VMware vSphere: 'vsphere-iso' builder.
*/

//  BLOCK: variable
//  Defines the input variables.

// vSphere Credentials

variable "vsphere_endpoint" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance."
  sensitive   = true
}

variable "vsphere_password" {
  type        = string
  description = "The password for the login to the vCenter Server instance."
  sensitive   = true
}

variable "vsphere_insecure_connection" {
  type        = bool
  description = "Do not validate vCenter Server TLS certificate."
}

// vSphere Settings

variable "vsphere_datacenter" {
  type        = string
  description = "The name of the target vSphere datacenter."
  default     = ""
}

variable "vsphere_cluster" {
  type        = string
  description = "The name of the target vSphere cluster."
  default     = ""
}

variable "vsphere_host" {
  type        = string
  description = "The name of the target ESXi host."
  default     = ""
}

variable "vsphere_datastore" {
  type        = string
  description = "The name of the target vSphere datastore."
}

variable "vsphere_network" {
  type        = string
  description = "The name of the target vSphere network segment."
}

variable "vsphere_folder" {
  type        = string
  description = "The name of the target vSphere folder."
  default     = ""
}

// Installer Settings

variable "vm_inst_os_language" {
  type        = string
  description = "The installation operating system lanugage."
  default     = "en-US"
}

variable "vm_inst_os_keyboard" {
  type        = string
  description = "The installation operating system keyboard input."
  default     = "en-US"
}

variable "vm_inst_os_image_standard_core" {
  type        = string
  description = "The installation operating system image input for Microsoft Windows Standard Core."
}

variable "vm_inst_os_image_standard_desktop" {
  type        = string
  description = "The installation operating system image input for Microsoft Windows Standard."
}

variable "vm_inst_os_kms_key_standard" {
  type        = string
  description = "The installation operating system KMS key input for Microsoft Windows Standard edition."
}

variable "vm_inst_os_image_datacenter_core" {
  type        = string
  description = "The installation operating system image input for Microsoft Windows Datacenter Core."
}

variable "vm_inst_os_image_datacenter_desktop" {
  type        = string
  description = "The installation operating system image input for Microsoft Windows Datacenter."
}

variable "vm_inst_os_kms_key_datacenter" {
  type        = string
  description = "The installation operating system KMS key input for Microsoft Windows Datacenter edition."
}

// Virtual Machine Settings

variable "vm_guest_os_language" {
  type        = string
  description = "The guest operating system lanugage."
  default     = "en-US"
}

variable "vm_guest_os_keyboard" {
  type        = string
  description = "The guest operating system keyboard input."
  default     = "en-US"
}

variable "vm_guest_os_timezone" {
  type        = string
  description = "The guest operating system timezone."
  default     = "UTC"
}

variable "vm_guest_os_family" {
  type        = string
  description = "The guest operating system family. Used for naming and VMware Tools."
}

variable "vm_guest_os_name" {
  type        = string
  description = "The guest operating system name. Used for naming."
}

variable "vm_guest_os_version" {
  type        = string
  description = "The guest operating system version. Used for naming."
}

variable "vm_guest_os_edition_standard" {
  type        = string
  description = "The guest operating system edition. Used for naming."
  default     = "standard"
}

variable "vm_guest_os_edition_datacenter" {
  type        = string
  description = "The guest operating system edition. Used for naming."
  default     = "datacenter"
}

variable "vm_guest_os_experience_core" {
  type        = string
  description = "The guest operating system minimal experience. Used for naming."
  default     = "core"
}

variable "vm_guest_os_experience_desktop" {
  type        = string
  description = "The guest operating system desktop experience. Used for naming."
  default     = "dexp"
}

variable "vm_guest_os_type" {
  type        = string
  description = "The guest operating system type, also know as guestid."
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware."
  default     = "efi-secure"
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type."
  default     = "sata"
}

variable "vm_cpu_count" {
  type        = number
  description = "The number of virtual CPUs."
}

variable "vm_cpu_cores" {
  type        = number
  description = "The number of virtual CPUs cores per socket."
}

variable "vm_cpu_hot_add" {
  type        = bool
  description = "Enable hot add CPU."
}

variable "vm_mem_size" {
  type        = number
  description = "The size for the virtual memory in MB."
}

variable "vm_mem_hot_add" {
  type        = bool
  description = "Enable hot add memory."
}

variable "vm_disk_size" {
  type        = number
  description = "The size for the virtual disk in MB."
}

variable "vm_disk_controller_type" {
  type        = list(string)
  description = "The virtual disk controller types in sequence."
  default     = ["pvscsi"]
}

variable "vm_disk_thin_provisioned" {
  type        = bool
  description = "Thin provision the virtual disk."
  default     = true
}

variable "vm_network_card" {
  type        = string
  description = "The virtual network card type."
  default     = "vmxnet3"
}

variable "common_vm_version" {
  type        = number
  description = "The vSphere virtual hardware version."
}

variable "common_tools_upgrade_policy" {
  type        = bool
  description = "Upgrade VMware Tools on reboot."
  default     = true
}

variable "common_remove_cdrom" {
  type        = bool
  description = "Remove the virtual CD-ROM(s)."
  default     = true
}

// Template and Content Library Settings

variable "common_template_conversion" {
  type        = bool
  description = "Convert the virtual machine to template. Must be 'false' for content library."
  default     = false
}

variable "common_content_library_name" {
  type        = string
  description = "The name of the target vSphere content library, if used."
  default     = null
}

variable "common_content_library_ovf" {
  type        = bool
  description = "Export to content library as an OVF template."
  default     = true
}

variable "common_content_library_destroy" {
  type        = bool
  description = "Delete the virtual machine after exporting to the content library."
  default     = true
}

variable "common_content_library_skip_export" {
  type        = bool
  description = "Skip exporting the virtual machine to the content library. Option allows for testing/debugging without saving the machine image."
  default     = false
}

// OVF Export Settings

variable "common_ovf_export_enabled" {
  type        = bool
  description = "Enable OVF artifact export."
  default     = false
}

variable "common_ovf_export_overwrite" {
  type        = bool
  description = "Overwrite existing OVF artifact."
  default     = true
}

// Removable Media Settings

variable "common_iso_datastore" {
  type        = string
  description = "The name of the source vSphere datastore for the guest operating system ISO."
}

variable "iso_path" {
  type        = string
  description = "The path on the source vSphere datastore for the guest operating system ISO."
}

variable "iso_file" {
  type        = string
  description = "The file name of the guest operating system ISO."
}

// Boot Settings

variable "common_data_source" {
  type        = string
  description = "The provisioning data source. One of `http` or `disk`."
}

variable "common_http_ip" {
  type        = string
  description = "Define an IP address on the host to use for the HTTP server."
  default     = null
}

variable "common_http_port_min" {
  type        = number
  description = "The start of the HTTP port range."
}

variable "common_http_port_max" {
  type        = number
  description = "The end of the HTTP port range."
}

variable "vm_boot_order" {
  type        = string
  description = "The boot order for virtual machines devices."
  default     = "disk,cdrom"
}

variable "vm_boot_wait" {
  type        = string
  description = "The time to wait before boot."
}

variable "vm_boot_command" {
  type        = list(string)
  description = "The virtual machine boot command."
  default     = []
}

variable "vm_shutdown_command" {
  type        = string
  description = "Command(s) for guest operating system shutdown."
}

variable "common_ip_wait_timeout" {
  type        = string
  description = "Time to wait for guest operating system IP address response."
}

variable "common_shutdown_timeout" {
  type        = string
  description = "Time to wait for guest operating system shutdown."
}

// Communicator Settings and Credentials

variable "build_username" {
  type        = string
  description = "The username to login to the guest operating system."
  sensitive   = true
}

variable "build_password" {
  type        = string
  description = "The password to login to the guest operating system."
  sensitive   = true
}

variable "build_password_encrypted" {
  type        = string
  description = "The SHA-512 encrypted password to login to the guest operating system."
  sensitive   = true
  default     = ""
}

variable "build_key" {
  type        = string
  description = "The public key to login to the guest operating system."
  sensitive   = true
  default     = ""
}

// Communicator Credentials

variable "communicator_port" {
  type        = string
  description = "The port for the communicator protocol."
}

variable "communicator_timeout" {
  type        = string
  description = "The timeout for the communicator protocol."
}

// Provisioner Settings

variable "scripts" {
  type        = list(string)
  description = "A list of scripts and their relative paths to transfer and run."
  default     = []
}

variable "inline" {
  type        = list(string)
  description = "A list of commands to run."
  default     = []
}

// HCP Packer Settings

variable "common_hcp_packer_registry_enabled" {
  type        = bool
  description = "Enable the HCP Packer registry."
  default     = false
}
