##################################################################################
# VERSIONS
##################################################################################

terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.89.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.8.1"
    }
  }
  required_version = ">= 1.8.3"
}
