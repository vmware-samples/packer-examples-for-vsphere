source "null" "test" {
  communicator = "none"
}

locals {
  autoinstall = templatefile("${abspath(path.root)}/templates/autoinstall.pkrtpl", {
    device     = var.vm_disk_device,
    swap       = var.vm_disk_use_swap,
    partitions = var.vm_disk_partitions,
    lvm        = var.vm_disk_lvm,
  })
  kickstart = templatefile("${abspath(path.root)}/templates/kickstart.pkrtpl", {
    device     = var.vm_disk_device,
    swap       = var.vm_disk_use_swap,
    partitions = var.vm_disk_partitions,
    lvm        = var.vm_disk_lvm,
  })
  preseed = templatefile("${abspath(path.root)}/templates/preseed.pkrtpl", {
    device     = var.vm_disk_device,
    swap       = var.vm_disk_use_swap,
    partitions = var.vm_disk_partitions,
    lvm        = var.vm_disk_lvm,
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
