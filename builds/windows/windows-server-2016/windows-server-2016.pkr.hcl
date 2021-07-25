# Maintainer: code@rainpole.io
# Packer temnplate for Windows Server 2019 Standard and Datacenter - Desktop Experience and Core
# https://www.packer.io/docs/builders/vsphere/vsphere-iso

##################################################################################
# PACKER PLUGINS
##################################################################################

packer {
  required_plugins {
    windows-update = {
      version = "0.12.0"
      source = "github.com/rgl/windows-update"
    }
  }
}

##################################################################################
# VARIABLES
##################################################################################

# Credentials.

variable "vcenter_username" {
  type    = string
  description = "The username to login to the vCenter Server instance. (e.g. 'svc-packer-vsphere@rainpole.io')"
  default = ""
  sensitive = true
}

variable "vcenter_password" {
  type      = string
  description = "The password for the login to the vCenter Server instance."
  default = ""
  sensitive = true
}

variable "build_username" {
  type    = string
  description = "The username to login to the guest operating system. (e.g. 'rainpole')"
  default = ""
  sensitive = true
}

variable "build_password" {
  type      = string
  description = "The password for the login to the guest operating system."
  default = ""
  sensitive = true
}

# vSphere Objects

variable "vcenter_insecure_connection" {
  type    = bool
  description = "Do not validate vCenter Server TLS certificate."
  default = true
}

variable "vcenter_server" {
  type    = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance. (e.g. 'sfo-w01-vc01.sfo.rainpole.io')"
  default = ""
}

variable "vcenter_datacenter" {
  type    = string
  description = "The name of the target vSphere datacenter. (e.g. 'sfo-w01-dc01')"
  default = ""
}

variable "vcenter_cluster" {
  type    = string
  description = "The name of the target vSphere cluster. (e.g. 'sfo-w01-cl01')"
  default = ""
}

variable "vcenter_datastore" {
  type    = string
  description = "The name of the target vSphere datastore. (e.g. 'sfo-w01-cl01-vsan01')"
  default = ""
}

variable "vcenter_network" {
  type    = string
  description = "The name of the target vSphere network segment. (e.g. 'sfo-w01-dhcp')"
  default = ""
}

variable "vcenter_folder" {
  type    = string
  description = "The name of the target vSphere cluster. (e.g. 'sfo-w01-fd-templates')"
  default = ""
}

variable "vcenter_content_library" {
  type    = string
  description = "The name of the target vSphere content library, if used. (e.g. 'sfo-w01-cl01-lib01')"
  default = ""
}

# ISO Objects

variable "iso_datastore" {
  type    = string
  description = "The name of the source vSphere datastore for ISO images. (e.g. 'sfo-w01-cl01-nfs01')"
  default = ""
  }

variable "iso_path" {
  type    = string
  description = "The path on the source vSphere datastore for ISO images. (e.g. 'iso')"
  default = ""
  }

variable "iso_file" {
  type    = string
  description = "The file name of the ISO image. (e.g. 'iso-windows-server-2019.iso')"
  default = ""
}

variable "iso_checksum" {
  type    = string
  description = "The SHA-512 checkcum of the ISO image. (e.g. Result of 'shasum -a 512 iso-windows-server-2019.iso')"
  default = ""
}

# Virtual Machine Settings

variable "vm_guest_os_family" {
  type    = string
  description = "The guest operatiing system family. Used for naming and VMware tools. (e.g. 'windows' or 'linux')"
  default = ""
}

variable "vm_guest_os_member" {
  type    = string
  description = "The guest operatiing system member. Used for naming. (e.g. 'server' or 'desktop')"
  default = ""
}

variable "vm_guest_os_version" {
  type    = string
  description = "The guest operatiing system version. Used for naming. (e.g. '2019')"
  default = ""
}

variable "vm_guest_os_edition_std" {
  type    = string
  description = "The guest operatiing system edition. Used for naming. (e.g. 'standard')"
  default = "standard"
}

variable "vm_guest_os_edition_dc" {
  type    = string
  description = "The guest operatiing system edition. Used for naming. (e.g. 'datacenter')"
  default = "datacenter"
}

variable "vm_guest_os_type" {
  type    = string
  description = "The guest operating system type, also know as guestid. (e.g. 'windows2019srv_64Guest')"
  default = ""
}

