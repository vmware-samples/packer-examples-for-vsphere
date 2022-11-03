##################################################################################
# VERSIONS
##################################################################################

terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.47.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.2.0"
    }
  }
  required_version = ">= 1.3.4"
}
