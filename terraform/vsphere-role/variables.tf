##################################################################################
# VARIABLES
##################################################################################

# Credentials

variable "vsphere_server" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance. (e.g. sfo-m01-vc01.sfo.rainpole.io)"
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance. (e.g. administrator@vsphere.local)"
  sensitive   = true
}

variable "vsphere_password" {
  type        = string
  description = "The password for the login to the vCenter Server instance."
  sensitive   = true
}

variable "vsphere_insecure" {
  type        = bool
  description = "Set to true for self-signed certificates."
  default     = false
}

# Roles

variable "packer_vsphere_role" {
  type        = string
  description = "The name for the HashiCorp Packer to VMware vSphere custom role."
}

variable "packer_vsphere_privileges" {
  type        = list(string)
  description = "The vSphere privledges for the HashiCorp Packer to VMware vSphere custom role."
}
