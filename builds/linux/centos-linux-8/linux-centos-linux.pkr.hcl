/*
    DESCRIPTION:
    CentOS Linux 8 template using the Packer Builder for VMware vSphere (vsphere-iso).
*/

//  BLOCK: packer
//  The Packer configuration.

packer {
  required_version = ">= 1.7.4"
  required_plugins {
    vsphere = {
      version = ">= v1.0.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

//  BLOCK: locals
//  Defines the local variables.

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

//  BLOCK: source
//  Defines the builder configuration blocks.

source "vsphere-iso" "linux-centos-linux" {

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
  guest_os_type        = var.vm_guest_os_type
  vm_name              = "${var.vm_guest_os_family}-${var.vm_guest_os_vendor}-${var.vm_guest_os_member}-${var.vm_guest_os_version}"
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
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = var.common_vm_version
  remove_cdrom         = var.common_remove_cdrom
  tools_upgrade_policy = var.common_tools_upgrade_policy
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."

  // Removable Media Settings
  iso_paths    = ["[${var.common_iso_datastore}] ${var.common_iso_path}/${var.iso_file}"]
  iso_checksum = "${var.common_iso_hash}:${var.iso_checksum}"

  // Boot and Provisioning Settings
  http_port_min    = var.common_http_port_min
  http_port_max    = var.common_http_port_max
  http_content     = {
    "/ks.cfg" = templatefile("${path.cwd}/http/ks.pkrtpl.hcl", { build_username = var.build_username, build_password_encrypted = var.build_password_encrypted, vm_guest_os_language = var.vm_guest_os_language, vm_guest_os_keyboard = var.vm_guest_os_keyboard, vm_guest_os_timezone = var.vm_guest_os_timezone })
  }
  boot_order       = var.vm_boot_order
  boot_wait        = var.vm_boot_wait
  boot_command     = ["up", "e", "<down><down><end><wait>", "text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg", "<enter><wait><leftCtrlOn>x<leftCtrlOff>"]
  ip_wait_timeout  = var.common_ip_wait_timeout
  shutdown_command = "echo '${var.build_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = var.common_shutdown_timeout

  // Communicator Settings and Credentials
  communicator = "ssh"
  ssh_username = var.build_username
  ssh_password = var.build_password
  ssh_port     = var.communicator_port
  ssh_timeout  = var.communicator_timeout

  // Template and Content Library Settings
  convert_to_template = var.common_template_conversion
  dynamic "content_library_destination" {
    for_each = var.common_content_library_name != null ? [1] : []
    content {
      library = var.common_content_library_name
      ovf     = var.common_content_library_ovf
      destroy = var.common_content_library_destroy
    }
  }
}

//  BLOCK: build
//  Defines the builders to run, provisioners, and post-processors.

build {
  sources = ["source.vsphere-iso.linux-centos-linux"]

  provisioner "file" {
    destination = "/tmp/root-ca.crt"
    source      = "../../../certificates/root-ca.crt"
  }

  provisioner "shell" {
    execute_command = "echo '${var.build_password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.build_username}",
      "BUILD_KEY=${var.build_key}",
      "ANSIBLE_USERNAME=${var.ansible_username}",
      "ANSIBLE_KEY=${var.ansible_key}"
    ]
    scripts = var.scripts
  }

  post-processor "manifest" {
    output     = "${path.cwd}/output/${local.buildtime}-${var.vm_guest_os_family}-${var.vm_guest_os_vendor}.json"
    strip_path = false
  }
}
