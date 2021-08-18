# Maintainer: code@rainpole.io
# Common variables for all builds.

##################################################################################
# VARIABLES
##################################################################################

// Virtual Machine Settings
common_vm_version           = 18
common_tools_upgrade_policy = true
common_remove_cdrom         = true

// Template and Content Library Settings
common_template_conversion     = false
common_content_library_name    = "sfo-w01-lib01"
common_content_library_ovf     = true
common_content_library_destroy = true

// Removable Media Settings
common_iso_datastore = "sfo-w01-cl01-ds-nfs01"
common_iso_path      = "iso"
common_iso_hash      = "sha512"

// Boot and Provisioning Settings
common_http_port_min    = 8000
common_http_port_max    = 8099
common_ip_wait_timeout  = "20m"
common_shutdown_timeout = "15m"