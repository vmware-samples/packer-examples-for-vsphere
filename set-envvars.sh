#!/usr/bin/env bash
# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

# This script allows you to set the environment variables on the system for use by Packer instead of using cleartext.

# Defaults

vsphere_insecure_connection="false"
common_vm_version="19"
common_tools_upgrade_policy="true"
common_remove_cdrom="true"
common_template_conversion="false"
common_content_library_ovf="true"
common_content_library_destroy="true"
common_content_library_skip_export="false"
common_ovf_export_enabled="false"
common_ovf_export_overwrite="true"
common_data_source="http"
common_http_ip=""
common_http_port_min="8000"
common_http_port_max="8099"
common_ip_wait_timeout="20m"
common_shutdown_timeout="15m"
communicator_proxy_host=""
communicator_proxy_port=""
communicator_proxy_username=""
communicator_proxy_password=""
ansible_username="ansible"

# Packer Logging
while true; do
    read -r -p "Enable logging for Packer? (y/n): " enable_logging_input
    case $enable_logging_input in
    [yY][eE][sS] | [yY])
        enable_logging=true
        while true; do
            read -r -p "Enable log to file? (y/n): " enable_log_path_input
            case $enable_log_path_input in
            [yY][eE][sS] | [yY])
                enable_log_path=true
                while true; do
                    read -r -p "Enter the log path (e.g. /tmp/packer/): " log_dir_input
                    if [[ -n "$log_dir_input" ]]; then
                        if test -d "$log_dir_input"; then
                            log_dir="$log_dir_input"
                            break
                        else
                            echo -e "\n> Invalid input; path does not exist."
                        fi
                    else
                        unset -v log_dir
                        break
                    fi
                done
                break
                ;;
            [nN][oO] | [nN])
                unset -v enable_log_path
                unset -v log_dir
                break
                ;;
            *)
                echo -e "\n> Invalid input; please enter 'y' or 'n'."
                ;;
            esac
        done
        break
        ;;
    [nN][oO] | [nN])
        unset -v enable_logging
        unset -v PACKER_LOG
        unset -v PACKER_LOG_PATH
        break
        ;;
    *)
        echo -e "\n> Invalid input; please enter 'y' or 'n'."
        ;;
    esac
done

# vSphere Credentials
echo -e '\n> Set the vSphere credentials.'
read -r -p "Enter the FQDN of your vCenter Server instance: " vsphere_endpoint
read -r -p "Enter the username for the user account: " vsphere_username
read -r -s -p "Enter the password for the user account: " vsphere_password
echo # Needed for line break.
read -r -p "Skip vCenter Server instance SSL verification? (y/n): " skip_ssl_verification
case $skip_ssl_verification in
[yY][eE][sS] | [yY])
	vsphere_insecure_connection=true
	;;
[nN][oO] | [nN])
	vsphere_insecure_connection=false
	;;
*)
	echo -e "\n> Invalid input; skipping SSL verification settings. Using default values."
	;;
esac

# vSphere Settings
echo -e '\n> Set the vSphere settings.'
read -r -p "Enter the vSphere datacenter name: " vsphere_datacenter
read -r -p "Enter the vSphere cluster name: " vsphere_cluster
read -r -p "Enter the ESXi host FQDN or IP: " vsphere_host
read -r -p "Enter the datastore name virtual machines: " vsphere_datastore
read -r -p "Enter the network name: " vsphere_network
read -r -p "Enter the folder name: " vsphere_folder
read -r -p "Enter the content library name: " common_content_library_name
read -r -p "Enter the datastore name for .iso files: " common_iso_datastore

