# HashiCorp Packer and VMware vSphere to Build Private Cloud Machine Images

<img alt="Last Commit" src="https://img.shields.io/github/last-commit/vmware-samples/packer-examples-for-vsphere?style=for-the-badge&logo=github"> [<img alt="The Changelog" src="https://img.shields.io/badge/The%20Changelog-Read-blue?style=for-the-badge&logo=github">](CHANGELOG.md) [<img alt="Open in Visual Studio Code" src="https://img.shields.io/badge/Visual%20Studio%20Code-Open-blue?style=for-the-badge&logo=visualstudiocode">](https://open.vscode.dev/vmware-samples/packer-examples-for-vsphere)
<br/>
<img alt="VMware vSphere 7.0 Update 2+" src="https://img.shields.io/badge/VMware%20vSphere-7.0%20Update%202+-blue?style=for-the-badge">
<img alt="Packer 1.8.0+" src="https://img.shields.io/badge/HashiCorp%20Packer-1.8.0+-blue?style=for-the-badge&logo=packer">
<img alt="Ansible 2.9+" src="https://img.shields.io/badge/Ansible-2.9+-blue?style=for-the-badge&logo=ansible">

## Table of Contents
1. [Introduction](#Introduction)
2. [Requirements](#Requirements)
3. [Configuration](#Configuration)
4. [Build](#Build)
5. [Troubleshoot](#Troubleshoot)
6. [Credits](#Credits)

## Introduction

This repository provides infrastructure-as-code examples to automate the creation of virtual machine images and their guest operating systems on VMware vSphere using [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso`). All examples are authored in the HashiCorp Configuration Language ("HCL2").

Use of this project is mentioned in the **_VMware Validated Solution: Private Cloud Automation for VMware Cloud Foundation_** authored by the maintainer. Learn more about this solution at [vmware.com/go/vvs](https://vmware.com/go/vvs).

By default, the machine image artifacts are transferred to a [vSphere Content Library][vsphere-content-library] as an OVF template and the temporary machine image is destroyed. If an item of the same name exists in the target content library, Packer will update the existing item with the new version of OVF template.

The following builds are available:

**Linux Distributions**
* VMware Photon OS 4
* Ubuntu Server 20.04 LTS
* Ubuntu Server 18.04 LTS
* Red Hat Enterprise Linux 8 Server
* Red Hat Enterprise Linux 7 Server
* AlmaLinux OS 8
* Rocky Linux 8
* CentOS Stream 8
* CentOS Linux 8
* CentOS Linux 7

**Microsoft Windows** - _Core and Desktop Experience_
* Microsoft Windows Server 2022 - Standard and Datacenter
* Microsoft Windows Server 2019 - Standard and Datacenter
* Microsoft Windows Server 2016 - Standard and Datacenter
* Microsoft Windows 11
* Microsoft Windows 10

> **NOTES**:
> * Guest customization is not currently supported for AlmaLinux OS and Rocky Linux in vCenter Server 7.0 Update 2.
>
> * The Microsoft Windows 11 machine image uses a virtual trusted platform module (vTPM). Refer to the VMware vSphere [product documenation][vsphere-tpm] for requirements and pre-requisites.
>
> * The Microsoft Windows 11 machine image is not transferred to the content library by default. It is **not supported** to clone an encrypted virtual machine to the content library as an OVF Template. You can adjust the common content library settings to use VM Templates.

## Requirements

**Packer**:
* HashiCorp [Packer][packer-install] 1.8.0 or higher.
* HashiCorp [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso`) 1.0.3 or higher.
* [Packer Plugin for Windows Updates][packer-plugin-windows-update] 0.14.0 or higher - a community plugin for HashiCorp Packer.

    > Required plugins are automatically downloaded and initialized when using `./build.sh`. For dark sites, you may download the plugins and place these same directory as your Packer executable `/usr/local/bin` or `$HOME/.packer.d/plugins`.

**Operating Systems**:
* Ubuntu Server 20.04 LTS
* macOS Big Sur and Monterey (Intel)

    > Operating systems and versions tested with the project.

**Additional Software Packages**:

The following software packages must be installed on the Packer host:

* [Git][download-git] command-line tools.
  - Ubuntu: `apt-get install git`
  - macOS: `brew install git`
* [Ansible][ansible-docs] 2.9 or higher.
  - Ubuntu: `apt-get install ansible`
  - macOS: `brew install ansible`
* A command-line .iso creator. Packer will use one of the following:
  - **xorriso** on Ubuntu: `apt-get install xorriso`
  - **mkisofs** on Ubuntu: `apt-get install mkisofs`
  - **hdiutil** on macOS: native
* mkpasswd
  - Ubuntu: `apt-get install whois`
  - macOS: `brew install --cask docker`
* Coreutils
  - macOS: `brew install coreutils`
* HashiCorp [Terraform][terraform-install] 1.1.7 or higher.
  - Ubuntu:
    - `sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl`
    - `curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`
    - `sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`
    - `sudo apt-get update && sudo apt-get install terraform`
  - macOS:
    - `brew tap hashicorp/tap`
    - `brew install hashicorp/tap/terraform`

**Platform**:
* VMware Cloud Foundation 4.2 or higher, or
* VMware vSphere 7.0 Update 2 or higher

## Configuration

### Step 1 - Download the Release

Download the [**latest**](https://github.com/vmware-samples/packer-examples-for-vsphere/releases/latest) release.

You may also clone `main` for the latest prerelease updates.

> ⚠️ *WARNING*: Do *not* fork the project and make changes to your fork that may expose your sensitive information.

**Example**:

```console
git clone https://github.com/vmware-samples/packer-examples-for-vsphere.git
```

The directory structure of the repository.

```console
├── build.sh
├── config.sh
├── set-envvars.sh
├── LICENSE
├── NOTICE
├── README.md
├── ansible
│   ├── roles
│   │   └── <role>
│   │       ├── defaults
│   │       │   └── main.yml
│   │       ├── files
│   │       │   └── root-ca.cer.example
│   │       ├── handlers
│   │       │   └── main.yml
│   │       ├── meta
│   │       │   └── main.yml
│   │       ├── tasks
│   │       │   └── main.yml
│   │       │   └── *.yml
│   │       └── vars
│   │           └── main.yml
│   ├── ansible.cfg
│   └── main.yml
├── builds
│   ├── ansible.pkvars.hcl.example
│   ├── build.pkvars.hcl.example
│   ├── common.pkvars.hcl.example
│   ├── proxy.pkvars.hcl.example
│   ├── rhsm.pkvars.hcl.example
│   ├── vsphere.pkvars.hcl.example
│   ├── linux
│   │   └── <distribution>
│   │       └── <version>
│   │           ├── *.pkr.hcl
│   │           ├── *.auto.pkrvars.hcl
│   │           └── data
│   │               └── ks.pkrtpl.hcl
│   └── windows
│       └── <distribution>
│           └── <version>
│               ├── *.pkr.hcl
│               ├── *.auto.pkrvars.hcl
│               └── data
│                   └── autounattend.pkrtpl.hcl
├── certificates
│   └── root-ca.cer.example
├── manifests
├── scripts
│   └── windows
│       └── *.ps1
└── terraform
    │── vsphere-role
    └── vsphere-virtual-machine
```

The files are distributed in the following directories.
* **`ansible`** - contains the Ansible roles to prepare a Linux machine image build.
* **`builds`** - contains the templates, variables, and configuration files for the machine image build.
* **`scripts`** - contains the scripts to initialize and prepare a Windows machine image build.
* **`certificates`** - contains the Trusted Root Authority certificates for a Windows machine image build.
* **`manifests`** - manifests created after the completion of the machine image build.
* **`terraform`** - contains example Terraform plans to test machine image builds.

> **NOTE**: The project is transitioning to use Ansible role instead of scripts, where possible.

### Step 2 - Download the Guest Operating Systems ISOs

1. Download the x64 guest operating system [.iso][iso] images.

    **Linux Distributions**
    * VMware Photon OS 4 Server
        * [Download][download-linux-photon-server-4] the 4.0 Rev2 release of the **FULL** `.iso` image. (_e.g._ `photon-4.0-xxxxxxxxx.iso`)
    * Ubuntu Server 20.04 LTS
        * [Download][download-linux-ubuntu-server-20-04-lts] the latest **LIVE** release `.iso` image. (_e.g._ `ubuntu-20.04.x-live-server-amd64.iso`)
    * Ubuntu Server 18.04 LTS
        * [Download][download-linux-ubuntu-server-18-04-lts] the latest legacy **NON-LIVE** release `.iso` image. (_e.g._ `ubuntu-18.04.x-server-amd64.iso`)
    * Red Hat Enterprise Linux 8 Server
        * [Download][download-linux-redhat-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `rhel-8.x-x86_64-dvd1.iso`)
    * Red Hat Enterprise Linux 7 Server
        * [Download][download-linux-redhat-server-7] the latest release of the **FULL** `.iso` image. (_e.g._ `rhel-server-7.x-x86_64-dvd1.iso`)
    * AlmaLinux OS 8
        * [Download][download-linux-almalinux-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `AlmaLinux-8.x-x86_64-dvd1.iso`)
    * Rocky Linux 8
        * [Download][download-linux-rocky-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `Rocky-8.x-x86_64-dvd1.iso`)
    * CentOS Stream 8
        * [Download][download-linux-centos-stream-8] the latest release of the **FULL** `.iso` image. (_e.g._ `CentOS-Stream-8-x86_64-latest-dvd1.iso`)
    * CentOS Linux 8
        * [Download][download-linux-centos-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `CentOS-8.x.xxxx-x86_64-dvd1.iso`)
    * CentOS Linux 7
        * [Download][download-linux-centos-server-7] the latest release of the **FULL** `.iso` image. (_e.g._ `CentOS-7-x86_64-DVD.iso`)

    **Microsoft Windows**
    * Microsoft Windows Server 2022
    * Microsoft Windows Server 2019
    * Microsoft Windows Server 2016
    * Microsoft Windows 11
    * Microsoft Windows 10

3. Obtain the checksum type (_e.g._ `sha256`, `md5`, etc.) and checksum value for each guest operating system `.iso` image from the vendor. This will be use in the build input variables.

4. [Upload][vsphere-upload] your guest operating system `.iso` images to the ISO datastore and paths that will be used in your variables.

    **Example**: `builds/<type>/<build>/*.auto.pkvars.hcl`

    ```hcl
    common_iso_datastore = "sfo-w01-cl01-ds-nfs01"
    ```

    **Example**: `config/common.pkvars.hcl`

    ```hcl
    iso_path           = "iso/linux/photon"
    iso_file           = "photon-4.0-xxxxxxxxx.iso"
    iso_checksum_type  = "md5"
    iso_checksum_value = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    ```

### Step 3 - Configure Service Account Privileges in vSphere

Create a custom vSphere role with the required privileges to integrate HashiCorp Packer with VMware vSphere. A service account can be added to the role to ensure that Packer has least privilege access to the infrastructure. Clone the default **Read-Only** vSphere role and add the following privileges:

Category        | Privilege                                           | Reference
----------------|-----------------------------------------------------|---------
Content Library | Add library item                                    | `ContentLibrary.AddLibraryItem`
 ...            | Update Library Item                                 | `ContentLibrary.UpdateLibraryItem`
Datastore       | Allocate space                                      | `Datastore.AllocateSpace`
...             | Browse datastore                                    | `Datastore.Browse`
...             | Low level file operations                           | `Datastore.Browse`
Network         | Assign network                                      | `Network.Assign`
Resource        | Assign virtual machine to resource pool             | `Resource.AssignVMToPool`
vApp            | Export                                              | `vApp.Export`
Virtual Machine | Configuration > Add new disk                        | `VirtualMachine.Config.AddNewDisk`
...             | Configuration > Add or remove device                | `VirtualMachine.Config.AddRemoveDevice`
...             | Configuration > Advanced configuration              | `VirtualMachine.Config.AdvancedConfig`
...             | Configuration > Change CPU count                    | `VirtualMachine.Config.CPUCount`
...             | Configuration > Change memory                       | `VirtualMachine.Config.Memory`
...             | Configuration > Change settings                     | `VirtualMachine.Config.Settings`
...             | Configuration > Change Resource                     | `VirtualMachine.Config.Resource`
...             | Configuration > Set annotation                      | `VirtualMachine.Config.Annotation`
...             | Edit Inventory > Create from existing               | `VirtualMachine.Inventory.CreateFromExisting`
...             | Edit Inventory > Create new                         | `VirtualMachine.Inventory.Create`
...             | Edit Inventory > Remove                             | `VirtualMachine.Inventory.Delete`
...             | Interaction > Configure CD media                    | `VirtualMachine.Interact.SetCDMedia`
...             | Interaction > Configure floppy media                | `VirtualMachine.Interact.SetFloppyMedia`
...             | Interaction > Connect devices                       | `VirtualMachine.Interact.DeviceConnection`
...             | Interaction > Inject USB HID scan codes             | `VirtualMachine.Interact.PutUsbScanCodes`
...             | Interaction > Power off                             | `VirtualMachine.Interact.PowerOff`
...             | Interaction > Power on                              | `VirtualMachine.Interact.PowerOn`
...             | Provisioning > Create template from virtual machine | `VirtualMachine.Provisioning.CreateTemplateFromVM`
...             | Provisioning > Mark as template                     | `VirtualMachine.Provisioning.MarkAsTemplate`
...             | Provisioning > Mark as virtual machine              | `VirtualMachine.Provisioning.MarkAsVM`
...             | State > Create snapshot                             | `VirtualMachine.State.CreateSnapshot`

If you would like to automate the creation of the custom vSphere role, a Terraform example is included in the project.

1. Navigate to the directory for the example.

```console
cd terraform/vsphere-role
```

2. Duplicate the `terraform.tfvars.example` file to `terraform.tfvars` in the directory.

```console
cp terraform.tfvars.example terraform.tfvars
```

3. Open the `terraform.tfvars` file and update the variables according to your environment.

4. Initialize the current directory and the required Terraform provider for VMware vSphere.

```console
terraform init
```

5. Create a Terraform plan and save the output to a file.

```console
terraform plan -out=tfplan
```

6. Apply the Terraform plan.

```console
terraform apply tfplan
```

Once the custom vSphere role is created, assign **Global Permissions** in vSphere for the service account used for the HashiCorp Packer to VMware vSphere integration. Global permissions are required for the content library. For example:

1. Log in to the vCenter Server at _<management_vcenter_server_fqdn>/ui_ as `administrator@vsphere.local`.
2. Select **Menu** > **Administration**.
3. In the left pane, select **Access control** > **Global permissions** and click the **Add permissions** icon.
4. In the **Add permissions** dialog box, enter the service account (_e.g._ svc-packer-vsphere@rainpole.io), select the custom role (_e.g._ Packer to vSphere Integration Role) and the **Propagate to children** check box, and click OK.

In an environment with many vCenter Server instances, such as management and workload domains, you may wish to further reduce the scope of access across the infrastructure in vSphere for the service account. For example, if you do not want Packer to have access to your management domain, but only allow access to workload domains:

1. From the **Hosts and clusters** inventory, select management domain vCenter Server to restrict scope, and click the **Permissions** tab.
2. Select the service account with the custom role assigned and click the **Change role** icon.
3. In the **Change role** dialog box, from the **Role** drop-down menu, select **No Access**, select the **Propagate to children** check box, and click **OK**.

### Step 4 - Configure the Variables

The [variables][packer-variables] are defined in `.pkvars.hcl` files.

#### **Copy the Example Variables**

Run the config script `./config.sh` to copy the `.pkvars.hcl.example` files to the `config` directory.

The `config` folder is the default folder, You may override the default by passing an alternate value as the first argument.

```console
./config.sh foo
./build.sh foo
```
For example, this is useful for the purposes of running machine image builds for different environment.

**San Francisco:** us-west-1

```console
./config.sh config/us-west-1
./build.sh config/us-west-1
```

**Los Angeles:** us-west-2

```console
./config.sh config/us-west-2
./build.sh config/us-west-2
```

##### Build Variables

Edit the `config/build.pkvars.hcl` file to configure the following:

* Credentials for the default account on machine images.

**Example**: `config/build.pkvars.hcl`

```hcl
build_username           = "rainpole"
build_password           = "<plaintext_password>"
build_password_encrypted = "<sha512_encrypted_password>"
build_key                = "<public_key>"
```
You can also override the `build_key` value with contents of a file, if required.

For example:

```hcl
build_key = file("${path.root}/config/ssh/build_id_ecdsa.pub")
```

Generate a SHA-512 encrypted password for the `build_password_encrypted` using tools like mkpasswd.

**Example**: mkpasswd using Docker on macOS:

```console
rainpole@macos>  docker run -it --rm alpine:latestvmwar mkpasswd -m sha512
Password: ***************
[password hash]
```

**Example**: mkpasswd on Linux:

```console
rainpole@linux>  mkpasswd -m sha-512
Password: ***************
[password hash]
```
Generate a public key for the `build_key` for public key authentication.

**Example**: macOS and Linux.

```console
rainpole@macos> cd .ssh/
rainpole@macos ~/.ssh> ssh-keygen -t ecdsa -b 521 -C "code@rainpole.io"
Generating public/private ecdsa key pair.
Enter file in which to save the key (/Users/rainpole/.ssh/id_ecdsa):
Enter passphrase (empty for no passphrase): **************
Enter same passphrase again: **************
Your identification has been saved in /Users/rainpole/.ssh/id_ecdsa.
Your public key has been saved in /Users/rainpole/.ssh/id_ecdsa.pub.
```

The content of the public key, `build_key`, is added the key to the `.ssh/authorized_keys` file of the `build_username` on the guest operating system.

>**WARNING**: Replace the default public keys and passwords.
>By default, both Public Key Authentication and Password Authentication are enabled for Linux distributions. If you wish to disable Password Authentication and only use Public Key Authentication, comment or remove the portion of the associated Ansible `configure` role.

##### Ansible Variables

Edit the `config/ansible.pkvars.hcl` file to configure the following:

* Credentials for the Ansible account on Linux machine images.

**Example**: `config/ansible.pkvars.hcl`

```hcl
ansible_username = "ansible"
ansible_key      = "<public_key>"
```
>**NOTE**: A random password is generated for the Ansible user.

You can also override the `ansible_key` value with contents of a file, if required.

For example:

```hcl
ansible_key = file("${path.root}/config/ssh/ansible_id_ecdsa.pub")
```

##### Common Variables

Edit the `config/common.pkvars.hcl` file to configure the following common variables:

* Virtual Machine Settings
* Template and Content Library Settings
* Removable Media Settings
* Boot and Provisioning Settings

**Example**: `config/common.pkvars.hcl`

```hcl
// Virtual Machine Settings
common_vm_version           = 19
common_tools_upgrade_policy = true
common_remove_cdrom         = true

// Template and Content Library Settings
common_template_conversion     = false
common_content_library_name    = "sfo-w01-lib01"
common_content_library_ovf     = true
common_content_library_destroy = true

// Removable Media Settings
common_iso_datastore = "sfo-w01-cl01-ds-nfs01"

// Boot and Provisioning Settings
common_data_source      = "http"
common_http_ip          = null
common_http_port_min    = 8000
common_http_port_max    = 8099
common_ip_wait_timeout  = "20m"
common_shutdown_timeout = "15m"
```

##### Data Source Options

`http` is the default provisioning data source for Linux machine image builds.

You can change the `common_data_source` from `http` to `disk` to build supported Linux machine images without the need to use Packer's HTTP server. This is useful for environments that may not be able to route back to the system from which Packer is running.

The `cd_content` option is used when selecting `disk` unless the distribution does not support a secondary CD-ROM. For distributions that do not support a secondary CD-ROM the `floppy_content` option is used.

```hcl
common_data_source = "disk"
```

##### HTTP Binding

If you need to define a specific IPv4 address from your host for Packer's HTTP Server, modify the `common_http_ip` variable from `null` to a `string` value that matches an IP address on your Packer host. For example:

```hcl
common_http_ip = "172.16.11.254"
```

##### Proxy Variables (Optional)

Edit the `config/proxy.pkvars.hcl` file to configure the following:

* SOCKS proxy settings used for connecting to Linux machine images.
* Credentials for the proxy server.

**Example**: `config/proxy.pkvars.hcl`

```hcl
communicator_proxy_host     = "proxy.rainpole.io"
communicator_proxy_port     = 1080
communicator_proxy_username = "rainpole"
communicator_proxy_password = "<plaintext_password>"
```
##### Red Hat Subscription Manager Variables

Edit the `config/redhat.pkvars.hcl` file to configure the following:

* Credentials for your Red Hat Subscription Manager account.

**Example**: `config/redhat.pkvars.hcl`

```hcl
rhsm_username = "rainpole"
rhsm_password = "<plaintext_password>"
```

These variables are **only** used if you are performing a Red Hat Enterprise Linux Server build and are used to register the image with Red Hat Subscription Manager during the build for system updates and package installation. Before the build completes, the machine image is unregistered from Red Hat Subscription Manager.

##### vSphere Variables

Edit the `builds/vsphere.pkvars.hcl` file to configure the following:

* vSphere Endpoint and Credentials
* vSphere Settings

**Example**: `config/vsphere.pkvars.hcl`

```hcl
vsphere_endpoint             = "sfo-w01-vc01.sfo.rainpole.io"
vsphere_username             = "svc-packer-vsphere@rainpole.io"
vsphere_password             = "<plaintext_password>"
vsphere_insecure_connection  = true
vsphere_datacenter           = "sfo-w01-dc01"
vsphere_cluster              = "sfo-w01-cl01"
vsphere_datastore            = "sfo-w01-cl01-ds-vsan01"
vsphere_network              = "sfo-w01-seg-dhcp"
vsphere_folder               = "sfo-w01-fd-templates"
```
#### **Using Environment Variables**

Alternatively, you can set your environment variables if you would prefer not to save sensitive potentially information in cleartext files. You can add these to environmental variables using the included `set-envvars.sh` script:

```console
rainpole@macos> . ./set-envvars.sh
```

> **NOTE**: You need to run the script as source or the shorthand "`.`".

#### **Machine Image Variables**

Edit the `*.auto.pkvars.hcl` file in each `builds/<type>/<build>` folder to configure the following virtual machine hardware settings, as required:

* CPU Sockets `(int)`
* CPU Cores `(int)`
* Memory in MB `(int)`
* Primary Disk in MB `(int)`
* .iso Path `(string)`
* .iso File `(string)`
* .iso Checksum Type `(string)`
* .iso Checksum Value `(string)`

    >**Note**: All `variables.auto.pkvars.hcl` default to using the [VMware Paravirtual SCSI controller][vmware-pvscsi] and the [VMXNET 3][vmware-vmxnet3] network card device types.


### Step 5 - Modify the Configurations (Optional)

If required, modify the configuration files for the Linux distributions and Microsoft Windows.

#### Linux Distribution Kickstart and Ansible Roles

Username and password variables are passed into the kickstart or cloud-init files for each Linux distribution as Packer template files (`.pkrtpl.hcl`) to generate these on-demand. Ansible roles are then used to configure the Linux machine image builds.

#### Microsoft Windows Unattended amd Scripts

Variables are passed into the [Microsoft Windows][microsoft-windows-unattend] unattend files (`autounattend.xml`) as Packer template files (`autounattend.pkrtpl.hcl`) to generate these on-demand. A PowerShell script is then used to configure the Linux machine image builds.

By default, each unattended file is set to use the [KMS client setup keys][microsoft-kms] as the **Product Key**.

**Need help customizing the configuration files?**

* **VMware Photon OS** - Read the [Photon OS Kickstart Documentation][photon-kickstart].
* **Ubuntu Server** - Install and run system-config-kickstart on a Ubuntu desktop.

    ```console
    sudo apt-get install system-config-kickstart
    ssh -X rainpole@ubuntu-desktop
    sudo system-config-kickstart
    ```
* **Red Hat Enterprise Linux** (_as well as CentOS Linux/Stream, AlmaLinux OS, and Rocky Linux_) - Use the [Red Hat Kickstart Generator][redhat-kickstart].
* **Microsoft Windows** - Use the Microsoft Windows [Answer File Generator][microsoft-windows-afg] if you need to customize the provided examples further.

### Step 6 - Add Certificates

Save a copy of your PEM encoded Root Certificate Authority certificate to the following in `.cer` format.
- `/ansible/roles/base/files` for Linux machine images.
- `/certificates` for Windows machine images.

These files are copied to the guest operating systems and added the certificate to the Trusted Certificate Authority of the guest operating system. Linux distributions uses the Ansible provisioner, but Windows still uses the shell provisioner at this time.

## Build

### Build with Variables Files

Start a build by running the build script (`./build.sh`). The script presents a menu the which simply calls Packer and the respective build(s).

You can also start a build based on a specific source for some of the virtual machine images.

For example, if you simply want to build a Microsoft Windows Server 2022 Standard Core, run the following:

Initialize the plugins:

```console
rainpole@macos> packer init builds/windows/server/2022/.
```

Build a specific machine image:

```console
rainpole@macos> packer build -force \
      --only vsphere-iso.windows-server-standard-core \
      -var-file="config/vsphere.pkrvars.hcl" \
      -var-file="config/build.pkrvars.hcl" \
      -var-file="config/common.pkrvars.hcl" \
      builds/windows/server/2022
```

### Build with Environmental Variables

Initialize the plugins:

```console
rainpole@macos> packer init builds/windows/server/2022/.
```

Build a specific machine image using environmental variables:

```console
rainpole@macos> packer build -force \
      --only vsphere-iso.windows-server-standard-core \
      builds/windows/server/2022
```

Happy building!!!

## Troubleshoot

* Read [Debugging Packer Builds][packer-debug].

## Credits
* Owen Reynolds [@OVDamn][credits-owen-reynolds-twitter]

    [VMware Tools for Windows][credits-owen-reynolds-github] installation PowerShell script.

[//]: Links

[ansible-docs]: https://docs.ansible.com
[cloud-init]: https://cloudinit.readthedocs.io/en/latest/
[credits-owen-reynolds-twitter]: https://twitter.com/OVDamn
[credits-owen-reynolds-github]: https://github.com/getvpro/Build-Packer/blob/master/Scripts/Install-VMTools.ps1
[download-git]: https://git-scm.com/downloads
[download-linux-almalinux-server-8]: https://mirrors.almalinux.org/isos.html
[download-linux-centos-server-7]: http://isoredirect.centos.org/centos/7/isos/x86_64/
[download-linux-centos-server-8]: http://isoredirect.centos.org/centos/8/isos/x86_64/
[download-linux-centos-stream-8]: http://isoredirect.centos.org/centos/8-stream/isos/x86_64/
[download-linux-photon-server-4]: https://packages.vmware.com/photon/4.0/
[download-linux-redhat-server-8]: https://access.redhat.com/downloads/content/479/
[download-linux-redhat-server-7]: https://access.redhat.com/downloads/content/69/
[download-linux-rocky-server-8]: https://download.rockylinux.org/pub/rocky/8/isos/x86_64/
[download-linux-ubuntu-server-18-04-lts]: http://cdimage.ubuntu.com/ubuntu/releases/18.04.5/release/
[download-linux-ubuntu-server-20-04-lts]: https://releases.ubuntu.com/20.04/
[hashicorp]: https://www.hashicorp.com/
[iso]: https://en.wikipedia.org/wiki/ISO_image
[microsoft-kms]: https://docs.microsoft.com/en-us/windows-server/get-started/kmsclientkeys
[microsoft-windows-afg]: https://www.windowsafg.com
[microsoft-windows-autologon]: https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-autologon-password-value
[microsoft-windows-unattend]: https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/
[packer]: https://www.packer.io
[packer-debug]: https://www.packer.io/docs/debugging
[packer-install]: https://www.packer.io/intro/getting-started/install.html
[packer-plugin-vsphere]: https://www.packer.io/docs/builders/vsphere/vsphere-iso
[packer-plugin-windows-update]: https://github.com/rgl/packer-plugin-windows-update
[packer-variables]: https://www.packer.io/docs/templates/hcl_templates/variables
[photon-kickstart]: https://vmware.github.io/photon/docs/user-guide/kickstart-through-http/packer-template/
[redhat-kickstart]: https://access.redhat.com/labs/kickstartconfig/
[ssh-keygen]: https://www.ssh.com/ssh/keygen/
[terraform-install]: https://www.terraform.io/docs/cli/install/apt.html
[vmware-pvscsi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.hostclient.doc/GUID-7A595885-3EA5-4F18-A6E7-5952BFC341CC.html
[vmware-vmxnet3]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AF9E24A8-2CFA-447B-AC83-35D563119667.html
[vsphere-api]: https://code.vmware.com/apis/968
[vsphere-content-library]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-254B2CE8-20A8-43F0-90E8-3F6776C2C896.html
[vsphere-guestosid]: https://vdc-download.vmware.com/vmwb-repository/dcr-public/b50dcbbf-051d-4204-a3e7-e1b618c1e384/538cf2ec-b34f-4bae-a332-3820ef9e7773/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html
[vsphere-efi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-898217D4-689D-4EB5-866C-888353FE241C.html
[vsphere-upload]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.storage.doc/GUID-58D77EA5-50D9-4A8E-A15A-D7B3ABA11B87.html?hWord=N4IghgNiBcIK4AcIHswBMAEAzAlhApgM4gC+QA
[vsphere-tpm]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-4DBF65A4-4BA0-4667-9725-AE9F047DE00A.html
