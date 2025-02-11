##################################################################################
# VERSIONS
##################################################################################

terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.102.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.11.0"
    }
  }
  required_version = ">= 1.10.0"
}