echo -e '\n> Set the common virtual machine settings.'
# Virtual Machine Settings
read -r -p "Enter the virtual hardware version (recommended: ""${common_vm_version}""): " common_vm_version
read -r -p "Enable VMware Tools upgrade (recommended: ""${common_tools_upgrade_policy}""): " common_tools_upgrade_policy
read -r -p "Remove CD-ROMs (recommended: ""${common_remove_cdrom}""): " common_remove_cdrom
echo -e '\n> Set the common template and content library settings.'
# Template and Content Library Settings
read -r -p "Convert to a template (recommended: ""${common_template_conversion}""): " common_template_conversion
read -r -p "Export OVF Template to the content library (recommended: ""${common_content_library_ovf}""): " common_content_library_ovf
read -r -p "Destroy virtual machine artifact (recommended: ""${common_content_library_destroy}""): " common_content_library_destroy
read -r -p "Skip export to content library (recommended: ""${common_content_library_skip_export}""): " common_content_library_skip_export
echo -e '\n> Set the common OVF export settings.'
# OVF Export Settings
read -r -p "Export as an OVF artifact (recommended: ""${common_ovf_export_enabled}""): " common_ovf_export_enabled
read -r -p "Overwrite an existing OVF artifact (recommended: ""${common_ovf_export_overwrite}""): " common_ovf_export_overwrite
echo -e '\n> Set the common boot and provisioning settings.'
# Boot and Provisioning Settings
read -r -p "Set the provisioning datasource (recommended: ""${common_data_source}""): " common_data_source
read -r -p "Enter the IP address of the interface on this host: " common_http_ip
read -r -p "Enter the starting HTTP port (recommended: ""${common_http_port_min}""): " common_http_port_min
read -r -p "Enter the ending HTTP port (recommended: ""${common_http_port_max}""): " common_http_port_max
read -r -p "Enter the IP wait timeout (recommended: ""${common_ip_wait_timeout}""): " common_ip_wait_timeout
read -r -p "Enter the virtual machine shutdown timeout (recommended: ""${common_shutdown_timeout}""): " common_shutdown_timeout

# Proxy Credentials
echo -e '\n> Set proxy credentials.'
read -r -p "Use SOCKS Proxy? (y/n): " use_socks_proxy
case $use_socks_proxy in
[yY][eE][sS] | [yY])
	echo '> Set the proxy credentials.'
	read -r -p "Enter the FQDN/IP of the proxy: " communicator_proxy_host
	read -r -p "Enter the port for the proxy: " communicator_proxy_port
	read -r -p "Enter the username for the proxy: " communicator_proxy_username
	read -r -s -p "Enter the password for the proxy: " communicator_proxy_password
	echo
	;;
[nN][oO] | [nN]) ;;

*)
	echo -e "\n> Invalid input; skipping Socks Proxy settings. Using defaults values."
	;;
esac

# Default Account Credentials
echo -e '\n> Set the default user account credentials.'
read -r -p "Enter the username for the account: " build_username
read -r -s -p "Enter the password for the account: " build_password
echo # Needed for line break.
read -r -s -p "Enter the SHA-512 encrypted password for the account: " build_password_encrypted
echo # Needed for line break.
read -r -s -p "Enter the key for the account: " build_key
echo # Needed for line break.

# Ansible Credentials
echo -e '\n> Set the Ansible credentials.'
read -r -p "Enter the username for the account: " ansible_username
read -r -s -p "Enter the key for the account: " ansible_key
echo # Needed for line break.

# Red Hat Subscription Manager Credentials
echo -e '\n> Set the RedHat Subscription Manager credentials.'
read -r -p "Enter the username for the account: " rhsm_username
read -r -s -p "Enter the password for the account: " rhsm_password
echo # Needed for line break.

# SUSE Customer Center Credentials
echo -e '\n> Set the SUSE Customer Center credentials.'
read -r -p "Enter the email for the account: " scc_email
read -r -s -p "Enter the code for the account: " scc_code
echo # Needed for line break.

# HCP Packer
echo -e '\n> Set the HCP Packer registry.'
read -r -p "Enable the HCP Packer registry: " common_hcp_packer_registry_enabled
echo # Needed for line break.

# Packer Logging
echo -e '\n> Set the Packer logging.'
if [[ $enable_logging == true ]]; then
    export PACKER_LOG=1
    if [[ $enable_log_path == true ]]; then
        if [[ -n "$log_dir" ]]; then
            export PACKER_LOG_PATH="${log_dir}/packer.log"
        else
            unset -v PACKER_LOG_PATH
        fi
    else
        unset -v PACKER_LOG_PATH
    fi
else
    unset -v PACKER_LOG
    unset -v PACKER_LOG_PATH
fi

echo -e '\n> Setting the vSphere credentials...'
# vSphere Credentials
export PKR_VAR_vsphere_endpoint="${vsphere_endpoint}"
export PKR_VAR_vsphere_username="${vsphere_username}"
export PKR_VAR_vsphere_password="${vsphere_password}"
export PKR_VAR_vsphere_insecure_connection="${vsphere_insecure_connection}"

echo '> Setting the vSphere settings...'
# vSphere Settings
export PKR_VAR_vsphere_datacenter="${vsphere_datacenter}"
export PKR_VAR_vsphere_cluster="${vsphere_cluster}"
export PKR_VAR_vsphere_host="${vsphere_host}"
export PKR_VAR_vsphere_datastore="${vsphere_datastore}"
export PKR_VAR_vsphere_network="${vsphere_network}"
export PKR_VAR_vsphere_folder="${vsphere_folder}"
export PKR_VAR_common_content_library_name="${common_content_library_name}"
export PKR_VAR_common_iso_datastore="${common_iso_datastore}"

