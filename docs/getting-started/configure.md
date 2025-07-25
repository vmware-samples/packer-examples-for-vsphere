---
icon: octicons/gear-24
---

# Configure Your Environment

## Example Variables

The project includes example variables files that you can use as a starting point for your own
configuration.

The [variables][packer-variables] are defined in `.pkrvars.hcl` files.

Run the config script `./config.sh` to copy the `.pkrvars.hcl.example` files to a `config`
directory.

```shell
./config.sh
```

The `config/` folder is the default folder. You can override the default by passing an alternate
value as the first argument.

You can set the region for your configuration and build scripts by passing the region code as an
argument to the scripts. Here are examples for two regions:

1. For San Francisco, CA (`us-west-1`), run:

      ```shell
      ./config.sh us-west-1
      ./build.sh us-west-1
      ```

2. For Los Angeles, CA (`us-west-2`), run:

      ```shell
      ./config.sh us-west-2
      ./build.sh us-west-2
      ```

## Configuration Variables

### Build

Edit the `config/build.pkrvars.hcl` file to configure the credentials for the default account on
machine images.

!!! tip "Example Passwords and Keys."

    Replace the example passwords and keys.

```hcl linenums="1" title="config/build.pkrvars.hcl" hl_lines="1"
--8<-- "./builds/build.pkrvars.hcl.example:10:100"
```

You can also override the `build_key` value with contents of a file.

```hcl title="config/build.pkrvars.hcl"
build_key = file("${path.root}/config/ssh/build_id_ecdsa.pub")
```

Generate a SHA-512 encrypted password for the `build_password_encrypted` using OpenSSL.

```shell
SALT=$(openssl rand -base64 6); \
ENCRYPTED_PASSWORD=$(echo -n "<your_password>" | openssl passwd -6 -stdin -salt $SALT); \
echo "Generated Salt: $SALT"; \
echo "Encrypted Password: $ENCRYPTED_PASSWORD"
```

The following output is displayed:

```shell
Generated Salt: <generated_salt>
Encrypted Password: <encrypted_password>
```

Generate a public key for the `build_key` for public key authentication.

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

The content of the public key, `build_key`, is added the key to the `~/.ssh/authorized_keys` file of
the `build_username` on the Linux guest operating systems.

### Ansible

Edit the `config/ansible.pkrvars.hcl` file to configure the credentials for the Ansible account on
Linux machine images.

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

```hcl linenums="1" title="config/common.pkrvars.hcl" hl_lines="1 6 14 19 24 33"
--8<-- "./builds/common.pkrvars.hcl.example:10:45"
```

### Data Source

The default provisioning data source for Linux machine image builds is `http`. This is used to serve
the kickstart files to the Linux guest operating system during the build.

```hcl title="config/common.pkrvars.hcl"
common_data_source = "http"
```

???+ tip "Firewall"

    Packer includes a built-in HTTP server that is used to serve the kickstart files for Linux
    machine image builds.

    If a firewall is enabled on your Packer host, you will need to open `common_http_port_min` through
    `common_http_port_max` ports.

    :fontawesome-brands-linux: **VMware Photon OS**

       ```shell
       iptables -A INPUT -p tcp --match multiport --dports 8000:8099 -j ACCEPT
       ```

    :fontawesome-brands-ubuntu: **Ubuntu**

       ```shell
       sudo ufw allow 8000:8099/tcp
       sudo ufw reload
       ```

You can change the `common_data_source` from `http` to `disk` to build supported Linux machine
images without the need to use Packer's HTTP server. This is useful for environments that may not be
able to route back to the system from which Packer is running. For example, building a machine image
in VMware Cloud on AWS.

```hcl title="config/common.pkrvars.hcl"
common_data_source = "disk"
```

The Packer plugin's `cd_content` option is used when selecting `disk` unless the distribution does
not support a secondary CD-ROM. For distributions that do not support a secondary CD-ROM the
`floppy_content` option is used.

### HTTP Binding

If you need to define a specific IPv4 address from your host for Packer's built-in HTTP server,
modify the `common_http_ip` variable from `null` to a `string` value that matches an IP address on
your Packer host.

```hcl title="config/common.pkrvars.hcl"
common_http_ip = "172.16.11.254"
```

### Proxy (Optional)

Edit the `config/proxy.pkrvars.hcl` file to configure the following:

```hcl linenums="1" title="config/proxy.pkrvars.hcl" hl_lines="1"
--8<-- "./builds/proxy.pkrvars.hcl.example:10:100"
```

### VMware vSphere

Edit the `builds/vsphere.pkrvars.hcl` file to configure the following:

```hcl linenums="1" title="config/vsphere.pkrvars.hcl" hl_lines="1 7"
--8<-- "./builds/vsphere.pkrvars.hcl.example:10:42"
```

???- note "vSphere Distributed Resource Scheduler Disabled or Standalone ESXi Hosts"

    When targeting standalone ESXi hosts or vSphere clusters with vSphere DRS disabled, you must
    set the `vsphere_host` variable.

    **Example** (vSphere Clusters with vSphere DRS Disabled):

    ```hcl title="config/vsphere.pkrvars.hcl"
    ...
    vsphere_datacenter = "sfo-w01-dc01"
    vsphere_cluster    = "sfo-w01-cl01"
    vsphere_host       = "sfo-w01-esx01"
    vsphere_folder     = "sfo-w01-fd-templates"
    ...
    ```

    **Example** (Standalone ESXi Host Managed by vCenter Server):

    For a standalone ESXi host, managed by vCenter Server, comment or remove `vsphere_cluster`.

    ```hcl title="config/vsphere.pkrvars.hcl"
    ...
    vsphere_datacenter = "sfo-w01-dc01"
    //vsphere_cluster  = "sfo-w01-cl01"
    vsphere_host       = "sfo-w01-esx01"
    vsphere_folder     = "sfo-w01-fd-templates"
    vsphere_datacenter = "sfo-w01-dc01"
    //vsphere_cluster  = "sfo-w01-cl01"
    vsphere_host       = "sfo-w01-esx01"
    vsphere_folder     = "sfo-w01-fd-templates"
    ```

### Machine Images

Edit each `config/<type>-<build>-<version>.pkrvars.hcl` files to configure the following virtual
machine hardware settings, as required:

```hcl linenums="1" title="config/linux-photon-5.pkrvars.hcl" hl_lines="1 5 8 11"
--8<-- "./builds/linux/photon/5/linux-photon.pkrvars.hcl.example:10:100"
```

???+ note

    All `variables.auto.pkrvars.hcl` default to using:

    - [VMware Paravirtual SCSI controller][vmware-pvscsi] storage device
    - [VMXNET 3][vmware-vmxnet3] network card device
    - EFI Secure Boot firmware
    - Cloud Init
    - CD-ROM Type
    - CD-ROM Count
    - CPU Core and Count
    - Memory size
    - Disk Drive Size
    - Communicator Port (22 SSH, 5985 RDP)

### Linux Specific

#### Additional Packages

Edit the `config/linux-<build>-<version>.pkrvars.hcl` file to configure the additional packages to
be installed on the Linux guest operating system during the build.

```hcl title="config/linux-ubuntu.pkrvars.hcl"
// Additional Settings
additional_packages = ["git", "make", "vim"]
```

#### Red Hat Subscription Manager

Edit the `config/redhat.pkrvars.hcl` file to configure the credentials for your Red Hat Subscription
Manager account.

```hcl linenums="1" title="config/rhsm.pkrvars.hcl" hl_lines="1"
--8<-- "./builds/rhsm.pkrvars.hcl.example:10:100"
```

These variables are **only** used if you are performing a Red Hat Enterprise Linux Server build and
are used to register the image with Red Hat Subscription Manager during the build for system updates
and package installation.

Before the build completes, the machine image is unregistered from Red Hat Subscription Manager.

#### SUSE Customer Connect

Edit the `config/scc.pkrvars.hcl` file to configure the following credentials for your SUSE Customer
Connect account.

```hcl linenums="1" title="config/scc.pkrvars.hcl" hl_lines="1"
--8<-- "./builds/scc.pkrvars.hcl.example:10:100"
```

These variables are **only** used if you are performing a SUSE Linux Enterprise Server build and are
used to register the image with SUSE Customer Connect during the build for system updates and
package installation.

Before the build completes, the machine image is unregistered from SUSE Customer Connect.

#### Network Customization

!!! note

    Static IP assignment is available for certain Linux machine images.

    For details on which distributions are compatible, please refer to the [Linux Distributions]
    table.

Edit the `config/network.pkrvars.hcl` file to configure a static IP address:

- IPv4 address, netmask, and gateway.
- DNS list.

By default, the network is set to use DHCP for its configuration.

```hcl title="config/network.pkrvars.hcl"
vm_ip_address = "172.16.100.192"
vm_ip_netmask = 24
vm_ip_gateway = "172.16.100.1"
vm_dns_list   = [ "172.16.11.4", "172.16.11.5" ]
```

#### Storage Customization

!!! note

    Storage settings are available for certain Linux machine images.

    For details on which distributions are compatible, please refer to the [Linux Distributions]
    table.

Edit the `config/linux-storage.pkrvars.hcl` file to configure a partitioning scheme:

- Disk device and whether to use a swap partition.
- Disk partitions and related settings.
- Logical volumes and related settings (optional).

```hcl linenums="1" title="config/linux-storage.pkrvars.hcl" hl_lines="1"
--8<-- "./builds/linux-storage.pkrvars.hcl.example:10:100"
```

???+ note

    Setting `size = -1` can also be used for the last partition (Logical Volume) of `vm_disk_lvm` so
    that it fills the remaining space of the Volume Group.

[//]: Links
[packer-variables]: https://developer.hashicorp.com/packer/docs/templates/hcl_templates/variables
[vmware-pvscsi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.hostclient.doc/GUID-7A595885-3EA5-4F18-A6E7-5952BFC341CC.html
[vmware-vmxnet3]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AF9E24A8-2CFA-447B-AC83-35D563119667.html
[Linux Distributions]: ../index.md#linux-distributions
