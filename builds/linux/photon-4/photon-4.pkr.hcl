/*
    DESCRIPTION: 
    VMware Photon OS 4 template using the Packer Builder for VMware vSphere (vsphere-iso).
*/

//  BLOCK: packer
//  The Packer configuration.

packer {
  required_version = ">= 1.7.4"
  required_plugins {
    vsphere = {
      version = ">= v1.0.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

//  BLOCK: variable
//  Defines the input variables.

// vSphere Credentials

variable "vsphere_endpoint" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance. (e.g. 'sfo-w01-vc01.sfo.rainpole.io')"
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance. (e.g. svc-packer-vsphere@rainpole.io)"
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
  default     = true
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
  description = "The name of the target vSphere folder. (e.g. 'sfo-w01-fd-templates')"
}

// Virtual Machine Settings

variable "vm_guest_os_family" {
  type        = string
  description = "The guest operating system family. Used for naming. (e.g.'linux')"
}

variable "vm_guest_os_vendor" {
  type        = string
  description = "The guest operating system vendor. Used for naming. (e.g. 'photon')"
}

variable "vm_guest_os_member" {
  type        = string
  description = "The guest operating system member. Used for naming. (e.g. 'server')"
}

variable "vm_guest_os_version" {
  type        = string
  description = "The guest operating system version. Used for naming. (e.g. '4')"
}

variable "vm_guest_os_type" {
  type        = string
  description = "The guest operating system type, also know as guestid. (e.g. 'vmwarePhoton64Guest')"
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware. (e.g. 'efi-secure' or 'bios')"
  default     = "efi-secure"
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type. (e.g. 'sata', or 'ide')"
  default     = "sata"
}

variable "vm_cpu_sockets" {
  type        = number
  description = "The number of virtual CPUs sockets. (e.g. '2')"
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
  description = "The vSphere virtual hardware version. (e.g. '18')"
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
}

variable "common_content_library_ovf" {
  type        = bool
  description = "Export to content library as an OVF template."
  default     = true
}

variable "common_content_library_destroy" {
  type        = bool
  description = "Delete the virtual machine afer exporting to the content library."
  default     = true
}

// Removable Media Settings

variable "common_iso_datastore" {
  type        = string
  description = "The name of the source vSphere datastore for ISO images. (e.g. 'sfo-w01-cl01-nfs01')"
}

variable "common_iso_path" {
  type        = string
  description = "The path on the source vSphere datastore for ISO images. (e.g. 'iso')"
}

variable "common_iso_hash" {
  type        = string
  description = "The algorithm used for the checkcum of the ISO image. (e.g. sha512')"
}

variable "iso_file" {
  type        = string
  description = "The file name of the ISO image. (e.g. 'iso-linux-photon-4.iso')"
}

variable "iso_checksum" {
  type        = string
  description = "The checksum of the ISO image. (e.g. Result of 'shasum -a 512 iso-linux-photon-4.iso')"
}

// Boot Settings

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
  description = "The time to wait before boot."
  default     = "disk,cdrom"
}

variable "vm_boot_wait" {
  type        = string
  description = "The boot order for virtual machines devices."
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
  description = "The username to login to the guest operating system. (e.g. rainpole)"
  sensitive   = true
}

variable "build_password" {
  type        = string
  description = "The password to login to the guest operating system."
  sensitive   = true
}

variable "build_password_encrypted" {
  type        = string
  description = "The encrypted password for building the guest operating system."
  sensitive   = true
}

variable "build_key" {
  type        = string
  description = "The key to login to the guest operating system."
  sensitive   = true
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
  description = "The username for Ansible to login to the guest operating system. (e.g. ansible)"
  sensitive   = true
}

variable "ansible_key" {
  type        = string
  description = "The key for Ansible to login to the guest operating system."
  sensitive   = true
}

// Provisioner Settings

variable "scripts" {
  type        = list(string)
  description = "A list of scripts and their relative paths to transfer and execute."
  default     = []
}

variable "inline" {
  type        = list(string)
  description = "A list of commands to execute."
  default     = []
}

//  BLOCK: locals
//  Defines the local variables.

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

//  BLOCK: source
//  Defines the builder configuration blocks.

source "vsphere-iso" "linux-photon" {

  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection

  // vSphere Settings
  datacenter = var.vsphere_datacenter
  cluster    = var.vsphere_cluster
  datastore  = var.vsphere_datastore
  folder     = var.vsphere_folder

  // Virtual Machine Settings
  guest_os_type        = var.vm_guest_os_type
  vm_name              = "${var.vm_guest_os_family}-${var.vm_guest_os_vendor}-${var.vm_guest_os_member}-${var.vm_guest_os_version}"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = var.vm_disk_thin_provisioned
  }
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = var.common_vm_version
  remove_cdrom         = var.common_remove_cdrom
  tools_upgrade_policy = var.common_tools_upgrade_policy
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."

  // Removable Media Settings
  iso_paths    = ["[${var.common_iso_datastore}] ${var.common_iso_path}/${var.iso_file}"]
  iso_checksum = "${var.common_iso_hash}:${var.iso_checksum}"

  // Boot and Provisioning Settings
  http_port_min    = var.common_http_port_min
  http_port_max    = var.common_http_port_max
  http_content     = {
    "/ks.json"       = templatefile("http/ks.pkrtpl.hcl", { build_username = var.build_username, build_password_encrypted = var.build_password_encrypted })
    "/packages.json" = file("http/packages_minimal.json")
  }
  boot_order       = var.vm_boot_order
  boot_wait        = var.vm_boot_wait
  boot_command     = ["<esc><wait> vmlinuz initrd=initrd.img root=/dev/ram0 loglevel=3 insecure_installation=1 ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.json photon.media=cdrom <enter>"]
  ip_wait_timeout  = var.common_ip_wait_timeout
  shutdown_command = "echo '${var.build_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = var.common_shutdown_timeout

  // Communicator Settings and Credentials
  communicator = "ssh"
  ssh_username = var.build_username
  ssh_password = var.build_password
  ssh_port     = var.communicator_port
  ssh_timeout  = var.communicator_timeout

  // Template and Content Library Settings
  convert_to_template = var.common_template_conversion
  content_library_destination {
    library = var.common_content_library_name
    ovf     = var.common_content_library_ovf
    destroy = var.common_content_library_destroy
  }
}

//  BLOCK: build
//  Defines the builders to run, provisioners, and post-processors.

build {
  sources = ["source.vsphere-iso.linux-photon"]

  provisioner "file" {
    destination = "/tmp/root-ca.crt"
    source      = "../../../certificates/root-ca.crt"
  }
 
  provisioner "shell" {
    execute_command = "echo '${var.build_password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.build_username}",
      "BUILD_KEY=${var.build_key}",
      "ANSIBLE_USERNAME=${var.ansible_username}",
      "ANSIBLE_KEY=${var.ansible_key}"
    ]
    scripts = var.scripts
  }

  post-processor "manifest" {
    output     = "../../../manifests/${local.buildtime}-${var.vm_guest_os_family}-${var.vm_guest_os_vendor}-${var.vm_guest_os_member}-${var.vm_guest_os_version}.json"
    strip_path = false
  }
}
