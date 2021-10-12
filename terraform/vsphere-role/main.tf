##################################################################################
# PROVIDERS
##################################################################################

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_username
  password             = var.vsphere_password
  allow_unverified_ssl = var.vsphere_insecure
}

##################################################################################
# DATA
##################################################################################

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

##################################################################################
# RESOURCES
##################################################################################

resource "vsphere_role" "packer-vsphere" {
  name            = var.packer_vsphere_role
  role_privileges = var.packer_vsphere_privileges
}