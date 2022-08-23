provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_username
  password             = var.vsphere_password
  allow_unverified_ssl = var.vsphere_insecure
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {
  name          = format("%s%s", data.vsphere_compute_cluster.cluster.name, "/Resources")
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "hcp_packer_image" "image" {
  bucket_name    = var.hcp_packer_bucket_name
  cloud_provider = "vsphere"
  channel        = var.hcp_packer_channel
  region         = var.vsphere_datacenter
}

data "vsphere_content_library" "content_library" {
  name = split("/", data.hcp_packer_image.image.labels.content_library_destination)[0]
}

data "vsphere_content_library_item" "content_library_item" {
  name       = split("/", data.hcp_packer_image.image.labels.content_library_destination)[1]
  type       = "vm-template"
  library_id = data.vsphere_content_library.content_library.id
}

resource "vsphere_virtual_machine" "vm" {
  name                    = var.vm_name
  folder                  = var.vsphere_folder
  num_cpus                = var.vm_cpus
  memory                  = var.vm_memory
  firmware                = var.vm_firmware
  efi_secure_boot_enabled = var.vm_efi_secure_boot_enabled
  datastore_id            = data.vsphere_datastore.datastore.id
  resource_pool_id        = data.vsphere_resource_pool.pool.id
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label            = "disk0"
    size             = var.vm_disk_size
    thin_provisioned = true
  }
  clone {
    template_uuid = data.vsphere_content_library_item.content_library_item.id
    customize {
      windows_options {
        computer_name         = var.vm_name
        join_domain           = var.domain
        domain_admin_user     = var.domain_admin_username
        domain_admin_password = var.domain_admin_password
        admin_password        = var.vm_admin_password
      }
      network_interface {
        ipv4_address = var.vm_ipv4_address
        ipv4_netmask = var.vm_ipv4_netmask
      }

      ipv4_gateway    = var.vm_ipv4_gateway
      dns_suffix_list = var.vm_dns_suffix_list
      dns_server_list = var.vm_dns_server_list
    }
  }

  lifecycle {
    ignore_changes = [
      clone[0].template_uuid,
    ]
  }
}
