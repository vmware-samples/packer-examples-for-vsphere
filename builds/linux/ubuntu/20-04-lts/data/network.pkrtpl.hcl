  network:
    network:
      version: 2
      ethernets:
%{ if ip != null ~}
        ${device}:
          dhcp4: false
          addresses:
            - ${ip}/${netmask}
          gateway4: ${gateway}
          nameservers:
            addresses:
%{ for item in dns ~}
              - ${item}
%{ endfor ~}
%{ else ~}
        ${device}:
          dhcp4: true
%{ endif ~}