variable "vm_version" {
  type    = number
  description = "The vSphere virtual hardware version. Refer to https://kb.vmware.com/kb/1003746. (e.g. '18')"
  default = 18
}

variable "vm_firmware" {
  type    = string
  description = "The virtual machine firmware. (e.g. 'efi-secure' or 'bios')"
  default = "efi-secure"
}

variable "vm_boot_wait" {
  type    = string
  description = "The time to wait before boot. "
  default = "2s"
}

variable "vm_cdrom_type" {
  type    = string
  description = "The virtual machine CD-ROM type. (e.g. 'sata', or 'ide')"
  default = "sata"
}

variable "vm_boot_command" {
  type    = list(string)
  description = "The virtual machine boot command."
  default = []
}

variable "vm_cpu_sockets" {
  type    = number
  description = "The number of virtual CPUs sockets. (e.g. '2')"
  default = 2
}

variable "vm_cpu_cores" {
  type    = number
  description = "The number of virtual CPUs cores per socket. (e.g. '1')"
  default = 1
}

variable "vm_mem_size" {
  type    = number
  description = "The size for the virtual memory in MB. (e.g. '2048')"
  default = 2048
}

variable "vm_disk_size" {
  type    = number
  description = "The size for the virtual disk in MB. (e.g. '40960')"
  default = 40960
}

variable "vm_floppy_files_server_std_dexp" {
  type    = list(string)
  description = "Used for Server with Desktop Experience. The list of files or directories to be added to the virtual flappy device. Used for unattended installation."
  default = []
}

variable "vm_floppy_files_server_std_core" {
  type    = list(string)
  description = "Used for Server Core. The list of files or directories to be added to the virtual flappy device. Used for unattended installation."
  default = []
}

variable "vm_floppy_files_server_dc_dexp" {
  type    = list(string)
  description = "Used for Server with Desktop Experience. The list of files or directories to be added to the virtual flappy device. Used for unattended installation."
  default = []
}

variable "vm_floppy_files_server_dc_core" {
  type    = list(string)
  description = "Used for Server Core. The list of files or directories to be added to the virtual flappy device. Used for unattended installation."
  default = []
}

variable "vm_disk_controller_type" {
  type    = list(string)
  description = "The virtual disk controller types in sequence. If pvscsi is used the drivers must be added to the virtual floppy device. (e.g. 'pvscsi')"
  default = ["pvscsi"]
}

variable "vm_network_card" {
  type    = string
  description = "The virtual network card type. If vmxnet3 is used, VMware Tools must be installed before connectivity. Performed by second ISO path and autounattend.xml. (e.g. 'vmxnet3' or 'e1000e')"
  default = "vmxnet3"
}

variable "vm_shutdown_command" {
  type    = string
  description = "The shutdown command to issue to the guest operating system at the end of the build process. (e.g. 'windows-server-sysprep.bat')"
  default = ""
}

variable "powershell_scripts" {
  type    = list(string)
  description = "A list of scripts and their relative paths to transfer and execute using Windows Remote Management."
  default = []
}

variable "powershell_inline" {
  type    = list(string)
  description = "A list of commands to execute using Windows Remote Management."
  default = []
}

##################################################################################
# LOCALS
##################################################################################

locals { 
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }

##################################################################################
# SOURCE
##################################################################################

source "vsphere-iso" "windows-server-standard-dexp" {
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  datacenter           = var.vcenter_datacenter
  cluster              = var.vcenter_cluster
  datastore            = var.vcenter_datastore
  folder               = var.vcenter_folder
  insecure_connection  = var.vcenter_insecure_connection
  tools_upgrade_policy = true
  remove_cdrom         = true
  convert_to_template  = false
  guest_os_type        = var.vm_guest_os_type
  vm_version           = var.vm_version
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."
  vm_name              = "${ var.vm_guest_os_family }-${ var.vm_guest_os_member }-${ var.vm_guest_os_version }-${ var.vm_guest_os_edition_std }"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = false
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = false
  boot_wait            = var.vm_boot_wait
  boot_command         = var.vm_boot_command
  boot_order           = "disk,cdrom"
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = true
    }
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
    }
  floppy_files              = var.vm_floppy_files_server_std_dexp
  iso_paths                 = [ "${ var.iso_datastore }${ var.iso_path }/${ var.iso_file }",
                                "[] /vmimages/tools-isoimages/${ var.vm_guest_os_family }.iso"
    ]
  iso_checksum              = "sha512:var.iso_checksum"
  ip_wait_timeout           = "20m"
  communicator              = "winrm"
  winrm_username            = var.build_username
  winrm_password            = var.build_password
  winrm_port                = "5985"
  winrm_timeout             = "12h"
  shutdown_command          = var.vm_shutdown_command
  shutdown_timeout          = "15m"
    /*
    Default: Clone to the content library as an OVF template and destroy the originating machine image.
    Comment this section to exclude the use of the content library.
    - If ovf = true - the machine image is exported to the target content library.
    - If destroy = true - the machine image is destroyed after successfully exported to the target content library.
    - By default, the target name is the vm_name unless name = "foo" is provided.
    - The content library item is updated if the target name is the same. 
    */
  content_library_destination {
    library = var.vcenter_content_library
    ovf     = true
    destroy = true
  }
}

source "vsphere-iso" "windows-server-standard-core" {
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  datacenter           = var.vcenter_datacenter
  cluster              = var.vcenter_cluster
  datastore            = var.vcenter_datastore
  folder               = var.vcenter_folder
  insecure_connection  = var.vcenter_insecure_connection
  tools_upgrade_policy = true
  remove_cdrom         = true
  convert_to_template  = false
  guest_os_type        = var.vm_guest_os_type
  vm_version           = var.vm_version
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."
  vm_name              = "${ var.vm_guest_os_family }-${ var.vm_guest_os_member }-${ var.vm_guest_os_version }-${ var.vm_guest_os_edition_std }-core"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = false
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = false
  boot_wait            = var.vm_boot_wait
  boot_command         = var.vm_boot_command
  boot_order           = "disk,cdrom"
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = true
    }
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
    }
  floppy_files              = var.vm_floppy_files_server_std_core
  iso_paths                 = [ "${ var.iso_datastore }${ var.iso_path }/${ var.iso_file }",
                                "[] /vmimages/tools-isoimages/${ var.vm_guest_os_family }.iso"
    ]
  iso_checksum              = "sha512:var.iso_checksum"
  ip_wait_timeout           = "20m"
  communicator              = "winrm"
  winrm_username            = var.build_username
  winrm_password            = var.build_password
  winrm_port                = "5985"
  winrm_timeout             = "12h"
  shutdown_command          = var.vm_shutdown_command
  shutdown_timeout          = "15m"
    /*
    Default: Clone to the content library as an OVF template and destroy the originating machine image.
    Comment this section to exclude the use of the content library.
    - If ovf = true - the machine image is exported to the target content library.
    - If destroy = true - the machine image is destroyed after successfully exported to the target content library.
    - By default, the target name is the vm_name unless name = "foo" is provided.
    - The content library item is updated if the target name is the same. 
    */
  content_library_destination {
    library = var.vcenter_content_library
    ovf     = true
    destroy = true
  }
}

source "vsphere-iso" "windows-server-datacenter-dexp" {
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  datacenter           = var.vcenter_datacenter
  cluster              = var.vcenter_cluster
  datastore            = var.vcenter_datastore
  folder               = var.vcenter_folder
  insecure_connection  = var.vcenter_insecure_connection
  tools_upgrade_policy = true
  remove_cdrom         = true
  convert_to_template  = false
  guest_os_type        = var.vm_guest_os_type
  vm_version           = var.vm_version
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."
  vm_name              = "${ var.vm_guest_os_family }-${ var.vm_guest_os_member }-${ var.vm_guest_os_version }-${ var.vm_guest_os_edition_dc }"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = false
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = false
  boot_wait            = var.vm_boot_wait
  boot_command         = var.vm_boot_command
  boot_order           = "disk,cdrom"
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = true
    }
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
    }
  floppy_files              = var.vm_floppy_files_server_dc_dexp
  iso_paths                 = [ "${ var.iso_datastore }${ var.iso_path }/${ var.iso_file }",
                                "[] /vmimages/tools-isoimages/${ var.vm_guest_os_family }.iso"
    ]
  iso_checksum              = "sha512:var.iso_checksum"
  ip_wait_timeout           = "20m"
  communicator              = "winrm"
  winrm_username            = var.build_username
  winrm_password            = var.build_password
  winrm_port                = "5985"
  winrm_timeout             = "12h"
  shutdown_command          = var.vm_shutdown_command
  shutdown_timeout          = "15m"
    /*
    Default: Clone to the content library as an OVF template and destroy the originating machine image.
    Comment this section to exclude the use of the content library.
    - If ovf = true - the machine image is exported to the target content library.
    - If destroy = true - the machine image is destroyed after successfully exported to the target content library.
    - By default, the target name is the vm_name unless name = "foo" is provided.
    - The content library item is updated if the target name is the same. 
    */
  content_library_destination {
    library = var.vcenter_content_library
    ovf     = true
    destroy = true
  }
}

source "vsphere-iso" "windows-server-datacenter-core" {
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  datacenter           = var.vcenter_datacenter
  cluster              = var.vcenter_cluster
  datastore            = var.vcenter_datastore
  folder               = var.vcenter_folder
  insecure_connection  = var.vcenter_insecure_connection
  tools_upgrade_policy = true
  remove_cdrom         = true
  convert_to_template  = false
  guest_os_type        = var.vm_guest_os_type
  vm_version           = var.vm_version
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."
  vm_name              = "${ var.vm_guest_os_family }-${ var.vm_guest_os_member }-${ var.vm_guest_os_version }-${ var.vm_guest_os_edition_dc }-core"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = false
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = false
  boot_wait            = var.vm_boot_wait
  boot_command         = var.vm_boot_command
  boot_order           = "disk,cdrom"
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = true
    }
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
    }
  floppy_files              = var.vm_floppy_files_server_dc_core
  iso_paths                 = [ "${ var.iso_datastore }${ var.iso_path }/${ var.iso_file }",
                                "[] /vmimages/tools-isoimages/${ var.vm_guest_os_family }.iso"
    ]
  iso_checksum              = "sha512:var.iso_checksum"
  ip_wait_timeout           = "20m"
  communicator              = "winrm"
  winrm_username            = var.build_username
  winrm_password            = var.build_password
  winrm_port                = "5985"
  winrm_timeout             = "12h"
  shutdown_command          = var.vm_shutdown_command
  shutdown_timeout          = "15m"
    /*
    Default: Clone to the content library as an OVF template and destroy the originating machine image.
    Comment this section to exclude the use of the content library.
    - If ovf = true - the machine image is exported to the target content library.
    - If destroy = true - the machine image is destroyed after successfully exported to the target content library.
    - By default, the target name is the vm_name unless name = "foo" is provided.
    - The content library item is updated if the target name is the same. 
    */
  content_library_destination {
    library = var.vcenter_content_library
    ovf     = true
    destroy = true
  }
}

  ##################################################################################
  # BUILD
  ##################################################################################

  build {
    sources = [
      "source.vsphere-iso.windows-server-standard-dexp",
      "source.vsphere-iso.windows-server-standard-core",
      "source.vsphere-iso.windows-server-datacenter-dexp",
      "source.vsphere-iso.windows-server-datacenter-core"
      ]
    /*
    Uses the File Provisioner to copy the .p7b certificate for the Root Certificate Authority.
    - The PowerShell Provisioner will execute a script that imports the certificate to the Trusted Root Authorities.
    */ 
    provisioner "file" {
      source = "../../../certificates/root-ca.p7b"
      destination = "C:\\windows\\temp\\root-ca.p7b"
      }
    // Uses the PowerShell Provisioner to execute a series of scripts defined in the variables. 
    provisioner "powershell" {
      environment_vars = [
        "BUILD_USERNAME=${var.build_username}"
        ]
      scripts = var.powershell_scripts
      }
    // Uses the PowerShell Provisioner to execute a series of inline commands defined in the variables
    provisioner "powershell" {
      only = [
        "vsphere-iso.windows-server-standard-dexp",
        "vsphere-iso.windows-server-datacenter-dexp"
        ]
      inline = var.powershell_inline
      }
    /*
    Uses the Windows-Update Provisioner to update the guest operating system.
    - See https://github.com/rgl/packer-provisioner-windows-update for the latest release and documentation.
    */
    provisioner "windows-update" {
      pause_before = "30s"
      search_criteria = "IsInstalled=0"
      filters = [
          "exclude:$_.Title -like '*VMware*'",
          "exclude:$_.Title -like '*Preview*'",
          "exclude:$_.Title -like '*Defender*'",
          "include:$true"
          ]
      }
  }
