# Maintainer: code@rainpole.io

# Packer input variables for all builds.

##################################################################################
# VARIABLES
##################################################################################

# Credentials

vcenter_username = "svc-packer-vsphere@rainpole.io"
vcenter_password = "R@in!$aG00dThing."
build_username   = "rainpole"
build_password   = "R@in!$aG00dThing."

# vSphere Objects

vcenter_insecure_connection     = true
vcenter_server                  = "sfo-w01-vc01.sfo.rainpole.io"
vcenter_datacenter              = "sfo-w01-dc01"
vcenter_cluster                 = "sfo-w01-cl01"
vcenter_datastore               = "sfo-w01-cl01-ds-vsan01"
vcenter_network                 = "sfo-w01-seg-dhcp"
vcenter_folder                  = "sfo-w01-fd-templates"
vcenter_content_library         = "sfo-w01-lib01"

# ISO Objects

iso_datastore = "[sfo-w01-cl01-ds-nfs01] " # The [SPACE] is required.
iso_path      = "iso"