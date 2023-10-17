<!-- markdownlint-disable first-line-h1 no-inline-html -->

<img src="assets/images/icon-color.svg" alt="VMware vSphere" width="100">

# Packer Examples for VMware vSphere

This repository provides a collection of opinionated examples that demonstrate how you can use both :simple-packer: [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso` builder) to automate the creation of virtual machine images for VMware vSphere environments.

Whether you're a developer, systems administrator, or site reliability engineer, this project is designed to both help and inspire you in streamlining your infrastructure provisioning process and maintain consistency in your virtualization workflow.

All examples are provided in the HashiCorp Configuration Language ("HCL").

This project supports the following guest operating systems:

## :fontawesome-brands-linux: &nbsp; Linux Distributions

::spantable::
| Operating System                                                        | Version   | VMTools Customization                | Cloud-Init Customization             |
| :---                                                                    | :---      | :---                                 | :---                                 |
| :simple-vmware: &nbsp;&nbsp; VMware Photon OS @span                     | 5.0       | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 4.0       | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
| :fontawesome-brands-debian: &nbsp;&nbsp; Debian @span                   | 12        | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 11        | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
| :fontawesome-brands-ubuntu: &nbsp;&nbsp; Ubuntu Server @span            | 22.04 LTS | :octicons-x-circle-24:               | :octicons-check-circle-24:{ .green } |
|                                                                         | 20.04 LTS | :octicons-x-circle-24:               | :octicons-check-circle-24:{ .green } |
| :fontawesome-brands-redhat: &nbsp;&nbsp; Red Hat Enterprise Linux @span | 9         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 8         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 7         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
| :fontawesome-brands-linux: &nbsp;&nbsp; AlmaLinux OS @span              | 9         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 8         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
| :simple-rockylinux: &nbsp;&nbsp; Rocky Linux @span                      | 9         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 8         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
| :simple-oracle: &nbsp;&nbsp; Oracle Linux @span                         | 9         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 8         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
| :fontawesome-brands-centos: &nbsp;&nbsp; CentOS @span                   | 9 Stream  | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 8 Stream  | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
|                                                                         | 7         | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
| :fontawesome-brands-suse: &nbsp;&nbsp; SUSE Linux Enterprise @span      | 15        | :octicons-check-circle-24:{ .green } | :octicons-x-circle-24:               |
::end-spantable::

## :fontawesome-brands-windows: &nbsp; Microsoft Windows

::spantable::
| Operating System                                                         | Version   | Editions                    | Experience       |
| :---                                                                     | :---      | :---                        | :---             |
| :fontawesome-brands-windows: &nbsp;&nbsp; Microsoft Windows Server @span | 2022      | Standard and Enterprise     | Core and Desktop |
|                                                                          | 2019      | Standard and Enterprise     | Core and Desktop |
| :fontawesome-brands-windows: &nbsp;&nbsp; Microsoft Windows @span        | 11 22H2   | Professional and Enterprise | -                |
|                                                                          | 10 22H2   | Professional and Enterprise | -                |
::end-spantable::

[//]: Links
[packer]: https://www.packer.io
[packer-plugin-vsphere]: https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso
