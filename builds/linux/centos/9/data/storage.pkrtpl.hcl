### Sets how the boot loader should be installed.
bootloader --location=mbr

### Initialize any invalid partition tables found on disks.
zerombr

### Removes partitions from the system, prior to creation of new partitions.
### By default, no partitions are removed.
### --all	Erases all partitions from the system
### --initlabel Initializes a disk (or disks) by creating a default disk label for all disks in their respective architecture.
clearpart --all --initlabel

### Modify partition sizes for the virtual machine hardware.
### Create primary system partitions.
%{ for partition in partitions ~}
part
%{~ if partition.volume_group != "" ~}
 pv.${partition.volume_group}
%{~ else ~}
%{~ if partition.format.fstype == "swap" ~}
 swap
%{~ else ~}
 ${partition.mount.path}
%{~ endif ~}
%{~ if partition.format.fstype != "" ~}
 --label=${partition.format.label}
%{~ if partition.format.fstype == "fat32" ~}
 --fstype vfat
%{~ else ~}
 --fstype ${partition.format.fstype}
%{~ endif ~}
%{~ endif ~}
%{~ endif ~}
%{~ if partition.mount.options != "" ~}
  --fsoptions="${partition.mount.options}"
%{~ endif ~}
%{~ if partition.size != -1 ~}
 --size=${partition.size}
%{~ else ~}
 --size=100 --grow
%{ endif ~}

%{ endfor ~}
### Create a logical volume management (LVM) group.
%{ for index, volume_group in lvm ~}
volgroup sysvg pv.${volume_group.name}

### Modify logical volume sizes for the virtual machine hardware.
### Create logical volumes.
%{ for partition in volume_group.partitions ~}
logvol
%{~ if partition.format.fstype == "swap" ~}
 swap
%{~ else ~}
 ${partition.mount.path}
%{~ endif ~}
 --name=${partition.name} --vgname=${volume_group.name} --label=${partition.format.label}
%{~ if partition.format.fstype == "fat32" ~}
 --fstype vfat
%{~ else ~}
 --fstype ${partition.format.fstype}
%{~ endif ~}
%{~ if partition.mount.options != "" ~}
 --fsoptions="${partition.mount.options}"
%{~ endif ~}
%{~ if partition.size != -1 ~}
 --size=${partition.size}
%{~ else ~}
 --size=100 --grow
%{ endif ~}

%{ endfor ~}
%{ endfor ~}