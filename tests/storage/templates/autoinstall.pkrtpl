  storage:
    config:
      - id: disk
        type: disk
        path: /dev/${device}
        ptable: gpt
%{ for index, partition in partitions ~}
      - id: partition-${partition.name}
        type: partition
        device: disk
%{ if partition.size != -1 ~}
        size: ${partition.size}M
%{ else ~}
        size: ${partition.size}
%{ endif ~}
%{ if partition.mount.path == "/boot" ~}
        flag: bios_grub
%{ endif ~}
%{ if partition.mount.path == "/boot/efi" ~}
        flag: boot
%{ endif ~}
%{ if index == 0 ~}
        grub_device: true
%{ endif ~}
%{ if partition.format.fstype != "" ~}
      - id: format-${partition.name}
        type: format
        volume: partition-${partition.name}
        label: ${partition.format.label}
        fstype: ${partition.format.fstype}
%{ endif ~}
%{ if partition.volume_group == "" ~}
      - id: mount-${partition.name}
        type: mount
%{ if partition.mount.path == "" ~}
        path: none
%{ else ~}
        path: ${partition.mount.path}
%{ endif ~}
        device: format-${partition.name}
%{ if partition.mount.options != "" ~}
        options: ${partition.mount.options}
%{ endif ~}
%{ endif ~}
%{ endfor ~}
%{ for index, volume_group in lvm ~}
      - id: volgroup-${volume_group.name}
        type: lvm_volgroup
        name: ${volume_group.name}
        devices:
%{ for index, partition in partitions ~}
%{ if lookup(partition, "volume_group", "") == volume_group.name ~}
          - partition-${partition.name}
%{ endif ~}
%{ endfor ~}
%{ for index, partition in volume_group.partitions ~}
      - id: partition-${partition.name}
        type: lvm_partition
        name: ${partition.name}
        size: ${partition.size}M
        volgroup: volgroup-${volume_group.name}
      - id: format-${partition.name}
        type: format
        volume: partition-${partition.name}
        label: ${partition.format.label}
        fstype: ${partition.format.fstype}
      - id: mount-${partition.name}
        type: mount
%{ if partition.mount.path == "" ~}
        path: none
%{ else ~}
        path: ${partition.mount.path}
%{ endif ~}
        device: format-${partition.name}
%{ if partition.mount.options != "" ~}
        options: ${partition.mount.options}
%{ endif ~}
%{ endfor ~}
%{ endfor ~}
