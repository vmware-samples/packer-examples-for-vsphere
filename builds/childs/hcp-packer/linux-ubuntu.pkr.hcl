/*
    DESCRIPTION:
    Ubuntu Server 22.04 LTS child template using the Packer Builder for VMware vSphere (vsphere-clone).
*/

//  BLOCK: packer
//  The Packer configuration.

packer {
  required_version = ">= 1.8.2"
  required_plugins {
    vsphere = {
      version = ">= v1.0.6"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

data "hcp-packer-iteration" "ubuntu" {
  bucket_name = var.hcp_packer_bucket_name
  channel     = var.hcp_packer_channel
}

data "hcp-packer-image" "image" {
  bucket_name    = var.hcp_packer_bucket_name
  iteration_id   = data.hcp-packer-iteration.ubuntu.id
  cloud_provider = "vsphere"
  region         = var.vsphere_datacenter
}

//  BLOCK: locals
//  Defines the local variables.

locals {
  build_by          = "Built by: HashiCorp Packer ${packer.version}"
  build_date        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_version     = formatdate("YY.MM", timestamp())
  build_description = "Version: v${local.build_version}\nBuilt on: ${local.build_date}\n${local.build_by}"
  manifest_date     = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  manifest_path     = "${path.cwd}/manifests/"
  manifest_output   = "${local.manifest_path}${local.manifest_date}.json"
  ovf_export_path   = "${path.cwd}/artifacts/${local.vm_name}"
  vm_name           = "${var.hcp_packer_bucket_name}-child"
}

source "vsphere-clone" "linux-ubuntu-child" {

  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection

  // vSphere Settings
  datacenter = var.vsphere_datacenter
  cluster    = var.vsphere_cluster
  datastore  = var.vsphere_datastore
  folder     = var.vsphere_folder

  // Virtual Machine Settings
  template             = data.hcp-packer-image.image.id
  vm_name              = local.vm_name
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = var.vm_disk_thin_provisioned
  }
  network              = var.vsphere_network
  remove_cdrom         = var.common_remove_cdrom
  tools_upgrade_policy = var.common_tools_upgrade_policy
  notes                = local.build_description

  // Removable Media Sttings
  ip_wait_timeout  = var.common_ip_wait_timeout
  shutdown_command = "echo '${var.build_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = var.common_shutdown_timeout

  // Communicator Settings and Credentials
  communicator       = "ssh"
  ssh_proxy_host     = var.communicator_proxy_host
  ssh_proxy_port     = var.communicator_proxy_port
  ssh_proxy_username = var.communicator_proxy_username
  ssh_proxy_password = var.communicator_proxy_password
  ssh_username       = var.build_username
  ssh_password       = var.build_password
  ssh_port           = var.communicator_port
  ssh_timeout        = var.communicator_timeout

  // Template and Content Library Settings
  convert_to_template = var.common_template_conversion
  dynamic "content_library_destination" {
    for_each = var.common_content_library_name != null ? [1] : []
    content {
      library     = var.common_content_library_name
      description = local.build_description
      ovf         = var.common_content_library_ovf
      destroy     = var.common_content_library_destroy
      skip_import = var.common_content_library_skip_export
    }
  }

  // OVF Export Settings
  dynamic "export" {
    for_each = var.common_ovf_export_enabled == true ? [1] : []
    content {
      name  = local.vm_name
      force = var.common_ovf_export_overwrite
      options = [
        "extraconfig"
      ]
      output_directory = local.ovf_export_path
    }
  }
}

build {
  sources = ["source.vsphere-clone.linux-ubuntu-child"]

  provisioner "ansible" {
    user          = var.build_username
    playbook_file = "${path.cwd}/ansible/main.yml"
    roles_path    = "${path.cwd}/ansible/roles"
    ansible_env_vars = [
      "ANSIBLE_CONFIG=${path.cwd}/ansible/ansible.cfg"
    ]
    extra_arguments = [
      "--extra-vars", "display_skipped_hosts=false",
      "--extra-vars", "BUILD_USERNAME=${var.build_username}",
      "--extra-vars", "BUILD_SECRET='${var.build_key}'",
      "--extra-vars", "ANSIBLE_USERNAME=${var.ansible_username}",
      "--extra-vars", "ANSIBLE_SECRET='${var.ansible_key}'",
    ]
  }

  post-processor "manifest" {
    output     = local.manifest_output
    strip_path = true
    strip_time = true
    custom_data = {
      ansible_username         = var.ansible_username
      build_username           = var.build_username
      build_date               = local.build_date
      build_version            = local.build_version
      common_data_source       = var.common_data_source
      common_vm_version        = var.common_vm_version
      vm_cpu_cores             = var.vm_cpu_cores
      vm_cpu_sockets           = var.vm_cpu_sockets
      vm_disk_size             = var.vm_disk_size
      vm_disk_thin_provisioned = var.vm_disk_thin_provisioned
      vm_firmware              = var.vm_firmware
      vm_guest_os_type         = var.vm_guest_os_type
      vm_mem_size              = var.vm_mem_size
      vm_network_card          = var.vm_network_card
      vsphere_cluster          = var.vsphere_cluster
      vsphere_datacenter       = var.vsphere_datacenter
      vsphere_datastore        = var.vsphere_datastore
      vsphere_endpoint         = var.vsphere_endpoint
      vsphere_folder           = var.vsphere_folder
    }
  }

  hcp_packer_registry {
    bucket_name = local.vm_name
    description = "${var.vm_guest_os_family} ${var.vm_guest_os_name} ${var.vm_guest_os_version}"
    bucket_labels = {
      "os_family": var.vm_guest_os_family,
      "os_name": var.vm_guest_os_name,
      "os_version": var.vm_guest_os_version,
    }
    build_labels = {
      "build_version": local.build_version,
      "packer_version": packer.version,
    }
  }
}
