##################################################################################
# VERSIONS
##################################################################################

terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.37.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.2.0"
    }
  }
  required_version = ">= 1.2.7"
}
