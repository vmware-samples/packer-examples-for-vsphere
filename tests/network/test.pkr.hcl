source "null" "test" {
  communicator = "none"
}

locals {
  autoinstall = templatefile("${abspath(path.root)}/templates/autoinstall.pkrtpl", {
    device  = var.vm_network_device,
    ip      = var.vm_ip_address,
    netmask = var.vm_ip_netmask,
    gateway = var.vm_ip_gateway,
    dns     = var.vm_dns_list,
  })
  kickstart = templatefile("${abspath(path.root)}/templates/kickstart.pkrtpl", {
    device  = var.vm_network_device,
    ip      = var.vm_ip_address,
    netmask = var.vm_ip_netmask,
    gateway = var.vm_ip_gateway,
    dns     = var.vm_dns_list,
  })
  preseed = templatefile("${abspath(path.root)}/templates/preseed.pkrtpl", {
    device  = var.vm_network_device,
    ip      = var.vm_ip_address,
    netmask = var.vm_ip_netmask,
    gateway = var.vm_ip_gateway,
    dns     = var.vm_dns_list,
  })
  photon = templatefile("${abspath(path.root)}/templates/photon.pkrtpl", {
    device  = var.vm_network_device,
    ip      = var.vm_ip_address,
    netmask = var.vm_ip_netmask,
    gateway = var.vm_ip_gateway,
    dns     = var.vm_dns_list,
  })
}

build {
  name = "autoinstall"
  sources = ["source.null.test"]
  provisioner "shell-local" {
    inline = [
      "echo '${local.autoinstall}' > ${var.output_folder}/autoinstall",
    ]
  }
}

build {
  name = "kickstart"
  sources = ["source.null.test"]
  provisioner "shell-local" {
    inline = [
      "echo '${local.kickstart}' > ${var.output_folder}/kickstart",
    ]
  }
}

build {
  name = "preseed"
  sources = ["source.null.test"]
  provisioner "shell-local" {
    inline = [
      "echo '${local.preseed}' > ${var.output_folder}/preseed",
    ]
  }
}

build {
  name = "photon"
  sources = ["source.null.test"]
  provisioner "shell-local" {
    inline = [
      "echo '${local.photon}' > ${var.output_folder}/photon",
    ]
  }
}
