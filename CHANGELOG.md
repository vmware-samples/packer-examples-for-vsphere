# Release History

## v0.22.0

> Release Date: 2025-02-11

**Bug Fix**:

- Reestablishes an empty `GRUB_CMDLINE_LINUX_DEFAULT` as `late_command` for Ubuntu.
  [#982](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/982)
- Resolves configuration and setup for Python and cloud-init in SUSE Enterprise Linux environments.
  Added a fallback mechanism for the Python interpreter, removing redundant tasks, and updating package installation and
  registration. [#991](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/991)

**Enhancement**:

- Adds confirmation before overwriting existing configuration files.
  [#987](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/987)
- Add CentOS Stream 10 to project.
  [#989](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/989)
- Refactors PowerShell script for installation of VMware Tools on Windows.
  [#1011](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/1011)

**Chore**:

- Updates Debian 11 to 11.11 release.
  [#10102](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/1012)
- Updates Debian Linux 12 to 12.9 release.
  [#1012](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/1012)
- Updates Ubuntu 22.04 LTS to 22.04.5 release.
  [#984](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/984)
- Updates Red Hat Enterprise Linux 9 to 9.5 release.
  [#984](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/984)
- Updates AlmaLinux 9 to 9.5 release.
  [#984](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/984)
- Updates Rocky Linux 9 to 9.5 release.
  [#984](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/984)
- Updates Oracle Linux 9 to 9.5 release.
  [#984](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/984)
- Updates Fedora Server to release 41.
  [#984](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/984)
- Updates `required_versions` for `packer` to `>= 1.12.0`.
  [#1013](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/1013)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.4.2`.
  [#986](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/986)
- Updates `required_versions` for `packer-plugin-ansible` to >= `1.1.2`.
  [#986](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/986)
- Updates `required_plugins` for `ethanmdavidson/packer-plugin-git` to `>= 0.6.3`.
  [#986](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/986)
- Updates `required_versions` for `terraform` to `>= 1.10.0`.
  [#986](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/986)
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.11.0`.
  [#1013](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/1013)
- Updates `required_versions` for `hashicorp/hcp` to `>= 0.102.0`.
  [#1013](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/1013)
- Updates Gomplate to `>= 4.3.0`.
  [#1013](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/1013)

## v0.21.0

> Release Date: 2024-09-26

**Bug Fix**:

- Updates to `debian.yml` file to remove the disable flag on cloud-init for Ubuntu 24.04 LTS version.
  [#940](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/940)
- Updates to `debian.yml` file to fix cloud-init install issue and additional package issue.
  [#944](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/944)
- Fixes issue when using `http` data source with a static IP address and the kickstart file could not
  be sent from Packer host.
  [#959](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/959)

**Enhancement**:

- Updates `pkr.hcl.example` and `variables.pkr.hcl` with defaults.
  [#944](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/944),
  [#945](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/945)

**Chore**:

- Removes Red Hat Enterprise Linux 7 from the project.
  [#944](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/944)

  On 30 June 2024, Red Hat Enterprise Linux 7 reached the end of life.

- Updates Rocky Linux 8.9 to 8.10 release.
  [#944](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/944)

- Updates `required_versions` for `packer` to `>= 1.11.0`.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.4.0`.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Updates `required_versions` for `terraform` to `>= 1.9.5`.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Updates `required_versions` for `terraform-provider-vsphere` to `>= 2.8.3`.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Updates `required_versions` for `hashicorp/hcp` to `>= 0.95.0`.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Updates `required_versions` for  `packer-plugin-ansible` to >= `1.1.1`.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Removes Centos Linux 7 from the project.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Updates Debian Linux 12.5 to 12.6 release.
  [#960](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/960)
- Updates Ubuntu 22.04 LTS to 22.04.1 LTS.
  [#965](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/965)
- Updates AlmaLinux Build pkr.hcl file change version from 8.9 to 8.10
  [#965](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/965)
- Updates Oracle Linux Build pkr.hcl file change version from 8.9 to 8.10
  [#965](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/965)

## v0.20.0

> Release Date: 2024-05-29

**Bug Fix**:

- Updates Windows Desktop Enterprise Edition to support the default use of evaluation mode.
  [#908](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/908)

  **Note**: Professional Edition does not support evaluation mode. Microsoft Evaluation Center only
  provides support for Enterprise Edition. Please see the
  [FAQ](https://vmware-samples.github.io/packer-examples-for-vsphere/getting-started/faq/) for
  additional details.

**Enhancement**:

- Adds a download script (`./download.sh`) and a JSON configuration file (`project.json`) to assist
  in the download of the guest operating systems.
  [#874](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/874),
  [#877](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/877)
- Refactored the build script (`./build.sh`) to provide the same experience as the download script.
  [#910](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/910)
- Adds Ubuntu Server 24.04 LTS to the project.
  [#891](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/891)
- Adds Fedora Server 40 Linux distribution to the project.
  [#xxx](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/xxx)
- Adds option to enable cloud-init on Debian 12.
  [#883](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/883)
- Adds option to enable cloud-init on Red Hat Enterprise Linux 9.
  [#888](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/888)
- Adds option to enable cloud-init on Red Hat Enterprise Linux 8.
  [#888](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/888)
- Adds option to enable cloud-init on Rocky Linux 9.
  [#895](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/895)
- Adds option to enable cloud-init on Rocky Linux 8.
  [#895](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/895)
- Adds option to enable cloud-init on CentOS Stream 8.
  [#897](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/897)
- Adds option to enable cloud-init on CentOS Stream 9.
  [#897](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/897)
- Adds option to enable cloud-init on AlmaLinux OS 8.
  [#898](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/898)
- Adds option to enable cloud-init on AlmaLinux OS 9.
  [#898](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/898)
- Adds option to enable cloud-init on Oracle Linux 8.
  [#899](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/899)
- Adds option to enable cloud-init on Oracle Linux 9.
  [#899](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/899)
- Adds option to enable cloud-init on VMware Photon OS 4.
  [#900](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/900)
- Adds option to enable cloud-init on VMware Photon OS 5.
  [#900](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/900)
- Adds option to enable cloud-init on SUSE Enterprise Linux 15.
  [#910](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/919)

**Chore**:

- Updates Red Hat Enterprise Linux 9 to 9.4 release.
  [#925](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/925)
- Updates Oracle Linux 9 to 9.4 release.
  [#927](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/927)
- Updates Almalinux 9 to 9.4 release.
  [#927](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/927)
- Updates Rocky Linux 9 to 9.4 release.
  [#927](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/927)
- Removes CentOS Stream 8 from the project.
- Updates Almalinux 8.9 to 8.10 release.
  [#956](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/956)
- Updates Oracle Linux 8.9 to 8.10.
  [#956](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/956)

  On 31 May 2024, CentOS Stream 8 reached the end of life.

- Removes Ubuntu Server 23.10 from the project; superseded by 24.04 LTS.
  [#891](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/891)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.3.0`.
- Updates `required_versions` for `terraform` to `>= 1.8.3`.
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.8.1`.
- Updates `required_versions` for `hashicorp/hcp` to `>= 0.89.0`.
- Update ansible-core version from 2.15 to 2.16.
  [#921](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/921)

## v0.19.1

> Release Date: 2024-04-15

**Bug Fix**:

- Removes the PowerShell provisioner for Windows 11 and 10 as it's not required after the transition
  to Ansible. [#878](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/878)

## v0.19.0

> Release Date: 2024-04-09

**Enhancement**:

- Adds templates and unit tests for managing custom network and storage configurations for Linux
  distributions. [#473](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/473),
  [#805](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/805)
- Adds additional configuration to install packages for Linux distributions.
  [#800](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/800)
- Adds option to set a specified number of remaining CD-ROMs for a machine images added in
  `packer-plugin-vsphere` v1.2.4.
  [#836](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/836)
- Adds use of evaluation versions for Windows Server 2025, 2022, and 2019 images, by default. Keys
  are still supported.
  [#844](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/844)
- Adds use of evaluation versions for Windows 11 and 10 images, by default. Keys are still
  supported. [#844](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/844)
- Adds Windows Server 2025 Insiders Preview.
  [#834](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/834)
- Adds Ansible integration for Windows Server 2025, 2022, and 2019 images.
  [#801](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/801)
- Adds Ansible integration for Windows 11 and 10 images.
  [#801](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/801)
- Adds option to enable a content library to source all guest operating system ISOs or use a
  datastore path. Defaults to `false`, disabled. Set `common_iso_content_library_enabled` to `true`
  to enable use of a content library for all guest operating system ISOs.
- Adds option to enable a content library for the placement of virtual machine images builds.
  Defaults to `true`, enabled. Set `common_content_library_enabled` to `false` to disable use of a
  content library for saving virtual machine image builds.

**Refactor**:

- Refactors the Ubuntu builds **not** to use cloud-init, by default.
  [##](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/#) Set
  `vm_guest_os_cloudinit` to `true` to enable cloud-init on the machine image.

**Chore**:

- Updates `required_versions` for `packer` to `>= 1.11.0`.
  [#828](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/828)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.2.7`.
  [#824](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/824),
  [#871](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/871),
  [#873](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/873)
- Updates `required_plugins` for `ethanmdavidson/packer-plugin-git` to `>= 0.6.2`.
  [#868](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/868)
- Updates `required_versions` for `terraform` to `>= 1.7.1`.
  [#829](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/829)
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.7.0`.
  [#866](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/866)
- Updates `required_versions` for `hashicorp/hcp` to `>= 0.84.1`.
  [#867](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/867)
- Updates Gomplate to `3.11.7`.
  [#825](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/825)
- Updates Red Hat Enterprise Linux 9 to 9.3 release.
  [#819](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/819)
- Updates Red Hat Enterprise Linux 8 to 8.9 release.
  [#818](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/818)
- Updates AlmaLinux 9 to 9.3 release.
  [#817](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/817)
- Updates AlmaLinux 8 to 8.9 release.
  [#817](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/817)
- Updates Rocky Linux 9 to 9.3 release.
  [#823](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/82)
- Updates Rocky Linux 8 to 8.9 release.
  [#822](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/822)
- Updates Oracle Linux 9 to 9.3 release.
  [#821](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/821)
- Updates Oracle Linux 8 to 8.9 release.
  [#820](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/820)
- Updates Debian 12 to 12.5 release.
  [#865](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/865)
- Updates Debian 11 to 11.9 release.
  [#864](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/864)
- Updates Ubuntu 22.04 to 22.04.4 release.
  [#863](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/863)
- Updates AlmaLinux to upgrade the `almalinux-release` package during the build.
  [#](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/)

## v0.18.0

> Release Date: 2023-11-28

**Enhancement**:

- Adds Ubuntu Server 23.10 to the project.
  [#769](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/769)
- Adds support for setting additional options. (`vsphere_resource_pool`,
  `set_host_for_datastore_uploads`, and `ip_settle_timeout`).
  [#771](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/771)

**Chore**:

- Updates `ansible/ansible.cfg` to use `scp_extra_args = "-O"` by default. See the Ansible
  [documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ssh_connection.html#parameter-scp_if_ssh).
  [#767](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/767)
- Removes unused files from `ansible/`.
  [#768](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/768)
- Removes redundant Ansible task for users.
  [#770](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/770)

## v0.17.0

> Release Date: 2023-10-23

**Enhancement**:

- Adds VMware Photon OS 5.0 to the project.
  [#582](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/582)
- Adds Debian 12 to the project.
  [#584](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/584)
- Adds Oracle Linux 9 to the project.
  [#670](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/670)
- Adds Oracle Linux 8 to the project.
  [#670](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/670)
- Adds Windows 11 Enterprise to the project.
  [#688](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/688)
- Adds Windows 10 Enterprise to the project.
  [#688](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/688)
- Adds the option to configure the following target for builds:
  [#471](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/471)
  - a vSphere cluster with Distributed Resource Scheduling enabled. (Default)
  - an ESXi host in vSphere cluster with Distributed Resource Scheduling disabled. (Override)
  - an ESXi host not in a vSphere cluster. (Override)
- Adds a development container for Visual Studio Code.
  [#700](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/700)
- Adds an example `.gitlab.yml` file for GitLab CI/CD.
  [#675](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/675)
- Adds a `build-ci.tmpl` that can be used to create or update the `.gitlab-ci.yml` file using
  gomplate. [#675](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/675)
- Adds Packer logging settings to `set-envvars.sh`.
  [#705](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/705)
- Adds a debug option (`--debug` or `-d`) to`./build.sh` to enable debug logging for Packer.
  [#706](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/706)

**Bugfix**:

- Updates Debian 11 to include `build_password` in the `linux-debian.pkr.hcl` configuration file.
  [#653](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/653)
- Updates Debian 11 to ensure `/dev/sr1` is not mounted with use of the default `http` data source.
  No changes to the `disk` data source.
  [#686](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/686)

**Chore**:

- Updates `required_versions` for `packer` to `>= 1.9.4`.
  [#718](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/718)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.2.1`.
  [#564](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/564)
- Updates `required_plugins` for `ethanmdavidson/packer-plugin-git` to `>= 0.4.3`.
  [#717](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/717)
- Updates `required_plugins` for `rgl/packer-plugin-windows-update` to `>= 0.14.3`.
  [#565](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/565)
- Updates `required_versions` for `terraform` to `>= 1.6.0`.
  [#757](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/757)
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.5.1`.
  [#758](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/758)
- Updates Gomplate to `3.11.5`.
  [#559](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/559)
- Updates ansible-core to `2.15`.
  [#573](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/573)
- Updates Debian 11 to 11.8 release.
  [#738](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/738)
- Updates Ubuntu 22.04 to 22.04.3 release.
  [#720](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/720)
- Updates Ubuntu 20.04 to 20.04.6 release.
  [#566](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/566)
- Removes Ubuntu 18.04 from the project.
  [#578](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/578)

  On 31 May 2023, Ubuntu 18.04 LTS reached the end of standard support. See
  [Ubuntu Lifecycle](https://ubuntu.com/about/release-cycle) for more information.

- Updates Red Hat Enterprise Linux 9 to 9.2 release.
  [#576](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/576),
  [#587](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/587)
- Updates Red Hat Enterprise Linux 8 to 8.8 release.
  [#577](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/577)
- Updates Almalinux 9 to 9.2 release.
  [#569](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/569)
- Updates Almalinux 8 to 8.8 release.
  [#570](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/570)
- Updates Rocky Linux 9 to 9.2 release.
  [#571](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/571)
- Updates Rocky Linux 8 to 8.8 release.
  [#572](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/572)
- Updates CentOS Stream 9 to latest June 2023 release.
  [#567](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/567)
- Updates CentOS Stream 8 to latest June 2023 release.
  [#568](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/568)
- Updates SLES 15 to 15.5 release.
  [#740](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/740)
- Updates Windows Server 2022 to October 2023 (US English) release.
  [#744](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/744)
- Updates Windows 11 22H2 to October 2023 (US English) release.
  [#743](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/743)
- Updates Windows 10 22H2 to October 2023 (US English) release.
  [#742](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/742)

**Refactor**:

- Removes the use of `iso_checksum` and `iso_checksum_type` as they are not needed since the ISOs
  are not being downloaded by the plugin and are expected to be present and already verified by the
  user after download.
  [#722](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/722)
- Removes the installation of Chocolatey from the Microsoft Windows guest operating system builds.
  [#586](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/586)

## v0.16.0

> Release Date: 2023-01-17

**Enhancement**:

- Adds support for disabling password expiration for the local administrator account on localized
  (non-English) Windows guest operating systems.
  [#334](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/334).
- Adds support for enabling Remote Desktop on localized (non-English) Windows guest operating
  systems. [#335](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/335).
- Adds support to allow SSH authentication with RSA keys for Ansible, if necessary. Adds a note
  related to OpenSSH >= 9.0 in the documentation.
  [#387](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/387).

**Bugfix**:

- Fixes missing privileges for the custom role in vSphere that effected the ability to build using
  disk-based deployment modes and Windows 11 22H2 with vTPM.
  [#295](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/295),
  [#339](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/339),
  [#340](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/340)
- Updates the URI in `user-data.pkrtpl.hcl` for Ubuntu 20.04 and 22.04 to remove the country code.
  This will help to ensure that GeoIP lookup works for all users.
  [#421](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/421)
- Updates the install commands for Red Hat Enterprise Linux 9 to use the correct EPEL repository
  version. [#440](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/440)

**Documentation**:

- Updates options to download a release or clone the project.
  [#385](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/385)
- Updates syntax to append RSA algorithm to `HostKeyAlgorithms +ssh-rsa`
  and`PubKeyAcceptedAlgorithms +ssh-rsa`.
  [#386](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/386)
- Updates the ssh-keygen example for generating the ECDSA public key to use a 521 bit key length.
  Valid key lengths are 256, 384, or 521.
  [#439](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/439)

**Refactor**:

- Refactors builds to use the current Git branch / tag as the `build_version` local variable used
  for virtual machine image names and descriptions.
  [#385](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/385)
- Refactors Ansible roles to remove the `warn: false` args for ansible-core 2.14 compatibility.
  [#443](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/443)

**Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.5`.
  [#423](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/423)
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.1.1`.
  [#416](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/416)
- Updates `required_versions` for `terraform` to `>= 1.3.7`.
  [#456](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/456)
- Updates `required_versions` for `hashicorp/hcp` to `>= 0.51.0`.
  [#408](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/408),
  [#409](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/396),
  [#410](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/410),
  [#411](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/411),
  [#412](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/412),
  [#413](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/413),
  [#414](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/414),
  [#415](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/415)
- Updates Gomplate to `3.11.3`.
  [#380](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/380),
  [#382](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/382)
- Updates Debian 11 to 11.6 release.
  [#432](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/432)
- Updates Red Hat Enterprise Linux 9 to 9.1 release.
  [#366](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/366)
- Updates Red Hat Enterprise Linux 8 to 8.7 release.
  [#365](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/365)
- Updates Rocky Linux 9 to 9.1 release.
  [#381](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/381)
- Updates Rocky Linux 8 to 8.7 release.
  [#368](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/368)
- Updates Almalinux 9 to 9.1 release.
  [#362](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/362)
- Updates Almalinux 8 to 8.7 release.
  [#361](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/361)
- Updates CentOS Stream 9 to latest December 2022 release.
  [#454](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/454)
- Updates CentOS Stream 8 to latest December 2022 release.
  [#453](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/453)
- Updates Windows Server 2022 to December 2022 (US English) release.
  [#452](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/452)
- Updates Windows Server 2019 to November 2022 (US English) release.
  [#373](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/373)
- Updates Windows 11 22H2 to December 2022 (US English) release.
  [#451](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/451)
- Updates Windows 10 22H2 to December 2022 (US English) release.
  [#450](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/450)
- Removes Ubuntu 20.04 LTS (`x86_64`) and macOS
- Big Sur (Intel) as tested operating systems for the
  Packer host. [#393](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/393)

**Breaking Change**:

- Removes support to use the `iso_url` variable to download the guest operating system `.iso` from a
  URL introduced in [#249](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/249)
  due to [#343](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/343).
  [#435](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/435)

## v0.15.0

> Release Date: 2022-09-28

**Enhancement**:

- Adds support for disk-based deployment mode for Debian 11.
  [#272](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/272).
- Adds support for disk-based deployment mode for SLES 15.
  [#276](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/276)

**Bugfix**:

- Fixes mismatches in source names for Windows Server when only builds for Standard or Datacenter
  are launched using `./build.sh`.
  [#281](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/281)

**Chore**:

- Updates Debian 11 to 11.5.0 release.
  [#273](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/273)
- Updates Ubuntu 22.04 to 22.04.1 release.
  [#274](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/274)
- Updates Ubuntu 20.04 to 20.04.5 release.
  [#275](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/275)
- Updates SLES 15 to 15.4 release.
  [#287](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/287)
- Updates Windows Server 2022 to September 2022 (US English) release.
  [#282](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/282)
- Updates Windows 11 to 22H2 September 2022 (US English) release.
  [#284](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/284)
- Updates Windows 10 to 21H2 September 2022 (US English) release.
  [#283](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/283)
- Updates `required_versions` for `terraform` to `>= 1.3.1`.
  [#292](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/292)

## v0.14.0

> Release Date: 2022-08-25

**Enhancement**:

- Adds Debian 11. [#195](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/195)
- Adds support for initial configuration and use of the HCP Packer Registry.
  [#236](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/236) and
  [#256](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/256)
- Adds support to use the `iso_url` variable to download the guest operating system `.iso` from a
  URL. [#249](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/249)

**Breaking Change**:

- Updates `vm_cpu_sockets` to `vm_cpu_count` for CPUs. The value of the sockets is determined by
  dividing the number of CPUs by the number of cores per socket defined.
  [#253](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/253)

**Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.3`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.8`.
- Updates `required_versions` for `terraform` to `>= 1.2.8`.
- Updates Windows Server 2022 to August 2022 (US English) release.
- Updates Windows 11 to August 2022 (US English) release.
- Updates Windows 10 to August 2022 (US English) release.

> **Note**
>
> - HTTP-based deployment only.

## v0.13.0

> Release Date: 2022-07-26

**Enhancement**:

- Adds Red Hat Enterprise Linux 9.
- Adds CentOS 9 Stream.
- Adds Rocky Linux 9.
- Adds AlmaLinux OS 9.
- Adds SUSE Linux Enterprise Server 15.
  [#227](https://github.com/vmware-samples/packer-examples-for-vsphere/pull/227).
- Adds option for setting the number of video displays and the size for the video memory for both
  Windows 11 and 10, which is useful for virtual desktop use cases (_e.g._, Horizon). The ability to
  set the number of displays was added in `v1.0.6` of `packer-plugin-vsphere`.
- Adds a common option to export machine image artifacts (`.ovf`,`.vmdk`, and `.mf`) to an output
  path.
- Removes the default requirement for a trusted root authority certificate to be imported and
  trusted by each machine image build. This will allow project users to get started more quickly
  without a pre-requisite.

**Refactor**:

- Refactors builds to use local variables for virtual machine image names and descriptions.
- Refactors builds to use local variables for ISO paths and checksums.
- Refactors builds to use local variables for manifest data and output path.

**Chore**:

- Updates vSphere to version 7.0.3D or higher to address a
  [known issue](https://kb.vmware.com/s/article/88255) with the Red Hat Enterprise Linux 9 with EFI
  firmware.
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

## v0.12.0

> Release Date: 2022-06-27

**Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.2`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.5`.
- Updates `required_versions` for `terraform` to `>= 1.2.3`.
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.2.0`.
- Updates vSphere to version 7.0.3 or higher.
- Updates Windows Server 2022 to June 2022 (US English) release.
- Updates Windows 11 to June 2022 (US English) release.
- Updates `vm_guest_os_type` for Windows Server 2022 guest ID to `windows2019srvNext_64Guest`.

## v0.11.0

> Release Date: 2022-05-31

**Chore**:

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

## v0.10.0

> Release Date: 2022-04-28

**Enhancement**:

- Adds Ubuntu Server 22.04 LTS (#185)
- Adds an option to generate a custom build script. (#188)

🐞 **Bugfix**:

- Updates the Python interpreter for Ansible on AlmaLinux to use `/usr/libexec/platform-python`.
  (#182)
- Adds the use of `build_password` to the Linux distributions to ensure use of `set-envvars.sh`
  works as expected. (#197)
- Updates the SHA256 checksum for the CentOS 7 .iso `CentOS-7-x86_64-DVD-2009.iso`. (#201)

**Chore**:

- Updates the Windows Server 2022 February 2022 (US English) release. (#192)
- Updates the Ubuntu 20.04 LTS to 20.04.4 release. (#184)

## v0.9.0

> Release Date: 2022-03-17

**Chore**:

- Updates `required_versions` for `packer` to `>= 1.8.0`.
- Updates `required_versions` for `terraform` to `>= 1.1.7`.
- Updates `required_versions` for `hashicorp/vsphere` to `>= 2.1.1`.

## v0.8.0

> Release Date: 2022-02-22

**Enhancement**:

- Updates the configuration of Linux machine images to use the Ansible roles instead of shell
  scripts.

**Chore**:

- Updates `required_versions` for `packer` to `>= 1.7.10`.
- Updates `required_versions` for `terraform` to `>= 1.1.5`.

## v0.7.0

> Release Date: 2022-01-21

**Enhancement**:

- Updates the `notes` to automatically include the Packer version and a `build_version`.
- Updates the naming for the machine image output and includes a `build_version` (_e.g._,
  `linux-photon-4-v22.01`).
- Updates all Microsoft Windows Server machine image builds to a default of 4096 MB of memory to
  increase performance during operating system patching.

**Chore**:

- Updates the structure of the subdirectories in `builds/`.
- Updates `required_versions` for `packer` to `>= 1.7.9`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.3`.
- Updates `required_versions` for `terraform` to `>= 1.1.4`.
- Updates Microsoft Windows 11 Professional to use virtual trusted platform module (vTPM) and
  removes experimental project support. vTPM is now supported by `packer-plugin-vsphere` to
  `>= 1.0.3`.
- Updates VMware Photon OS 4.0 to
  [Revision 2](https://github.com/vmware/photon/wiki/Downloading-Photon-OS).
- Adds configurable data source provisioning for VMware Photon OS 4.0. Revision 2 adds support for
  secondary devices with kickstart. Edit the `common_data_source` in `common.pkvars.hcl` from `http`
  to `disk`. The build will attach an on-demand `.iso` as the secondary CD-ROM for the kickstart.
  This is useful for environments that can not use HTTP-based kickstart.
- Adds a GitHub Action on pull requests to check code quality using linters.
- Updates all of project code to address issues found by the linter(s).

## v0.6.0

> Release Date: 2021-11-09

**Enhancement**:

- Adds support for `cloud-init` and the `[VMware]` data source introduced in cloud-init v21.3 for
  Ubuntu Server 20.04 LTS

  **Important Note**: Uncomment these lines in the script for Ubuntu 20.04 and guest customization
  will be performed by VMware Tools vs. `cloud-init`.

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

## v0.5.1

> Release Date: 2021-10-20

- Updates `LICENSE` and `NOTICE` to BSD-2.
- Updates `required_versions` for `packer` to `>= 1.7.7`.
- Updates `required_plugins` for `packer-plugin-vsphere` to `>= 1.0.2`.
- Updates Linux distributions to generate new host keys on first-boot.
- Adds option to use`floppy_content` included in `packer-plugin-vsphere` release`v1.0.2`. Ubuntu
  Server 18.04 LTS will toggle to use `floppy_content` from `http_content` when
  `common_data_source = "disk"` is enabled.
- Updates VMware Photon OS 4.0 to Revision 1.
- Adds Microsoft Windows 11 Professional as experimental until `vsphere-iso` supports vTPM.
- Adds support for `skip_import` Adds to `packer-plugin-vsphere` in `v1.0.2`. When set to `true` the
  virtual machine will not be imported into the content library. This is useful for
  testing/debugging. Defaults to false.

## v0.5.0

> Release Date: 2021-10-11

- Adds the `config.sh` to create `config/*.prkvars.hcl` (default) files from the examples in
  `builds/`.
- Adds the option for create >1 set of configuration set by passing an argument to `config.sh`
  (_e.g._ `config.sh config/us-west-1`) and the pass the configuration set to `build.sh` (_e.g._
  `build.sh config/us-west-1`).
- Use of the content library is now optional by updating the `config/common.pkvars.hcl` settings to
  the following:

  ```hcl
  common_template_conversion     = true
  common_content_library    = null
  common_content_library_ovf     = false
  common_content_library_destroy = false
  ```

- Adds support for a SOCKS proxy by editing `config/proxy.pkvars.hcl`.
- Adds the ability to set the IP address to bind the HTTP server by editing the `common_http_ip` in
  `config/common.pkvars.hcl` from `null` to an IP address on the Packer host:

  ```hcl
  common_http_ip = "172.16.11.100"
  ```

- Add configurable data source provisioning for Linux images. By default, HTTP is used for the
  kickstart. By editing the `common_data_source` in `config/common.pkvars.hcl` from `http` to `disk`
  the build will use a disk-based method, such as a `.iso` as the secondary CD-ROM. This is useful
  for environments that can not communicate back to the Packer host's HTTP server.

  ```hcl
  common_data_source = "disk"
  ```

- Renames all certificates to `*.ctr.example` and `*.pb7.example`. Please add your own custom
  certificates to the directories per the README.md.
- Adds the ability for Packer to be run from any directory by including the use of `$(path.cwd)/`.
- Adds the `ansible` provisioner to Linux builds for base configuration using roles. More updates to
  follow.
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

## v0.4.1

> Release Date: 2021-09-16

- Refactors issue templates to use GitHub custom issue forms.
- Refactors all builds to pass the language, keyboard, and timezone to the configuration files.
- Updates the Rocky Linux build to use UEFI; however without secure boot.
- Updates the defaults in `common.pkvars.hcl` to use hardware version 19, which provides the best
  performance and latest features available in ESXi 7.0 U2.
  if using a previous release
- Refactors all builds with input variable definitions separated into `variables.pkr.hcl`.
- Refactors all builds to use `<build>.auto.pkvars.hcl` for input variables the and
  `<build>.pkr.hcl` for the template configurations, with simplified names for `<build>`.
- Refactors all builds to use `${path.cwd}/output/` as the path for the manifest post-processor.
- Adds disclaimers and Updates descriptions in script files.
- Updates README.md.

## v0.4.0

> Release Date: 2021-09-07

- Adds support for Microsoft Windows Server 2022 machine image builds.
- Refactors configuration files to be generated using templates. Reduces the number of files and
  passes variables into the `.pkrtpl.hcl` content.
- Refactors builds for Linux distributions to use `http_content` instead of `http_directory` and
  `http_file`.
- Refactors builds for Microsoft Windows to use `cd_content` instead of `floppy_files`, which allows
  for use generated configuration files. A Packer compatible `.iso` command-line tool is required.
- Adds disclaimers and Updates descriptions in script files.
- Adds [NOTICE](NOTICE).
- Updates the `packer init` commands run in `build.sh`.
- Updates MAINTAINERS.md.
- Updates CONTRIBUTING.md.
- Updates README.md.

## v0.3.0

> Release Date: 2021-08-18

- Moves `vsphere.pkrvars.hcl` and `rhsm.pkrvars.hcl` to the `builds` directory.
- Isolates variables to simplify updates to common settings with `builds/common.pkrvars.hcl`.
- Refactors all build definitions to use variables and reduce any hard-coded settings.
- All machine image build definitions use the the recommended firmware based on the guest operating
  system and the minimum vSphere release supported by the repository. EFI Secure Boot is enabled for
  Red Hat Enterprise Linux 8, CentoOS Linux/Stream 8, AlmaLinux 8, and Microsoft Windows Server
  2019/2016. BIOS is enabled Rocky Linux 8.
- Adds the manifest post-provisioner to machine image build definitions.
- Moves public keys to variables.
- Adds a user for Ansible to Linux machine images with authorized_keys. Uses
  `builds/ansible.pkrvars.hcl`. Password is randomized.
- Updates the Packer block to all builds with `required_versions >= "1.7.4"` for Packer.
- Adds the `required_plugins` to the Packer block for all builds to use the `vsphere` plugin
  `version = ">= 1.0.1"`.
- Updates the Packer block for Windows builds with `required_plugins` and `version = "0.14.0"` for
  the [Windows-Update plugin](https://github.com/rgl/packer-plugin-windows-update).
- All builds automatically run `packer init` to initialize required plugins before running a build
  with `build.sh`.
- Updates Microsoft Windows `autounattend.xml` files to use the attached VMware Tools `.iso` for
  PVSCSI driver.
- Simplified and reduced the script files used by provisioners.
- Patches the script for VMware Photon OS 4 due to an issue performing updates with `tdnf`.
- Patches the script for Ubuntu Server 20.04 LTS to remove cloud-init and remove all netplan
  configurations before GuestOS customization.
- Removes support for VMware Photon OS 3 machine image builds.
- Removes support for Red Hat Enterprise Linux 7 machine image builds.
- Removes support for CentOS Linux 7 machine image builds.
- Deprecates CentOS Linux 8. Removing in a future update. The CentOS Project
  [has shifted focus](https://www.redhat.com/en/blog/faq-centos-stream-updates) from CentOS Linux to
  CentOS Stream. CentOS Linux 8 EOL: `2021-12-31`.
- Deprecating Microsoft Windows Server 2016. Removing in a future update. Microsoft Windows Server
  2016 EOL: `2022-01-22`.
- Adds MAINTAINERS.md.
- Updates README.md.

## v0.2.0

> Release Date: 2021-07-21

- Adds support for [VMware Photon OS](https://vmware.github.io/photon/) 4.
- Adds [support](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/18) for
  [AlmaLinux](http://almalinux.org) 8.
- Adds [support](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/13) for
  [Rocky Linux](https://rockylinux.org) 8.
- Adds [support](https://github.com/vmware-samples/packer-examples-for-vsphere/issues/19) for
  [CentOS Stream](https://www.centos.org/centos-stream/) 8.
- Updates to `>=` vSphere 7.0 U2.
- Adds the Packer block to all builds with `required_versions >= "1.7.3"` for Packer.
- Adds the Packer block for Windows builds with `required_plugins` and `version = "0.12.0"` for the
  [Windows-Update plugin](https://github.com/rgl/packer-plugin-windows-update).

## v0.1.0

> Release Date: 2020-11-26

- Initial release.
