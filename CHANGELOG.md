# THE CHANGELOG

![Rainpole](icon.png)

## Release: `v21.09.1`
September 16, 2021
* Refactored issue templates to use GitHub custom issue forms.
* Refactored all builds to pass the language, keyboard, and timezone to the configuration files.
* Updated the Rocky Linux build to use UEFI; however without secure boot.
* Updated the defaults in `common.pkvars.hcl` to use hardware version 19, which provides the best performance and latest features available in ESXi 7.0 U2. Refer to the VMware vSphere 7.0 [product documentation](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-789C3913-1053-4850-A0F0-E29C3D32B6DA.html) if using a previous release
* Refactored all builds with input variable definitions separated into `variables.pkr.hcl`.
* Refactored all builds to use `<build>.auto.pkvars.hcl` for input variables the and `<build>.pkr.hcl` for the template configurations, with simplified names for `<build>`.
* Refactored all builds to use `${path.cwd}/output/` as the path for the manifest post-processor.
* Added disclaimers and updated descriptions in script files.
* Updated README.md.

## Release: `v21.09`
September 7, 2021
* Added support for Microsoft Windows Server 2022 machine image builds.
* Refactored configuration files to be generated using templates. Reduces the number of files and passes variables into the `.pkrtpl.hcl` content.
* Refactored builds for Linux distributions to use `http_content` instead of `http_directory` and `http_file`.
* Refactored builds for Microsoft Windows to use `cd_content` instead of `floppy_files`, which allows for use generated configuration files. A Packer compatible `.iso `command-line tool is required and noted in the [README.md](README.md#Requirements).
* Added disclaimers and updated descriptions in script files.
* Added [NOTICE](NOTICE).
* Updated the `packer init` commands run in `build.sh`.
* Updated MAINTAINERS.md.
* Updated CONTRIBUTING.md.
* Updated README.md.

## Release: `v21.08`
August 18, 2021
* Moved `vsphere.pkrvars.hcl` and `rhsm.pkrvars.hcl` to the `builds` directory.
* Isolated variables to simplify updates to common settings with `builds/common.pkrvars.hcl`.
* Refactored all build definitions to use variables and reduce any hard-coded settings.
* All machine image build definitions use the the recommended firmware based on the guest operating system and the minimum vSphere release supported by the repository. EFI Secure Boot is enabled for Red Hat Enterprise Linux 8, CentoOS Linux/Stream 8, AlmaLinux 8, and Microsoft Windows Server 2019/2016. BIOS is enabled Rocky Linux 8.
* Added the manifest post-provisioner to machine image build definitions.
* Moved public keys to variables.
* Added a user for Ansible to Linux machine images with authorized_keys. Uses `builds/ansible.pkrvars.hcl`. Password is randomized.
* Updated the Packer block to all builds with `required_versions >= "1.7.4"` for Packer.
* Added the `required_plugins` to the Packer block for all builds to use the `vsphere` plugin `version = ">= v1.0.1"`.
* Updated the Packer block for Windows builds with `required_plugins` and `version = "0.14.0"` for the [Windows-Update plugin](https://github.com/rgl/packer-plugin-windows-update).
* All builds automatically run `packer init` to initialize required plugins before running a build with `build.sh`.
* Updated Microsoft Windows `autounattend.xml` files to use the attached VMware Tools `.iso` for PVSCSI driver.
* Simplified and reduced the script files used by provisioners.
* Patched the script for VNware Photon OS 4 due to an issue performing updates with `tdnf`.
* Patched the script for Ubuntu Server 20.04 LTS to remove cloud-init and remove all netplan configurations before GuestOS customization.
* Removed support for VMware Photon OS 3 machine image builds.
* Removed support for Red Hat Enterprise Linux 7 machine image builds.
* Removed support for CentOS Linux 7 machine image builds.
* Deprecating CentOS Linux 8. Removing in a future update. The CentOS Project [has shifted focus](https://www.redhat.com/en/blog/faq-centos-stream-updates) from CentOS Linux to CentOS Stream. CentOS Linux 8 EOL: `2021-12-31`.
* Deprecating Microsoft Windows Server 2016. Removing in a future update. Microsoft Windows Server 2016 EOL: `2022-01-22`.
* Added MAINTAINERS.md.
* Updated README.md.

## Release: `v21.07`
July 21, 2021
* Added support for [VMware Photon OS](https://vmware.github.io/photon/) 4.
* Added [support](https://github.com/rainpole/packer-vsphere/issues/18) for [AlmaLinux](http://almalinux.org) 8.
* Added [support](https://github.com/rainpole/packer-vsphere/issues/13) for [Rocky Linux](https://rockylinux.org) 8.
* Added [support](https://github.com/rainpole/packer-vsphere/issues/19) for [CentOS Stream](https://www.centos.org/centos-stream/) 8.
* Updated to `>=` vSphere 7.0 U2.
* Added the Packer block to all builds with `required_versions >= "1.7.3"` for Packer.
* Added the Packer block for Windows builds with `required_plugins` and `version = "0.12.0"` for the [Windows-Update plugin](https://github.com/rgl/packer-plugin-windows-update).

## Release: `v20.11`
November 26, 2020
* Initial release.