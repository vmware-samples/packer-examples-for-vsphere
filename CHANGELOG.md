# Release History

## v23.10

> Release Date: 2023-10-23

:boom: **Enhancement**:

- Adds VMware Photon OS 5.0 to the project. [GH-582](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/582)
- Adds Debian 12 to the project. [GH-584](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/584)
- Adds Oracle Linux 9 to the project. [GH-670](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/670)
- Adds Oracle Linux 8 to the project. [GH-670](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/670)
- Adds Windows 11 Enterprise to the project. [GH-688](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/688)
- Adds Windows 10 Enterprise to the project. [GH-688](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/688)
- Adds the option to configure the following target for builds: [GH-471](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/471)
  - a vSphere cluster with Distributed Resource Scheduling enabled. (Default)
  - an ESXi host in vSphere cluster with Distributed Resource Scheduling disabled. (Override)
  - an ESXi host not in a vSphere cluster. (Override)
- Adds a development container for Visual Studio Code. [GH-700](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/700)
- Adds an example `.gitlab.yml` file for GitLab CI/CD. [GH-675](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/675)
- Adds a `build-ci.tmpl` that can be used to create or update the `.gitlab-ci.yml` file using gomplate. [GH-675](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/675)
- Adds Packer logging settings to `set-envvars.sh`. [GH-705](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/705)
- Adds a debug option (`--debug` or `-d`) to`./build.sh` to enable debug logging for Packer. [GH-706](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/706)

:bug: **Bugfix**:

- Updates Debian 11 to include `build_password` in the `linux-debian.pkr.hcl` configuration file. [GH-653](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/653)
- Updates Debian 11 to ensure `/dev/sr1` is not mounted with use of the default `http` data source. No changes to the `disk` data source. [GH-686](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/686)

:sweat_drops: **Chore**:

