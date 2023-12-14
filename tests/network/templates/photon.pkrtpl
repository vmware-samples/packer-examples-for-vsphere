%{ if ip != null ~}
        "type": "static",
        "ip_addr": "${ip}",
        "netmask": "${cidrnetmask("${ip}/${netmask}")}",
        "gateway": "${gateway}",
        "nameserver": "${join(" ", dns)}"
%{ else ~}
        "type": "dhcp"
%{ endif ~}