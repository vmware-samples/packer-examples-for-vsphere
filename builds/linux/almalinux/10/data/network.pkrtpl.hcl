%{ if ip != null ~}
network --device=${device} --bootproto=static --ip=${ip} --netmask=${cidrnetmask("${ip}/${netmask}")} --gateway=${gateway} --nameserver=${join(",", dns)}
%{ else ~}
network --device=${device} --bootproto=dhcp
%{ endif ~}