# AlmaLinux 8
install
eula --agreed
lang ${vm_guest_os_language}
keyboard ${vm_guest_os_keyboard}
timezone ${vm_guest_os_timezone}
rootpw --lock
user --name=${build_username} --iscrypted --password=${build_password_encrypted} --groups=wheel
cdrom
reboot --eject
bootloader --location=mbr --append="rhgb quiet crashkernel=auto"
zerombr
autopart
clearpart --all --initlabel
auth --passalgo=sha512 --useshadow
network --bootproto=dhcp
firewall --enabled --ssh
skipx
selinux --enforcing
firstboot --disable
services --enabled=NetworkManager,sshd
%post
yum install -y sudo open-vm-tools perl
echo "${build_username} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${build_username}
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
%end
%packages
@^server-product-environment
%end