/*
    DESCRIPTION:
    Ubuntu Server 20.04 LTS variables using the Packer Builder for VMware vSphere (vsphere-iso).
*/

//  BLOCK: variable
//  Defines the input variables.

// vSphere Credentials

variable "vsphere_endpoint" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance. (e.g. 'sfo-w01-vc01.sfo.rainpole.io')"
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance. (e.g. 'svc-packer-vsphere@rainpole.io')"
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
  description = "The name of the target vSphere datacenter. (e.g. 'sfo-w01-dc01')"
}

variable "vsphere_cluster" {
  type        = string
  description = "The name of the target vSphere cluster. (e.g. 'sfo-w01-cl01')"
}

variable "vsphere_datastore" {
  type        = string
  description = "The name of the target vSphere datastore. (e.g. 'sfo-w01-cl01-vsan01')"
}

variable "vsphere_network" {
  type        = string
  description = "The name of the target vSphere network segment. (e.g. 'sfo-w01-dhcp')"
}

variable "vsphere_folder" {
  type        = string
  description = "The name of the target vSphere cluster. (e.g. 'sfo-w01-fd-templates')"
}

// Virtual Machine Settings

variable "vm_guest_os_language" {
  type        = string
  description = "The guest operating system lanugage."
  default     = "en_US"
}

variable "vm_guest_os_keyboard" {
  type        = string
  description = "The guest operating system keyboard input."
  default     = "us"
}

variable "vm_guest_os_timezone" {
  type        = string
  description = "The guest operating system timezone."
  default     = "UTC"
}

variable "vm_guest_os_family" {
  type        = string
  description = "The guest operating system family. Used for naming. (e.g. 'linux')"
}

variable "vm_guest_os_name" {
  type        = string
  description = "The guest operating system name. Used for naming . (e.g. 'ubuntu')"
}

variable "vm_guest_os_version" {
  type        = string
  description = "The guest operating system version. Used for naming. (e.g. '20-04-lts')"
}

variable "vm_guest_os_type" {
  type        = string
  description = "The guest operating system type, also know as guestid. (e.g. 'ubuntu64Guest')"
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware. (e.g. 'efi-secure'. 'efi', or 'bios')"
  default     = "efi-secure"
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type. (e.g. 'sata', or 'ide')"
  default     = "sata"
}

variable "vm_cpu_count" {
  type        = number
  description = "The number of virtual CPUs. (e.g. '2')"
}

variable "vm_cpu_cores" {
  type        = number
  description = "The number of virtual CPUs cores per socket. (e.g. '1')"
}

variable "vm_cpu_hot_add" {
  type        = bool
  description = "Enable hot add CPU."
  default     = false
}

variable "vm_mem_size" {
  type        = number
  description = "The size for the virtual memory in MB. (e.g. '2048')"
}

variable "vm_mem_hot_add" {
  type        = bool
  description = "Enable hot add memory."
  default     = false
}

variable "vm_disk_size" {
  type        = number
  description = "The size for the virtual disk in MB. (e.g. '40960')"
}

variable "vm_disk_controller_type" {
  type        = list(string)
  description = "The virtual disk controller types in sequence. (e.g. 'pvscsi')"
  default     = ["pvscsi"]
}

variable "vm_disk_thin_provisioned" {
  type        = bool
  description = "Thin provision the virtual disk."
  default     = true
}

variable "vm_network_card" {
  type        = string
  description = "The virtual network card type. (e.g. 'vmxnet3' or 'e1000e')"
  default     = "vmxnet3"
}

variable "common_vm_version" {
  type        = number
  description = "The vSphere virtual hardware version. (e.g. '19')"
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
  description = "The name of the target vSphere content library, if used. (e.g. 'sfo-w01-cl01-lib01')"
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
  description = "Skip exporting the virtual machine to the content library. Option allows for testing / debugging without saving the machine image."
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
  description = "The name of the source vSphere datastore for ISO images. (e.g. 'sfo-w01-cl01-nfs01')"
}

variable "iso_path" {
  type        = string
  description = "The path on the source vSphere datastore for ISO image. (e.g. 'iso/linux/ubuntu')"
}

variable "iso_file" {
  type        = string
  description = "The file name of the ISO image used by the vendor. (e.g. 'ubuntu-<version>-live-server-amd64.iso')"
}

variable "iso_checksum_type" {
  type        = string
  description = "The checksum algorithm used by the vendor. (e.g. 'sha256')"
}

variable "iso_checksum_value" {
  type        = string
  description = "The checksum value provided by the vendor."
}

// Boot Settings

variable "common_data_source" {
  type        = string
  description = "The provisioning data source. (e.g. 'http' or 'disk')"
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
  description = "The boot order for virtual machines devices. (e.g. 'disk,cdrom')"
  default     = "disk,cdrom"
}

variable "vm_boot_wait" {
  type        = string
  description = "The time to wait before boot."
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
  description = "The username to login to the guest operating system. (e.g. 'rainpole')"
  sensitive   = true
}

variable "build_password" {
  type        = string
  description = "The password to login to the guest operating system."
  sensitive   = true
}

variable "build_password_encrypted" {
  type        = string
  description = "The encrypted password to login the guest operating system."
  sensitive   = true
}

variable "build_key" {
  type        = string
  description = "The public key to login to the guest operating system."
  sensitive   = true
}

variable "communicator_proxy_host" {
  type        = string
  description = "A SOCKS proxy host to use for SSH connection."
  default     = null
}

variable "communicator_proxy_port" {
  type        = number
  description = "A port of the SOCKS proxy."
  default     = null
}

variable "communicator_proxy_username" {
  type        = string
  description = "The optional username to authenticate with the proxy server."
  default     = null
}

variable "communicator_proxy_password" {
  type        = string
  description = "The optional password to use to authenticate with the proxy server."
  sensitive   = true
  default     = null
}

variable "communicator_port" {
  type        = string
  description = "The port for the communicator protocol."
}

variable "communicator_timeout" {
  type        = string
  description = "The timeout for the communicator protocol."
}

// Ansible Credentials

variable "ansible_username" {
  type        = string
  description = "The username for Ansible to login to the guest operating system. (e.g. 'ansible')"
  sensitive   = true
}

variable "ansible_key" {
  type        = string
  description = "The public key for Ansible to login to the guest operating system."
  sensitive   = true
}

// HCP Packer Settings

variable "common_hcp_packer_registry_enabled" {
  type        = bool
  description = "Enable the HCP Packer registry."
  default     = false
}
