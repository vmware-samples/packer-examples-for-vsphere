<!-- markdownlint-disable first-line-h1 no-inline-html -->

<img src="assets/images/icon-color.svg" alt="VMware vSphere" width="150">

# Packer Examples for VMware vSphere

This repository provides a collection of opinionated examples that demonstrate how you can use both :simple-packer: [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso` builder) to automate the creation of virtual machine images for VMware vSphere environments.

Whether you're a developer, systems administrator, or site reliability engineer, this project is designed to both help and inspire you in streamlining your infrastructure provisioning process and maintain consistency in your virtualization workflow.

All examples are provided in the HashiCorp Configuration Language ("HCL").

This project supports the following guest operating systems:

## :material-linux: Linux Distributions

::spantable::
| Operating System                                           | Version | Customization: VMTools             | Customization: cloud-init          | Network: DHCP or Static            | Storage: Customize                 |
| :---:                                                      |         | :---:                              | :---:                              | :---:                              | :---:                              |
| :simple-broadcom: VMware Photon OS @span                   | 5.0     | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-x-circle-16:{.red}       |
|                                                            | 4.0     | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-x-circle-16:{.red}       |
| :fontawesome-brands-debian: Debian @span                   | 13      | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 12      | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 11      | :octicons-check-circle-16:{.green} | :octicons-x-circle-16:{.red}       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :fontawesome-brands-ubuntu: Ubuntu Server @span            | 24.04   | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 22.04   | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 20.04   | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :fontawesome-brands-redhat: Red Hat Enterprise Linux @span | 9       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 8       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :simple-almalinux: AlmaLinux OS @span                      | 9       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 8       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :simple-rockylinux: Rocky Linux @span                      | 9       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 8       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :simple-oracle: Oracle Linux @span                         | 9       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 8       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :fontawesome-brands-centos: CentOS Stream @span            | 10      | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
|                                                            | 9       | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :fontawesome-brands-fedora: Fedora Server @span            | 42      | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} |
| :fontawesome-brands-suse: SUSE Linux Enterprise @span      | 15      | :octicons-check-circle-16:{.green} | :octicons-check-circle-16:{.green} | :octicons-x-circle-16:{.red}       | :octicons-x-circle-16:{.red}       |
::end-spantable::

## :fontawesome-brands-windows: Microsoft Windows

::spantable::
| Operating System                                            | Version       | Editions                 | Experience    |
| :---                                                        | :---          | :---                     | :---          |
| :fontawesome-brands-windows: Microsoft Windows Server @span | 2025 @span    | Standard, Enterprise     | Core, Desktop |
|                                                             | 2022 @span    | Standard, Enterprise     | Core, Desktop |
|                                                             | 2019 @span    | Standard, Enterprise     | Core, Desktop |
| :fontawesome-brands-windows: Microsoft Windows @span        | 11 @span      | Professional, Enterprise | -             |
|                                                             | 10 @span      | Professional, Enterprise | -             |
::end-spantable::

[//]: Links
[packer]: https://www.packer.io
[packer-plugin-vsphere]: https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso
