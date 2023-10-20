##################################################################################
# VARIABLES
##################################################################################

# Credentials

variable "vsphere_server" {
  type = string
}

variable "vsphere_username" {
  type      = string
  sensitive = true
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_insecure" {
  type    = bool
  default = false
}

# vSphere Settings

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_cluster" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_folder" {
  type = string
}

variable "vsphere_network" {
  type = string
}

variable "vsphere_template" {
  type = string
}

# Virtual Machine Settings

variable "vm_name" {
  type = string
}

variable "vm_cpus" {
  type = number
}

variable "vm_memory" {
  type = number
}

variable "vm_firmware" {
  type = string
}

variable "vm_efi_secure_boot_enabled" {
  type = bool
}
