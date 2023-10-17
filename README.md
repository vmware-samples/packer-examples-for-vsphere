<!--
Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2
-->

<!-- markdownlint-disable first-line-h1 no-inline-html -->

<img src="docs/assets/images/icon-color.svg" alt="VMware vSphere" width="100">

# Packer Examples for VMware vSphere

![Last Commit](https://img.shields.io/github/last-commit/vmware-samples/packer-examples-for-vsphere?style=for-the-badge&logo=github)&nbsp;&nbsp;
[![Documentation](https://img.shields.io/badge/Documentation-Read-blue?style=for-the-badge&logo=readthedocs&logoColor=white)](https://vmware-samples.github.io/packer-examples-for-vsphere)

This repository provides a collection of opinionated examples that demonstrate how you can use both [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso` builder) to automate the creation of virtual machine images for VMware vSphere environments.

Whether you're a developer, systems administrator, or site reliability engineer, this project is designed to both help and inspire you in streamlining your infrastructure provisioning process and maintain consistency in your virtualization workflow.

All examples are provided in the HashiCorp Configuration Language ("HCL").

This project supports the following guest operating systems:

## Linux Distributions

| Operating System             | Version   |
| :---                         | :---      |
| VMware Photon OS             | 5         |
| VMware Photon OS             | 4         |
| Debian                       | 12        |
| Debian                       | 11        |
| Ubuntu Server                | 22.04 LTS |
| Ubuntu Server                | 20.04 LTS |
| Red Hat Enterprise Linux     | 9         |
| Red Hat Enterprise Linux     | 8         |
| Red Hat Enterprise Linux     | 7         |
| AlmaLinux OS                 | 9         |
| AlmaLinux OS                 | 8         |
| Rocky Linux                  | 9         |
| Rocky Linux                  | 8         |
| Oracle Linux                 | 9         |
| Oracle Linux                 | 8         |
| CentOS Stream                | 9         |
| CentOS Stream                | 8         |
| CentOS Linux                 | 7         |
| SUSE Linux Enterprise Server | 15        |

## Microsoft Windows

| Operating System         | Version | Editions                    | Experience       |
| :---                     | :---    | :---                        | :---             |
| Microsoft Windows Server | 2022    | Standard and Datacenter     | Core and Desktop |
| Microsoft Windows Server | 2019    | Standard and Datacenter     | Core and Desktop |
| Microsoft Windows        | 11 22H2 | Professional and Enterprise | -                |
| Microsoft Windows        | 10 22H2 | Professional and Enterprise | -                |

## Documentation

Please refer to the [documentation][documentation] for more detailed information about this project.

## Contributing

The project team welcomes contributions from the community. Please read our [Developer Certificate of Origin][vmware-cla-dco]. All contributions to this repository must be signed as described on that page. Your signature certifies that you wrote the patch or have the right to pass it on as an open-source patch.

For more detailed information, refer to the [contribution guidelines][contributing] to get started.

## Support

This project is **not supported** by VMware Support Services.

We welcome you to use the GitHub [issues][gh-issues] tracker to report bugs or suggest features and enhancements.

When filing an issue, please check existing open, or recently closed, issues to make sure someone else hasn't already
reported the issue.

Please try to include as much information as you can. Details like these are incredibly useful:

- A reproducible test case or series of steps.
- Any modifications you've made relevant to the bug.
- Anything unusual about your environment or deployment.

You can also start a discussion on the [discussions][gh-discussions] area to ask questions or share ideas.

## License

Copyright 2020-2023 VMware, Inc.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[//]: Links
[contributing]: CONTRIBUTING.md
[documentation]: https://vmware-samples.github.io/packer-examples-for-vsphere
[gh-issues]: https://github.com/vmware-samples/packer-examples-for-vsphere/issues
[gh-discussions]: https://github.com/vmware-samples/packer-examples-for-vsphere/discussions
[packer]: https://www.packer.io
[packer-plugin-vsphere]: https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso
[vmware-cla-dco]: https://cla.vmware.com/dco
