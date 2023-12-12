# Copyright 2023 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    AlmaLinux OS 8 storage variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// VM Storage Settings

variable "vm_disk_device" {
  type        = string
  description = "The device for the virtual disk. (e.g. 'sda')"
}

variable "vm_disk_use_swap" {
  type        = bool
  description = "Whether to use a swap partition."
}

variable "vm_disk_partitions" {
  type = list(object({
    name = string
    size = number
    format = object({
      label  = string
      fstype = string
    })
    mount = object({
      path    = string
      options = string
    })
    volume_group = string
  }))
  description = "The disk partitions for the virtual disk."
}

variable "vm_disk_lvm" {
  type = list(object({
    name    = string
    partitions = list(object({
      name = string
      size = number
      format = object({
        label  = string
        fstype = string
      })
      mount = object({
        path    = string
        options = string
      })
    }))
  }))
  description = "The LVM configuration for the virtual disk."
  default     = []
}