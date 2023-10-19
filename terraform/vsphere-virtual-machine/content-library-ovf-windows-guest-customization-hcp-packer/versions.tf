##################################################################################
# VERSIONS
##################################################################################

terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.74.1"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.5.1"
    }
  }
  required_version = ">= 1.6.0"
}