echo '> Setting the common virtual machine settings...'
# Virtual Machine Settings
export PKR_VAR_common_vm_version="${common_vm_version}"
export PKR_VAR_common_tools_upgrade_policy="${common_tools_upgrade_policy}"
export PKR_VAR_common_remove_cdrom="${common_remove_cdrom}"

echo '> Setting the common template and content library settings...'
# Template and Content Library Settings
export PKR_VAR_common_template_conversion="${common_template_conversion}"
export PKR_VAR_common_content_library_ovf="${common_content_library_ovf}"
export PKR_VAR_common_content_library_destroy="${common_content_library_destroy}"
export PKR_VAR_common_content_library_skip_export="${common_content_library_skip_export}"

echo '> Setting the OVF export settings...'
# OVF Export Settings
export PKR_VAR_common_ovf_export_enabled="${common_ovf_export_enabled}"
export PKR_VAR_common_ovf_export_overwrite="${common_ovf_export_overwrite}"

echo '> Setting the common boot and provisioning settings...'
# Boot and Provisioning Settings
export PKR_VAR_common_data_source="${common_data_source}"
export PKR_VAR_common_http_ip="${common_http_ip}"
export PKR_VAR_common_http_port_min="${common_http_port_min}"
export PKR_VAR_common_http_port_max="${common_http_port_max}"
export PKR_VAR_common_ip_wait_timeout="${common_ip_wait_timeout}"
export PKR_VAR_common_shutdown_timeout="${common_shutdown_timeout}"

# Proxy Credentials
case $use_socks_proxy in
[yY][eE][sS] | [yY])
	echo '> Setting the proxy credentials...'
	export PKR_VAR_communicator_proxy_host="${communicator_proxy_host}"
	export PKR_VAR_communicator_proxy_port="${communicator_proxy_port}"
	export PKR_VAR_communicator_proxy_username="${communicator_proxy_username}"
	export PKR_VAR_communicator_proxy_password="${communicator_proxy_password}"
	;;
[nN][oO] | [nN]) ;;

*) ;;

esac

echo '> Setting the default account credentials...'
# Default Account Credentials
export PKR_VAR_build_username="${build_username}"
export PKR_VAR_build_password="${build_password}"
export PKR_VAR_build_password_encrypted="${build_password_encrypted}"
export PKR_VAR_build_key="${build_key}"

echo '> Setting the Ansible credentials...'
# Ansible Credentials
export PKR_VAR_ansible_username="${ansible_username}"
export PKR_VAR_ansible_key="${ansible_key}"

echo '> Setting the RedHat Subscription Manager credentials...'
# Red Hat Subscription Manager Credentials
export PKR_VAR_rhsm_username="${rhsm_username}"
export PKR_VAR_rhsm_password="${rhsm_password}"
echo

echo '> Setting the SUSE Customer Center credentials...'
# SUSE Customer Center Credentials
export PKR_VAR_scc_email="${scc_email}"
export PKR_VAR_scc_code="${scc_code}"
echo

echo '> Setting the HCP Packer...'
# HCP Packer
export PKR_VAR_common_hcp_packer_registry_enabled="${common_hcp_packer_registry_enabled}"
echo

