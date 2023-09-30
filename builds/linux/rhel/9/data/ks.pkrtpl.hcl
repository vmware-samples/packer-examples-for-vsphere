# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

# Red Hat Enterprise Linux Server 9

### Installs from the first attached CD-ROM/DVD on the system.
cdrom

### Performs the kickstart installation in text mode. 
### By default, kickstart installations are performed in graphical mode.
text

### Accepts the End User License Agreement.
eula --agreed

### Sets the language to use during installation and the default language to use on the installed system.
lang ${vm_guest_os_language}

### Sets the default keyboard type for the system.
keyboard ${vm_guest_os_keyboard}

### Configure network information for target system and activate network devices in the installer environment (optional)
### --onboot	  enable device at a boot time
### --device	  device to be activated and / or configured with the network command
### --bootproto	  method to obtain networking configuration for device (default dhcp)
### --noipv6	  disable IPv6 on this device
###
### network  --bootproto=static --ip=172.16.11.200 --netmask=255.255.255.0 --gateway=172.16.11.200 --nameserver=172.16.11.4 --hostname centos-linux-8
network --bootproto=dhcp

### Lock the root account.
rootpw --lock

### The selected profile will restrict root login.
### Add a user that can login and escalate privileges.
user --name=${build_username} --iscrypted --password=${build_password_encrypted} --groups=wheel

### Configure firewall settings for the system.
### --enabled	reject incoming connections that are not in response to outbound requests
### --ssh		allow sshd service through the firewall
firewall --enabled --ssh

### Sets up the authentication options for the system.
### The SSDD profile sets sha512 to hash passwords. Passwords are shadowed by default
### See the manual page for authselect-profile for a complete list of possible options.
authselect select sssd

### Sets the state of SELinux on the installed system.
### Defaults to enforcing.
selinux --enforcing

### Sets the system time zone.
timezone ${vm_guest_os_timezone}

### Sets how the boot loader should be installed.
bootloader --location=mbr

### Initialize any invalid partition tables found on disks.
zerombr

### Removes partitions from the system, prior to creation of new partitions. 
### By default, no partitions are removed.
### --linux	erases all Linux partitions.
### --initlabel Initializes a disk (or disks) by creating a default disk label for all disks in their respective architecture.
clearpart --all --initlabel

### Modify partition sizes for the virtual machine hardware.
### Create primary system partitions.
part /boot --fstype xfs --size=1024 --label=BOOTFS
part /boot/efi --fstype vfat --size=1024 --label=EFIFS
part pv.01 --size=100 --grow

### Create a logical volume management (LVM) group.
volgroup sysvg --pesize=4096 pv.01

### Modify logical volume sizes for the virtual machine hardware.
### Create logical volumes.
logvol swap --fstype swap --name=lv_swap --vgname=sysvg --size=1024 --label=SWAPFS
logvol / --fstype xfs --name=lv_root --vgname=sysvg --size=12288 --label=ROOTFS
logvol /home --fstype xfs --name=lv_home --vgname=sysvg --size=4096 --label=HOMEFS --fsoptions="nodev,nosuid"
logvol /opt --fstype xfs --name=lv_opt --vgname=sysvg --size=2048 --label=OPTFS --fsoptions="nodev"
logvol /tmp --fstype xfs --name=lv_tmp --vgname=sysvg --size=4096 --label=TMPFS --fsoptions="nodev,noexec,nosuid"
logvol /var --fstype xfs --name=lv_var --vgname=sysvg --size=4096 --label=VARFS --fsoptions="nodev"
logvol /var/log --fstype xfs --name=lv_log --vgname=sysvg --size=4096 --label=LOGFS --fsoptions="nodev,noexec,nosuid"
logvol /var/log/audit --fstype xfs --name=lv_audit --vgname=sysvg --size=4096 --label=AUDITFS --fsoptions="nodev,noexec,nosuid"

### Modifies the default set of services that will run under the default runlevel.
services --enabled=NetworkManager,sshd

### Do not configure X on the installed system.
skipx

### Packages selection.
%packages --ignoremissing --excludedocs
@core
-iwl*firmware
%end

### Post-installation commands.
%post
/usr/sbin/subscription-manager register --username ${rhsm_username} --password ${rhsm_password} --autosubscribe --force
/usr/sbin/subscription-manager repos --enable "codeready-builder-for-rhel-9-x86_64-rpms"
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf makecache
dnf install -y sudo open-vm-tools perl
echo "${build_username} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${build_username}
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
%end

### Reboot after the installation is complete.
### --eject attempt to eject the media before rebooting.
reboot --eject
