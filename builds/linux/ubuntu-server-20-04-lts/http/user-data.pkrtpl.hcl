#cloud-config
autoinstall:
  version: 1
  early-commands:
    # Ensures that Packer does not connect too soon.
    - sudo systemctl stop ssh
  locale: ${vm_guest_os_language}
  keyboard:
    layout: ${vm_guest_os_keyboard}
  storage:
    layout:
      name: lvm
  identity:
    hostname: ubuntu-server
    username: ${build_username}
    password: ${build_password_encrypted}
  network:
    network:
      version: 2
      ethernets:
        ens33:
          dhcp4: true
  ssh:
    install-server: true
    allow-pw: true
  packages:
    - openssh-server
    - open-vm-tools
  user-data:
    disable_root: false
  late-commands:
    - 'sed -i "s/dhcp4: true/&\n      dhcp-identifier: mac/" /target/etc/netplan/00-installer-config.yaml'
    - echo '${build_username} ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/${build_username}
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/${build_username}
  timezone: ${vm_guest_os_timezone}