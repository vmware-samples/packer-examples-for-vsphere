---
icon: octicons/gear-24
---

# Configuration

## Example Variables

The project includes example variables files that you can use as a starting point for your own configuration.

The [variables][packer-variables] are defined in `.pkrvars.hcl` files.

Run the config script `./config.sh` to copy the `.pkrvars.hcl.example` files to a `config` directory.

```shell
./config.sh
./build.sh
```

The `config` folder is the default folder. You can override the default by passing an alternate value as the first argument.

For example:

San Francisco: `us-west-1`

```shell
./config.sh us-west-1
./build.sh us-west-1
```

Los Angeles: `us-west-2`

```shell
./config.sh us-west-2
./build.sh us-west-2
```

This is useful for the purposes of running machine image builds for different environment.

## Configuration Variables

### Build

Edit the `config/build.pkrvars.hcl` file to configure the credentials for the default account on machine images.

```hcl title="config/build.pkrvars.hcl"
build_username           = "example"
build_password           = "<plaintext_password>"
build_password_encrypted = "<sha512_encrypted_password>"
build_key                = "<public_key>"
```

You can also override the `build_key` value with contents of a file.

```hcl title="config/build.pkrvars.hcl"
build_key = file("${path.root}/config/ssh/build_id_ecdsa.pub")
```

Generate a SHA-512 encrypted password for the `build_password_encrypted` using tools like mkpasswd.

=== ":fontawesome-brands-linux: &nbsp; VMware Photon OS"

    Run the following command to generate a SHA-512 encrypted password for the `build_password_encrypted` using mkpasswd.

    ```shell
    sudo systemctl start docker
    sudo docker run -it --rm alpine:latest
    mkpasswd -m sha512
    ```

    The following output is displayed:

    ```shell
    Password: ***************
    [password hash]
    sudo systemctl stop docker
    ```

=== ":fontawesome-brands-ubuntu: &nbsp; Ubuntu"

    Run the following command to generate a SHA-512 encrypted password for the `build_password_encrypted` using mkpasswd.

    ```shell
    mkpasswd -m sha512
    ```

    The following output is displayed:

    ```shell
    Password: ***************
    [password hash]
    ```

=== ":fontawesome-brands-apple: &nbsp; macOS"

    Run the following command to generate a SHA-512 encrypted password for the `build_password_encrypted` using mkpasswd.

    ```shell
    docker run -it --rm alpine:latest
    mkpasswd -m sha512
    ```

    The following output is displayed:

    ```shell
    Password: ***************
    [password hash]
    ```

Generate a public key for the `build_key` for public key authentication.

=== ":fontawesome-brands-linux: &nbsp; VMware Photon OS"

    Run the following command to generate a public key for the `build_key` for public key authentication.

    ```shell
    ssh-keygen -t ecdsa -b 521 -C "<name@example.com>"
    ```

    The following output is displayed:

    ```shell
    Generating public/private ecdsa key pair.
    Enter file in which to save the key (/Users/example/.ssh/id_ecdsa):
    Enter passphrase (empty for no passphrase): **************
    Enter same passphrase again: **************
    Your identification has been saved in /Users/example/.ssh/id_ecdsa.
    Your public key has been saved in /Users/example/.ssh/id_ecdsa.pub.
    ```

=== ":fontawesome-brands-ubuntu: &nbsp; Ubuntu"

    Run the following command to generate a public key for the `build_key` for public key authentication.

    ```shell
    ssh-keygen -t ecdsa -b 521 -C "<name@example.com>"
    ```

    The following output is displayed:

    ```shell
    Generating public/private ecdsa key pair.
    Enter file in which to save the key (/Users/example/.ssh/id_ecdsa):
    Enter passphrase (empty for no passphrase): **************
    Enter same passphrase again: **************
    Your identification has been saved in /Users/example/.ssh/id_ecdsa.
    Your public key has been saved in /Users/example/.ssh/id_ecdsa.pub.
    ```

=== ":fontawesome-brands-apple: &nbsp; macOS"

    Run the following command to generate a public key for the `build_key` for public key authentication.

    ```shell
    ssh-keygen -t ecdsa -b 521 -C "<name@example.com>"
    ```

    The following output is displayed:

    ```shell
    Generating public/private ecdsa key pair.
    Enter file in which to save the key (/Users/example/.ssh/id_ecdsa):
    Enter passphrase (empty for no passphrase): **************
    Enter same passphrase again: **************
    Your identification has been saved in /Users/example/.ssh/id_ecdsa.
    Your public key has been saved in /Users/example/.ssh/id_ecdsa.pub.
    ```

