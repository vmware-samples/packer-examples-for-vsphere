##################################################################################
# VERSIONS
##################################################################################

terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.71.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.4.0"
    }
  }
  required_version = ">= 1.5.0"
}
