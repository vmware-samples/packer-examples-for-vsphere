%{ if ip != null ~}
        "type": "static",
        "ip_addr": "${ip}",
        "netmask": "${netmask}",
        "gateway": "${gateway}"
        "nameserver": "${join(" ", dns)}"
%{ else ~}
        "type": "dhcp"
%{ endif ~}