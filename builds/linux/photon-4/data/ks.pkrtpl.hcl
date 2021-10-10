{
    "hostname": "photon",
    "password":
        {
            "crypted": true,
            "text": "${build_password_encrypted}"
        },
    "disk": "/dev/sda",
    "partitions": [
        {"mountpoint": "/", "size": 0, "filesystem": "ext4"},
        {"mountpoint": "/boot", "size": 128, "filesystem": "ext4"},
        {"mountpoint": "/root", "size": 128, "filesystem": "ext4"},
        {"size": 128, "filesystem": "swap"}
    ],
    "bootmode": "efi",
    "packagelist_file": "packages_minimal.json",
    "additional_packages": [
        "sudo",
        "vim",
        "cloud-utils",
        "ansible"
    ],
    "postinstall": [
        "#!/bin/sh",
        "useradd -m -p '${build_password_encrypted}' -s /bin/bash ${build_username}",
        "usermod -aG sudo ${build_username}",
        "echo \"${build_username} ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers.d/${build_username}",
        "chage -I -1 -m 0 -M 99999 -E -1 root",
        "chage -I -1 -m 0 -M 99999 -E -1 ${build_username}",
        "iptables -A INPUT -p tcp --dport 22 -j ACCEPT",
        "iptables -A INPUT -p ICMP -j ACCEPT",
        "iptables -A OUTPUT -p ICMP -j ACCEPT",
        "iptables-save > /etc/systemd/scripts/ip4save",
        "systemctl restart iptables",
        "sed -i 's/.*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config",
        "sed -i 's/.*MaxAuthTries.*/MaxAuthTries 10/g' /etc/ssh/sshd_config",
        "systemctl restart sshd.service"
    ],
    "install_linux_esx": true,
    "network": {
        "type": "dhcp"
    }
}