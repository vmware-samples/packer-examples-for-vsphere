# Red Hat Enterprise Linux Server 7

cdrom
text
eula --agreed
keyboard ${vm_guest_os_keyboard}
lang ${vm_guest_os_language}
timezone ${vm_guest_os_timezone}
rootpw --lock
user --name=${build_username} --iscrypted --password=${build_password_encrypted} --groups=wheel
bootloader --location=mbr
zerombr
clearpart --all --initlabel
autopart --type=lvm
network --bootproto=dhcp
services --enabled=NetworkManager,sshd
firewall --enabled --ssh
skipx
reboot

%packages --ignoremissing --excludedocs
@core
-iwl*firmware
%end

%post
/usr/sbin/subscription-manager register --username ${rhsm_username} --password ${rhsm_password} --autosubscribe --force
/usr/sbin/subscription-manager repos --enable "rhel--optional-rpms" --enable "rhel--extras-rpms" --enable "rhel-ha-for-rhel-*-server-rpms"
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum makecache
yum install -y sudo open-vm-tools perl ansible
echo "${build_username} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${build_username}
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
%end