The content of the public key, `build_key`, is added the key to the `~/.ssh/authorized_keys` file of the `build_username` on the Linux guest operating systems.

???+ danger "Example Public Keys and Passwords."
    Replace the example public keys and passwords.

    By default, both Public Key Authentication and Password Authentication are enabled for Linux distributions.

    If you wish to disable Password Authentication and only use Public Key Authentication, comment or remove the portion of the associated Ansible `configure` role.

### Ansible

Edit the `config/ansible.pkrvars.hcl` file to configure the credentials for the Ansible account on Linux machine images.

```hcl title="config/ansible.pkrvars.hcl"
ansible_username = "ansible"
ansible_key      = "<public_key>"
```

???+ info "Ansible User Password"
    A random password is auto-generated for the Ansible user.

You can also override the `ansible_key` value with contents of a file, if required.

```hcl title="config/ansible.pkrvars.hcl"
ansible_key = file("${path.root}/config/ssh/ansible_id_ecdsa.pub")
```

### Common

Edit the `config/common.pkrvars.hcl` file to configure the following common variables:

- Virtual Machine Settings
- Template and Content Library Settings
- OVF Export Settings
- Removable Media Settings
- Boot and Provisioning Settings
- HCP Packer Registry

```hcl title="config/common.pkrvars.hcl"
// Virtual Machine Settings
common_vm_version           = 19
common_tools_upgrade_policy = true
common_remove_cdrom         = true

// Template and Content Library Settings
common_template_conversion     = false
common_content_library_name    = "sfo-w01-lib01"
common_content_library_ovf     = true
common_content_library_destroy = true

// OVF Export Settings
common_ovf_export_enabled   = false
common_ovf_export_overwrite = true

// Removable Media Settings
common_iso_datastore = "sfo-w01-cl01-ds-nfs01"

// Boot and Provisioning Settings
common_data_source      = "http"
common_http_ip          = null
common_http_port_min    = 8000
common_http_port_max    = 8099
common_ip_wait_timeout  = "20m"
common_shutdown_timeout = "15m"

// HCP Packer
common_hcp_packer_registry_enabled = false
```

### Data Source

The default provisioning data source for Linux machine image builds is `http`. This is used to serve the kickstart files to the Linux guest operating system during the build.

```hcl title="config/common.pkrvars.hcl"
common_data_source = "http"
```

???+ tip "IPTables"
    Packer includes a built-in HTTP server that is used to serve the kickstart files for Linux machine image builds.

    If iptables is enabled on your Packer host, you will need to open `common_http_port_min` through `common_http_port_max` ports.

    ```shell
    iptables -A INPUT -p tcp --match multiport --dports 8000:8099 -j ACCEPT
    ```

You can change the `common_data_source` from `http` to `disk` to build supported Linux machine images without the need to use Packer's HTTP server. This is useful for environments that may not be able to route back to the system from which Packer is running. For example, building a machine image in VMware Cloud on AWS.

```hcl title="config/common.pkrvars.hcl"
common_data_source = "disk"
```

The Packer pluigin's `cd_content` option is used when selecting `disk` unless the distribution does not support a secondary CD-ROM. For distributions that do not support a secondary CD-ROM the `floppy_content` option is used.

### HTTP Binding

If you need to define a specific IPv4 address from your host for Packer's built-in HTTP server, modify the `common_http_ip` variable from `null` to a `string` value that matches an IP address on your Packer host.

```hcl title="config/common.pkrvars.hcl"
common_http_ip = "172.16.11.254"
```

### Proxy

Edit the `config/proxy.pkrvars.hcl` file to configure the following:

- SOCKS proxy settings used for connecting to Linux machine images.
- Credentials for the proxy server.

```hcl title="config/proxy.pkrvars.hcl"
communicator_proxy_host     = "proxy.example.com"
communicator_proxy_port     = 8080
communicator_proxy_username = "example"
communicator_proxy_password = "<plaintext_password>"
```

### Red Hat Subscription Manager

Edit the `config/redhat.pkrvars.hcl` file to configure the credentials for your Red Hat Subscription Manager account.

```hcl title="config/redhat.pkrvars.hcl"
rhsm_username = "example"
rhsm_password = "<plaintext_password>"
```

These variables are **only** used if you are performing a Red Hat Enterprise Linux Server build and are used to register the image with Red Hat Subscription Manager during the build for system updates and package installation.

Before the build completes, the machine image is unregistered from Red Hat Subscription Manager.

