{
    "hostname": "photon-server",
    "password":
        {
            "crypted": true,
            "text": "${build_password_encrypted}"
        },
    "disk": "/dev/sda",
    "bootmode": "bios",
    "packagelist_file": "packages_minimal.json",
    "additional_packages": [
        "sudo"
    ],
    "postinstall": [
        "#!/bin/sh",
        "sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config",
        "sed -i 's/MaxAuthTries.*/MaxAuthTries 10/g' /etc/ssh/sshd_config",
        "systemctl restart sshd.service",
        "chage -I -1 -m 0 -M 99999 -E -1 root",
        "useradd -m -p '${build_password_encrypted}' -s /bin/bash ${build_username}",
        "usermod -aG sudo ${build_username}"
    ],
    "install_linux_esx": true,
    "network": {
        "type": "dhcp"
    }
}
