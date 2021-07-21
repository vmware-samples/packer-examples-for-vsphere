# THE CHANGELOG

![Rainpole](icon.png)

## 2021-07-21
* Updated scripts for Linux to generate host keys using `ssh-keygen` to ensure `sshd` will start on machine images.

## 2021-07-16
* Bumped support to >= vSphere 7.0 U2.
* Added the Packer block to all builds with `required_versions >= "1.7.3"` for Packer.
* Added the Packer block to Windows builds with `required_plugins` and `version = "0.12.0"` for the [Windows-Update Plug-in](https://github.com/rgl/packer-plugin-windows-update).
* Added support for [VMware Photon OS](https://vmware.github.io/photon/) 4.
* Added [support](https://github.com/rainpole/packer-vsphere/issues/13) for [Rocky Linux](https://rockylinux.org) 8. 

    > Note: GuestOS Customization is not supported in vSphere 7.0 U2.

* Added the option to initialize the Windows-Update Plug-in with **Option P** in `./build.sh`.
* Updated README.md regarding support for UEFI (`vm_firmware = "efi-secure"`) for Windows and RHEL as resolved in vSphere 7.0 Update 2. 

    > Note: Defaults remain BIOS (`vm_firmware = "bios"`).

* Various bug fixes and [README.md](README.md) updates

## 2020-12-08
* Updated examples to support vSphere datacenter object.

## 2020-11-26
* Initial release.
