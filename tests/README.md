<!--
Copyright 2023 Broadcom. All rights reserved.
SPDX-License-Identifier: BSD-2
-->

# Custom Templates Tests

This directory contains tests for custom templates.

The tests are written in [Bats](https://bats-core.readthedocs.io/en/stable/).

## Overview

- Install `bats-core`
  - `brew install bats-core` on macOS
- Run `bats test` on each directory

## Folder Structure

- `templates/`: Template files
- `golden/`: Golden files
- `test`: Test script

## Reference

### Kickstart for Red Hat Enterprise Linux 8

- [Kickstart commands and options reference](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide#kickstart-commands-for-installation-program-configuration-and-flow-control_kickstart-commands-and-options-reference)
- [bootloader](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide#bootloader-required_kickstart-commands-for-handling-storage)
- [zerombr](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide#zerombr_kickstart-commands-for-handling-storage)
- [clearpart](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide#clearpart_kickstart-commands-for-handling-storage)
- [part](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide#part-or-partition_kickstart-commands-for-handling-storage)
- [volgroup](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide#volgroup_kickstart-commands-for-handling-storage)
- [logvol](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/system_design_guide/kickstart-commands-and-options-reference_system-design-guide#logvol_kickstart-commands-for-handling-storage)

### Preseed for Debian

- [DebianInstaller - Preseed](https://wiki.debian.org/DebianInstaller/Preseed)
- [DebianInstaller - Preseed Network](https://www.debian.org/releases/stable/amd64/apbs04.en.html#preseed-network)
- [DebianInstaller - Preseed Partman](https://www.debian.org/releases/stable/amd64/apbs04.en.html#preseed-partman)
- [DebianInstaller - Partman Source Code](https://salsa.debian.org/installer-team?filter=Partman)
- [DebianInstaller - Partman Auto Documentation](https://salsa.debian.org/installer-team/debian-installer/-/blob/master/doc/devel/partman-auto-recipe.txt)

### Autoinstall for Ubuntu Server >= 20.04

- [Automated Server installer config file reference](https://ubuntu.com/server/docs/install/autoinstall-reference)
- [Netplan Network](https://netplan.readthedocs.io/en/latest/netplan-yaml/)
- [Curtin Storage](https://curtin.readthedocs.io/en/latest/topics/storage.html)
- [disk](https://curtin.readthedocs.io/en/latest/topics/storage.html#disk-command)
- [partition](https://curtin.readthedocs.io/en/latest/topics/storage.html#partition-command)
- [format](https://curtin.readthedocs.io/en/latest/topics/storage.html#format-command)
- [mount](https://curtin.readthedocs.io/en/latest/topics/storage.html#mount-command)
- [lvm_volgroup](https://curtin.readthedocs.io/en/latest/topics/storage.html#lvm-volgroup-command)
- [lvm_partition](https://curtin.readthedocs.io/en/latest/topics/storage.html#lvm-partition-command)

### VMware Photon OS

- [Kickstart Configuration](https://github.com/vmware/photon-os-installer/blob/master/photon_installer/ks_config.txt)