### SUSE Customer Connect

Edit the `config/scc.pkrvars.hcl` file to configure the following credentials for your SUSE Customer Connect account.

```hcl title="config/scc.pkrvars.hcl"
scc_email = "hello@example.com"
scc_code  = "<plaintext_code>"
```

These variables are **only** used if you are performing a SUSE Linux Enterprise Server build and are used to register the image with SUSE Customer Connect during the build for system updates and package installation.

Before the build completes, the machine image is unregistered from SUSE Customer Connect.

### VMware vSphere

Edit the `builds/vsphere.pkrvars.hcl` file to configure the following:

- vSphere Endpoint and Credentials
- vSphere Settings

```hcl title="config/vsphere.pkrvars.hcl"
vsphere_endpoint             = "sfo-w01-vc01.sfo.example.com"
vsphere_username             = "svc-packer-vsphere@example.com"
vsphere_password             = "<plaintext_password>"
vsphere_insecure_connection  = true
vsphere_datacenter           = "sfo-w01-dc01"
vsphere_cluster              = "sfo-w01-cl01"
//vsphere_host               = "sfo-w01-esx01"
vsphere_datastore            = "sfo-w01-cl01-ds-vsan01"
vsphere_network              = "sfo-w01-seg-dhcp"
vsphere_folder               = "sfo-w01-fd-templates"
```

???- note "vSphere DRs Disabled or Standalone ESXi Hosts"
    When targeting standalone ESXi hosts or vSphere clusters with vSphere DRS disabled, you must set the `vsphere_host` variable.

    **Example** (vSphere Clusters with vSphere DRS Disabled):

    ```hcl title="config/vsphere.pkrvars.hcl"
    ...
    vsphere_datacenter           = "sfo-w01-dc01"
    vsphere_cluster              = "sfo-w01-cl01"
    vsphere_host                 = "sfo-w01-esx01"
    vsphere_folder               = "sfo-w01-fd-templates"
    ...
    ```

    **Example** (Standalone ESXi Host Managed by vCenter Server):

    For a standalone ESXi host managed by vCenter Server, comment or remove `vsphere_cluster`.

    ```hcl title="config/vsphere.pkrvars.hcl"
    ...
    vsphere_datacenter           = "sfo-w01-dc01"
    //vsphere_cluster            = "sfo-w01-cl01"
    vsphere_host                 = "sfo-w01-esx01"
    vsphere_folder               = "sfo-w01-fd-templates"
    ...
    ```

    **Example** (Standalone ESXi Host):

    For a standalone, unmanaged ESXi host, comment or remove `vsphere_datacenter`, `vsphere_cluster`, and `vsphere_folder`.

    ```hcl title="config/vsphere.pkrvars.hcl"
    ...
    //vsphere_datacenter         = "sfo-w01-dc01"
    //vsphere_cluster            = "sfo-w01-cl01"
    vsphere_host                 = "sfo-w01-esx01"
    //vsphere_folder             = "sfo-w01-fd-templates"
    ...
    ```

### Machine Images

Edit the `*.auto.pkrvars.hcl` file in each `builds/<type>/<build>` folder to configure the following virtual machine hardware settings, as required:

- CPUs `(int)`
- CPU Cores `(int)`
- Memory in MB `(int)`
- Primary Disk in MB `(int)`
- .iso Path `(string)`
- .iso File `(string)`

```hcl title="builds/linux/photon/5/linux-photon.auto.pkrvars.hcl"
// Guest Operating System Metadata
vm_guest_os_family  = "linux"
vm_guest_os_name    = "photon"
vm_guest_os_version = "5.0"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "vmwarePhoton64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "sata"
vm_cpu_count             = 2
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 2048
vm_mem_hot_add           = false
vm_disk_size             = 40960
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path           = "iso/linux/photon"
iso_file           = "photon-5.0-dde71ec57.x86_64.iso"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
```

???+ note
    All `variables.auto.pkrvars.hcl` default to using:

    - [VMware Paravirtual SCSI controller][vmware-pvscsi] storage device
    - [VMXNET 3][vmware-vmxnet3] network card device
    - EFI Secure Boot firmware

[//]: Links
[packer-variables]: https://developer.hashicorp.com/packer/docs/templates/hcl_templates/variables
[vmware-pvscsi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.hostclient.doc/GUID-7A595885-3EA5-4F18-A6E7-5952BFC341CC.html
[vmware-vmxnet3]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AF9E24A8-2CFA-447B-AC83-35D563119667.html