read -r -p "Display the environment variables? (y/n): " display_environmental_variables
case $display_environmental_variables in
[yY][eE][sS] | [yY])

	# Packer Logging
    echo -e '\nPacker Logging'
    echo - PACKER_LOG: "$PACKER_LOG"
    echo - PACKER_LOG_PATH: "$PACKER_LOG_PATH"

	# vSphere Credentials
	echo -e '\nvSphere Credentials'
	echo - PKR_VAR_vsphere_endpoint: "$PKR_VAR_vsphere_endpoint"
	echo - PKR_VAR_vsphere_username: "$PKR_VAR_vsphere_username"
	echo - PKR_VAR_vsphere_password: "$PKR_VAR_vsphere_password"
	echo - PKR_VAR_vsphere_insecure_connection: "$PKR_VAR_vsphere_insecure_connection"

	#vSphere Settings
	echo -e '\nvSphere Settings'
	echo - PKR_VAR_vsphere_datacenter: "$PKR_VAR_vsphere_datacenter"
	echo - PKR_VAR_vsphere_cluster: "$PKR_VAR_vsphere_cluster"
	echo - PKR_VAR_vsphere_host: "$PKR_VAR_vsphere_host"
	echo - PKR_VAR_vsphere_datastore: "$PKR_VAR_vsphere_datastore"
	echo - PKR_VAR_vsphere_network: "$PKR_VAR_vsphere_network"
	echo - PKR_VAR_vsphere_folder: "$PKR_VAR_vsphere_folder"
	echo - PKR_VAR_common_content_library_name: "$PKR_VAR_common_content_library_name"
	echo - PKR_VAR_common_iso_datastore: "$PKR_VAR_common_iso_datastore"

	# Virtual Machine Settings
	echo -e '\nCommon Virtual Machine Settings'
	echo - PKR_VAR_common_vm_version: "$PKR_VAR_common_vm_version"
	echo - PKR_VAR_common_tools_upgrade_policy: "$PKR_VAR_common_tools_upgrade_policy"
	echo - PKR_VAR_common_remove_cdrom: "$PKR_VAR_common_remove_cdrom"

	# Template and Content Library Settings
	echo -e '\nCommon Template and Content Library Settings'
	echo - PKR_VAR_common_template_conversion: "$PKR_VAR_common_template_conversion"
	echo - PKR_VAR_common_content_library_ovf: "$PKR_VAR_common_content_library_ovf"
	echo - PKR_VAR_common_content_library_destroy: "$PKR_VAR_common_content_library_destroy"
	echo - PKR_VAR_common_content_library_skip_export: "$PKR_VAR_common_content_library_skip_export"

	# OVF Export Settings
	echo -e '\nOVF Export Settings'
	echo - PKR_VAR_common_ovf_export_enabled: "$PKR_VAR_common_ovf_export_enabled"
	echo - PKR_VAR_common_ovf_export_overwrite: "$PKR_VAR_common_ovf_export_overwrite"

	# Boot and Provisioning Settings
	echo -e '\nBoot and Provisioning Settings'
	echo - PKR_VAR_common_data_source: "$PKR_VAR_common_data_source"
	echo - PKR_VAR_common_http_ip: "$PKR_VAR_common_http_ip"
	echo - PKR_VAR_common_http_port_min: "$PKR_VAR_common_http_port_min"
	echo - PKR_VAR_common_http_port_max: "$PKR_VAR_common_http_port_max"
	echo - PKR_VAR_common_ip_wait_timeout: "$PKR_VAR_common_ip_wait_timeout"
	echo - PKR_VAR_common_shutdown_timeout: "$PKR_VAR_common_shutdown_timeout"

	# Proxy Credentials

	case $use_socks_proxy in
	[yY][eE][sS] | [yY])
		echo -e '\nProxy Credentials'
		echo - PKR_VAR_communicator_proxy_host: "$PKR_VAR_communicator_proxy_host"
		echo - PKR_VAR_communicator_proxy_port: "$PKR_VAR_communicator_proxy_port"
		echo - PKR_VAR_communicator_proxy_username: "$PKR_VAR_communicator_proxy_username"
		echo - PKR_VAR_communicator_proxy_password: "$PKR_VAR_communicator_proxy_password"
		;;
	[nN][oO] | [nN]) ;;

	*) ;;

	esac

	# Default User Account Credentials
	echo -e '\nDefault User Account Credentials'
	echo - PKR_VAR_build_username: "$PKR_VAR_build_username"
	echo - PKR_VAR_build_password: "$PKR_VAR_build_password"
	echo - PKR_VAR_build_password_encrypted: "$PKR_VAR_build_password_encrypted"
	echo - PKR_VAR_build_key: "$PKR_VAR_build_key"

	# Ansible Credentials
	echo -e '\nAnsible Credentials'
	echo - PKR_VAR_ansible_username: "$PKR_VAR_ansible_username"
	echo - PKR_VAR_ansible_key: "$PKR_VAR_ansible_key"

	# RedHat Subscription Manager Credentials
	echo -e '\nRedHat Subscription Manager Credentials'
	echo - PKR_VAR_rhsm_username: "$PKR_VAR_rhsm_username"
	echo - PKR_VAR_rhsm_password: "$PKR_VAR_rhsm_password"

	# SUSE Customer Center Credentials
	echo -e '\nSUSE Customer Center Credentials'
	echo - PKR_VAR_scc_email: "$PKR_VAR_scc_email"
	echo - PKR_VAR_scc_code: "$PKR_VAR_scc_code"

	# HCP Packer
	echo -e '\nHCP Packer'
	echo - PKR_VAR_common_hcp_packer_registry_enabled "$PKR_VAR_common_hcp_packer_registry_enabled"
	;;
[nN][oO] | [nN]) ;;

*)
	echo -e "\n> Invalid input; skipping display of the environmental variables."
	;;
esac
