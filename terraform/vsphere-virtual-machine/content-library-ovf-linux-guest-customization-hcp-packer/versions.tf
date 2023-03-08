##################################################################################
# VERSIONS
##################################################################################

terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.55.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.3.1"
    }
  }
  required_version = ">= 1.3.9"
}