- Updates `required_versions` for `packer` to `>= 1.9.4`. [GH-718](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/718)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.2.1`. [GH-564](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/564)
- Updates `required_plugins` for `ethanmdavidson/packer-plugin-git` to `>= 0.4.3`. [GH-717](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/717)
- Updates `required_plugins` for `rgl/packer-plugin-windows-update` to `>= 0.14.3`. [GH-565](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/565)
- Updates `required_versions` for `terraform` to `>= 1.6.0`. [GH-757](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/757)
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.5.1`. [GH-758](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/758)
- Updates Gomplate to `3.11.5`. [GH-559](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/559)
- Updates ansible-core to `2.15`. [GH-573](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/573)
- Updates Debian 11 to 11.8 release. [GH-738](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/738)
- Updates Ubuntu 22.04 to 22.04.3 release. [GH-720](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/720)
- Updates Ubuntu 20.04 to 20.04.6 release. [GH-566](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/566)
- Removes Ubuntu 18.04 from the project. [GH-578](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/578)
  
    On 31 May 2023, Ubuntu 18.04 LTS reached the end of standard support. See [Ubuntu Lifecycle](https://ubuntu.com/about/release-cycle) for more information.

- Updates Red Hat Enterprise Linux 9 to 9.2 release. [GH-576](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/576), [GH-587](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/587)
- Updates Red Hat Enterprise Linux 8 to 8.8 release. [GH-577](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/577)
- Updates Almalinux 9 to 9.2 release. [GH-569](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/569)
- Updates Almalinux 8 to 8.8 release. [GH-570](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/570)
- Updates Rocky Linux 9 to 9.2 release. [GH-571](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/571)
- Updates Rocky Linux 8 to 8.8 release. [GH-572](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/572)
- Updates CentOS Stream 9 to latest June 2023 release. [GH-567](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/567)
- Updates CentOS Stream 8 to latest June 2023 release. [GH-568](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/568)
- Updates SLES 15 to 15.5 release. [GH-740](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/740)
- Updates Windows Server 2022 to October 2023 (US English) release. [GH-744](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/744)
- Updates Windows 11 22H2 to October 2023 (US English) release. [GH-743](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/743)
- Updates Windows 10 22H2 to October 2023 (US English) release. [GH-742](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/742)

:wrench: **Refactor**:

- Removes the use of `iso_checksum` and `iso_checksum_type` as they are not needed since the ISOs are not being downloaded by the plugin and are expected to be present and already verified by the user after download. [GH-722](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/722)
- Removes the installation of Chocolatey from the Microsoft Windows guest operating system builds. [GH-586](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/586)

## v23.01

> Release Date: 2023-01-17

:boom: **Enhancement**:

- Adds support for disabling password expiration for the local administrator account on localized (non-English) Windows guest operating systems. [GH-334](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/334).
- Adds support for enabling Remote Desktop on localized (non-English) Windows guest operating systems. [GH-335](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/335).
- Adds support to allow SSH authentication with RSA keys for Ansible, if necessary. Adds a note related to OpenSSH >= 9.0 in the documentation. [GH-387](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/387).

:bug: **Bugfix**:

- Fixes missing privileges for the custom role in vSphere that effected the ability to build using disk-based deployment modes and Windows 11 22H2 with vTPM. [GH-295](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/295), [GH-339](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/339), [GH-340](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/340)
- Updates the URI in `user-data.pkrtpl.hcl` for Ubuntu 20.04 and 22.04 to remove the country code. This will help to ensure that GeoIP lookup works for all users. [GH-421](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/421)
- Updates the install commands for Red Hat Enterprise Linux 9 to use the correct EPEL repository version. [GH-440](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/440)

:page_facing_up: **Documenation**:

- Updates options to download a release or clone the project. [GH-385](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/385)
- Updates syntax to append RSA algorithm to `HostKeyAlgorithms +ssh-rsa` and`PubKeyAcceptedAlgorithms +ssh-rsa`. [GH-386](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/386)
- Updates the ssh-keygen example for generating the ECDSA public key to use a 521 bit key length. Valid key lengths are 256, 384, or 521. [GH-439](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/439)

:wrench: **Refactor**:

- Refactors builds to use the current Git branch / tag as the `build_version` local variable used for virtual machine image names and descriptions. [GH-385](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/385)
- Refactors Ansible roles to remove the `warn: false` args for ansible-core 2.14 compatibility. [GH-443](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/443)

:sweat_drops: **Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.5`. [GH-423](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/423)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.1.1`. [GH-416](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/416)
- Updates `required_versions` for `terraform` to `>= 1.3.7`. [GH-456](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/456)
- Updates `required_versions` for `hashicorp/hcp` to `>= 0.51.0`. [GH-408](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/408), [GH-409](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/396), [GH-410](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/410), [GH-411](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/411), [GH-412](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/412), [GH-413](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/413), [GH-414](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/414), [GH-415](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/415)
- Updates Gomplate to `3.11.3`. [GH-380](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/380), [GH-382](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/382)
- Updates Debian 11 to 11.6 release. [GH-432](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/432)
- Updates Red Hat Enterprise Linux 9 to 9.1 release. [GH-366](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/366)
- Updates Red Hat Enterprise Linux 8 to 8.7 release. [GH-365](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/365)
- Updates Rocky Linux 9 to 9.1 release. [GH-381](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/381)
- Updates Rocky Linux 8 to 8.7 release. [GH-368](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/368)
- Updates Almalinux 9 to 9.1 release. [GH-362](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/362)
- Updates Almalinux 8 to 8.7 release. [GH-361](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/361)
- Updates CentOS Stream 9 to latest December 2022 release. [GH-454](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/454)
- Updates CentOS Stream 8 to latest December 2022 release. [GH-453](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/453)
- Updates Windows Server 2022 to December 2022 (US English) release. [GH-452](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/452)
- Updates Windows Server 2019 to November 2022 (US English) release. [GH-373](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/373)
- Updates Windows 11 22H2 to December 2022 (US English) release. [GH-451](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/451)
- Updates Windows 10 22H2 to December 2022 (US English) release. [GH-450](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/450)
- Removes Ubuntu 20.04 LTS (`x86_64`) and macOS Big Sur (Intel) as tested operating systems for the Packer host. [GH-393](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/393)

:warning: **Breaking Change**:

- Removes support to use the `iso_url` variable to download the guest operating system `.iso` from a URL introduced in [GH-249](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/249) due to [GH-343](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/343). [GH-435](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/435)

## v22.09

> Release Date: 2022-09-28

:boom: **Enhancement**:

- Adds support for disk-based deployment mode for Debian 11. [GH-272](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/272).
- Adds support for disk-based deployment mode for SLES 15. [GH-276](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/276)

:bug: **Bugfix**:

- Fixes mismatches in source names for Windows Server when only builds for Standard or Datacenter are launched using `./build.sh`. [GH-281](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/281)

:sweat_drops: **Chore**:

- Updates Debian 11 to 11.5.0 release. [GH-273](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/273)
- Updates Ubuntu 22.04 to 22.04.1 release. [GH-274](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/274)
- Updates Ubuntu 20.04 to 20.04.5 release. [GH-275](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/275)
- Updates SLES 15 to 15.4 release. [GH-287](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/287)
- Updates Windows Server 2022 to September 2022 (US English) release. [GH-282](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/282)
- Updates Windows 11 to 22H2 September 2022 (US English) release. [GH-284](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/284)
- Updates Windows 10 to 21H2 September 2022 (US English) release. [GH-283](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/283)
- Updates `required_versions` for `terraform` to `>= 1.3.1`. [GH-292](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/292)

## v22.08

> Release Date: 2022-08-25

:boom: **Enhancement**:

- Adds Debian 11. [GH-195](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/195)
- Adds support for initial configuration and use of the HCP Packer Registry. [GH-236](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/236) and [GH-256](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/256)
- Adds support to use the `iso_url` variable to download the guest operating system `.iso` from a URL. [GH-249](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/249)

:warning: **Breaking Change**:

- Updates `vm_cpu_sockets` to `vm_cpu_count` for CPUs. The value of the sockets is determined by dividing the number of CPUs by the number of cores per socket defined. [GH-253](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/253)

:sweat_drops: **Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.3`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.8`.
- Updates `required_versions` for `terraform` to `>= 1.2.8`.
- Updates Windows Server 2022 to August 2022 (US English) release.
- Updates Windows 11 to August 2022 (US English) release.
- Updates Windows 10 to August 2022 (US English) release.

> **Note**
>
> - HTTP-based deployment only.

## v22.07

> Release Date: 2022-07-26

:boom: **Enhancement**:

- Adds Red Hat Enterprise Linux 9.
- Adds CentOS 9 Stream.
- Adds Rocky Linux 9.
- Adds AlmaLinux OS 9.
- Adds SUSE Linux Enterprise Server 15. [GH-227](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/227).
- Adds option for setting the number of video displays and the size for the video memory for both Windows 11 and 10, which is useful for virtual desktop use cases (_e.g._, Horizon). The ability to set the number of displays was added in `v1.0.6` of `packer-plugin-vsphere`.
- Adds a common option to export machine image artifacts (`.ovf`,`.vmdk`, and `.mf`) to an output path.
- Removes the default requirement for a trusted root authority certificate to be imported and trusted by each machine image build. This will allow project users to get started more quickly without a pre-requisite.

:wrench: **Refactor**:

- Refactors builds to use local variables for virtual machine image names and descriptions.
- Refactors builds to use local variables for ISO paths and checksums.
- Refactors builds to use local variables for manifest data and output path.

:sweat_drops: **Chore**:

- Updates vSphere to version 7.0.3D ([vCenter Server](https://docs.vmware.com/en/VMware-vSphere/7.0/rn/vsphere-vcenter-server-70u3d-release-notes.html) and [ESXi](https://docs.vmware.com/en/VMware-vSphere/7.0/rn/vsphere-esxi-70u3d-release-notes.html)) or higher to address a [known issue](https://kb.vmware.com/s/article/88255) with the Red Hat Enterprise Linux 9 with EFI firmware.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.6`.
- Updates `required_versions` for `terraform` to `>= 1.2.5`.
- Updates Rocky Linux 8 to use `other4xLinuxGuest64`.
- Updates Almalinux 8 to use `other4xLinuxGuest64`.
- Removes the deprecated CentOS 8 option; end-of-life as of December 31, 2021.
- Removes the deprecated Windows Server 2016 option; end-of-life as of January 11, 2022.

> **Note**
>
> - Supports 15.3 / 15 Service Pack 3.
> - HTTP-based deployment only. Disk-based deployment planned.

## v22.06

> Release Date: 2022-06-27

:sweat_drops: **Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.2`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.5`.
- Updates `required_versions` for `terraform` to `>= 1.2.3`.
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.2.0`.
- Updates vSphere to version 7.0.3 or higher.
- Updates Windows Server 2022 to June 2022 (US English) release.
- Updates Windows 11 to June 2022 (US English) release.
- Updates `vm_guest_os_type` for Windows Server 2022 guest ID to `windows2019srvNext_64Guest`.

## v22.05

> Release Date: 2022-05-31

:sweat_drops: **Chore**:

- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.4`.
- Updates `required_plugins` and `packer-plugin-windows-update` to `>= 0.14.1`.
- Updates `required_versions` for `terraform` to `>= 1.2.1`.
- Updates Red Hat Enterprise Linux 8 to 8.6 release.
- Updates Rocky Linux 8 to 8.6 release.
- Updates Almalinux 8 to 8.6 release.
- Updates CentOS Stream 8 checksum to latest release.
- Updates Windows Server 2022 to April 2022 (US English) release.
- Updates Windows 11 to May 2022 (US English) release.
- Updates requirements to include VMware Photon OS 4 as a tested operating system.
- Updates requirements to include Ubuntu 22.04 as a tested operating system.

## v22.04

> Release Date: 2022-04-28

:boom: **Enhancement**:

- Adds Ubuntu Server 22.04 LTS (GH-185)
- Adds an option to generate a custom build script. (GH-188)

🐞 **Bugfix**:

- Updates the Python interpreter for Ansible on AlmaLinux to use `/usr/libexec/platform-python`. (GH-182)
- Adds the use of `build_password` to the Linux distributions to ensure use of `set-envvars.sh` works as expected. (GH-197)
- Updates the SHA256 checksum for the CentOS 7 .iso `CentOS-7-x86_64-DVD-2009.iso`. (GH-201)

:sweat_drops: **Chore**:

- Updates the Windows Server 2022 February 2022 (US English) release. (GH-192)
- Updates the Ubuntu 20.04 LTS to 20.04.4 release. (GH-184)

## v22.03

> Release Date: 2022-03-17

:sweat_drops: **Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.0`.
- Updates `required_versions` for `terraform` to `>= 1.1.7`.
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.1.1`.

## v22.02

> Release Date: 2022-02-22

:boom: **Enhancement**:

- Updates the configuration of Linux machine images to use the Ansible roles instead of shell scripts.

:sweat_drops: **Chore**:

- Updates `required_versions` for `packer` to `>= 1.7.10`.
- Updates `required_versions` for `terraform` to `>= 1.1.5`.

## v22.01

> Release Date: 2022-01-21

:boom: **Enhancement**:

- Updates the `notes` to automatically include the Packer version and a `build_version`.
- Updates the naming for the machine image output and includes a `build_version` (_e.g._, `linux-photon-4-v22.01`).
- Updates all Microsoft Windows Server machine image builds to a default of 4096 MB of memory to increase performance during operating system patching.

:sweat_drops: **Chore**:

- Updates the structure of the subdirectories in `builds/`.
- Updates `required_versions` for `packer` to `>= 1.7.9`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.3`.
- Updates `required_versions` for `terraform` to `>= 1.1.4`.
- Updates Microsoft Windows 11 Professional to use virtual trusted platform module (vTPM) and removes experimental project support. vTPM is now supported by `packer-plugin-vsphere` to `>= 1.0.3`.
- Updates VMware Photon OS 4.0 to [Revision 2](https://github.com/vmware/photon/wiki/Downloading-Photon-OS).
- Adds configurable data source provisioning for VMware Photon OS 4.0. Revision 2 adds support for secondary devices with kickstart. Edit the `common_data_source` in `common.pkvars.hcl` from `http` to `disk`. The build will attach an on-demand `.iso` as the secondary CD-ROM for the kickstart. This is useful for environments that can not use HTTP-based kickstart.
- Adds a GitHub Action on pull requests to check code quality using linters.
- Updates all of project code to address issues found by the linter(s).

## v21.11

> Release Date: 2021-11-09

:boom: **Enhancement**:

- Adds support for `cloud-init` and the `[VMware]` data source introduced in cloud-init v21.3 for Ubuntu Server 20.04 LTS

  **Important Note**: Uncomment these lines in the script for Ubuntu 20.04 and guest customization will be performed by VMware Tools vs. `cloud-init`.

  ```shell
  # Uncomment below if guest customization will be performed by VMware Tools.
  # touch /etc/cloud/cloud.cfg.d/99.disable-network-config.cfg
  # echo "network: {config: disabled}" >> /etc/cloud/cloud.cfg.d/99.disable-network-config.cfg
  ```

- Adds custom disk partitioning for Ubuntu Server 20.04 LTS and Ubuntu Server 18.04 LTS
- Updates Ubuntu 18.04 LTS to `efi-secure`.
- Updates all certificates to the PEM-encoded `.cer` format.
- Adds example Terraform plans for deployment testing.
- Adds an Ansible playbook example to create a custom role in vSphere for Packer.

## v21.10.01

> Release Date: 2021-10-20

- Updates `LICENSE` and `NOTICE` to BSD-2.
- Updates `required_versions` for `packer` to `>= 1.7.7`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.2`.
- Updates Linux distributions to generate new host keys on first-boot.
- Adds option to use`floppy_content` included in `packer-plugin-vsphere` release`v1.0.2`. Ubuntu Server 18.04 LTS will toggle to use `floppy_content` from `http_content` when `common_data_source = "disk"` is enabled.
- Updates VMware Photon OS 4.0 to Revision 1.
- Adds Microsoft Windows 11 Professional as experimental until `vsphere-iso` supports vTPM.
- Adds support for `skip_import` Adds to `packer-plugin-vsphere` in `v1.0.2`. When set to `true` the virtual machine will not be imported into the content library. This is useful for testing/debugging. Defaults to false.

## v21.10

> Release Date: 2021-10-11

- Adds the `config.sh` to create `config/*.prkvars.hcl` (default) files from the examples in `builds/`.
- Adds the option for create >1 set of configuration set by passing an argument to `config.sh` (_e.g._ `config.sh config/us-west-1`) and the pass the configuration set to `build.sh` (_e.g._ `build.sh config/us-west-1`).
- Use of the content library is now optional by updating the `config/common.pkvars.hcl` settings to the following:

  ```hcl
  common_template_conversion     = true
  common_content_library_name    = null
  common_content_library_ovf     = false
  common_content_library_destroy = false
  ```

- Adds support for a SOCKS proxy by editing `config/proxy.pkvars.hcl`.
- Adds the ability to set the IP address to bind the HTTP server by editing the `common_http_ip` in `config/common.pkvars.hcl` from `null` to an IP address on the Packer host:

  ```hcl
  common_http_ip = "172.16.11.100"
  ```

- Add configurable data source provisioning for Linux images. By default, HTTP is used for the kickstart. By editing the `common_data_source` in `config/common.pkvars.hcl` from `http` to `disk` the build will use a disk-based method, such as a `.iso` as the secondary CD-ROM. This is useful for environments that can not communicate back to the Packer host's HTTP server.

  ```hcl
  common_data_source = "disk"
  ```

- Renames all certificates to `*.ctr.example` and `*.pb7.example`. Please add your own custom certificates to the directories per the README.md.
- Adds the ability for Packer to be run from any directory by including the use of `$(path.cwd)/`.
- Adds the `ansible` provisioner to Linux builds for base configuration using roles. More updates to follow.
- Adds information on least privilege service account using a custom role in vSphere.
- Adds a Terraform example for creation of the custom role in vSphere.
- Updates `manifests` to use `manifests/` and a JSON output based on the timestamp.
- Updates `manifests` to use include relevant data in the JSON output for the build.
- Adds RHEL 7 and CentoOS 7 back to the builds per requests.
- Refactors RHEL and RHEL derivative kickstarts templates.
- Adds Windows 10 Professional.
- Updates PhotonOS to `efi-secure`.
- Updates Ubuntu 20.04 LTS to `efi-secure`.
- Adds vendor provided filename and checksums to the build examples.
- Updates CONTRIBUTING.md with the contributor workflow.
- Adds headers to various scripts and files, as needed.
- Add public keys and specific Terraform files to `.gitignore`.
- Updates issue templates to use forms.
- Various bugfixes and code cleanliness.
- Bumped Packer to `>= 1.7.6`.
- Thanks to the new contributors: @sestegra, @metabsdm, and @gcblack!

## v21.09.1

> Release Date: 2021-09-16

- Refactors issue templates to use GitHub custom issue forms.
- Refactors all builds to pass the language, keyboard, and timezone to the configuration files.
- Updates the Rocky Linux build to use UEFI; however without secure boot.
- Updates the defaults in `common.pkvars.hcl` to use hardware version 19, which provides the best performance and latest features available in ESXi 7.0 U2. Refer to the VMware vSphere 7.0 [product documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-789C3913-1053-4850-A0F0-E29C3D32B6DA.html) if using a previous release
- Refactors all builds with input variable definitions separated into `variables.pkr.hcl`.
- Refactors all builds to use `<build>.auto.pkvars.hcl` for input variables the and `<build>.pkr.hcl` for the template configurations, with simplified names for `<build>`.
- Refactors all builds to use `${path.cwd}/output/` as the path for the manifest post-processor.
- Adds disclaimers and Updates descriptions in script files.
- Updates README.md.

## v21.09

> Release Date: 2021-09-07

- Adds support for Microsoft Windows Server 2022 machine image builds.
- Refactors configuration files to be generated using templates. Reduces the number of files and passes variables into the `.pkrtpl.hcl` content.
- Refactors builds for Linux distributions to use `http_content` instead of `http_directory` and `http_file`.
- Refactors builds for Microsoft Windows to use `cd_content` instead of `floppy_files`, which allows for use generated configuration files. A Packer compatible `.iso` command-line tool is required and noted in the [README.md](README.md#Requirements).
- Adds disclaimers and Updates descriptions in script files.
- Adds [NOTICE](NOTICE).
- Updates the `packer init` commands run in `build.sh`.
- Updates MAINTAINERS.md.
- Updates CONTRIBUTING.md.
- Updates README.md.

## v21.08

> Release Date: 2021-08-18

- Moves `vsphere.pkrvars.hcl` and `rhsm.pkrvars.hcl` to the `builds` directory.
- Isolates variables to simplify updates to common settings with `builds/common.pkrvars.hcl`.
- Refactors all build definitions to use variables and reduce any hard-coded settings.
- All machine image build definitions use the the recommended firmware based on the guest operating system and the minimum vSphere release supported by the repository. EFI Secure Boot is enabled for Red Hat Enterprise Linux 8, CentoOS Linux/Stream 8, AlmaLinux 8, and Microsoft Windows Server 2019/2016. BIOS is enabled Rocky Linux 8.
- Adds the manifest post-provisioner to machine image build definitions.
- Moves public keys to variables.
- Adds a user for Ansible to Linux machine images with authorized_keys. Uses `builds/ansible.pkrvars.hcl`. Password is randomized.
- Updates the Packer block to all builds with `required_versions >= "1.7.4"` for Packer.
- Adds the `required_plugins` to the Packer block for all builds to use the `vsphere` plugin `version = ">= 1.0.1"`.
- Updates the Packer block for Windows builds with `required_plugins` and `version = "0.14.0"` for the [Windows-Update plugin](https://github.com/rgl/packer-plugin-windows-update).
- All builds automatically run `packer init` to initialize required plugins before running a build with `build.sh`.
- Updates Microsoft Windows `autounattend.xml` files to use the attached VMware Tools `.iso` for PVSCSI driver.
- Simplified and reduced the script files used by provisioners.
- Patches the script for VNware Photon OS 4 due to an issue performing updates with `tdnf`.
- Patches the script for Ubuntu Server 20.04 LTS to remove cloud-init and remove all netplan configurations before GuestOS customization.
- Removes support for VMware Photon OS 3 machine image builds.
- Removes support for Red Hat Enterprise Linux 7 machine image builds.
- Removes support for CentOS Linux 7 machine image builds.
- Deprecates CentOS Linux 8. Removing in a future update. The CentOS Project [has shifted focus](https://www.redhat.com/en/blog/faq-centos-stream-updates) from CentOS Linux to CentOS Stream. CentOS Linux 8 EOL: `2021-12-31`.
- Deprecating Microsoft Windows Server 2016. Removing in a future update. Microsoft Windows Server 2016 EOL: `2022-01-22`.
- Adds MAINTAINERS.md.
- Updates README.md.

## v21.07

> Release Date: 2021-07-21

- Adds support for [VMware Photon OS](https://vmware.github.io/photon/) 4.
- Adds [support](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/18) for [AlmaLinux](http://almalinux.org) 8.
- Adds [support](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/13) for [Rocky Linux](https://rockylinux.org) 8.
- Adds [support](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/19) for [CentOS Stream](https://www.centos.org/centos-stream/) 8.
- Updates to `>=` vSphere 7.0 U2.
- Adds the Packer block to all builds with `required_versions >= "1.7.3"` for Packer.
- Adds the Packer block for Windows builds with `required_plugins` and `version = "0.12.0"` for the [Windows-Update plugin](https://github.com/rgl/packer-plugin-windows-update).

## v20.11

> Release Date: 2020-11-26

- Initial release.
