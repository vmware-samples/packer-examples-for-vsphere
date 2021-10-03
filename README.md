
![Rainpole](icon.png)

# HashiCorp Packer and VMware vSphere to Build Private Cloud Machine Images

<img alt="Last Commit" src="https://img.shields.io/github/last-commit/rainpole/packer-vsphere?style=for-the-badge&logo=github"> [<img alt="The Changelog" src="https://img.shields.io/badge/The%20Changelog-Read-blue?style=for-the-badge&logo=github">](CHANGELOG.md) [<img alt="Open in Visual Studio Code" src="https://img.shields.io/badge/Visual%20Studio%20Code-Open-blue?style=for-the-badge&logo=visualstudiocode">](https://open.vscode.dev/rainpole/packer-vsphere)
<br/>
<img alt="VMware vSphere 7.0 Update 2" src="https://img.shields.io/badge/VMware%20vSphere-7.0%20Update%202-blue?style=for-the-badge">
<img alt="Packer 1.7.6" src="https://img.shields.io/badge/HashiCorp%20Packer-1.7.6-blue?style=for-the-badge&logo=packer">

## Table of Contents
1.	[Introduction](#Introduction)
1.	[Requirements](#Requirements)
1.	[Configuration](#Configuration)
1.	[Build](#Build)
1.	[Troubleshoot](#Troubleshoot)
1.	[Credits](#Credits)

## Introduction

This repository provides examples to automate the creation of virtual machine images and their guest operating systems on VMware vSphere using [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso`). All examples are authored in the HashiCorp Configuration Language ("HCL2").

By default, the machine image artifacts are transferred to a [vSphere Content Library][vsphere-content-library] as an OVF template and the temporary machine image is destroyed. If an item of the same name exists in the target content library, Packer will update the existing item with the new OVF template. This method is extremely useful for vRealize Automation as image mappings do not need to be updated when a virtual machine image update is executed and finalized.

The following builds are available:

**Linux Distributions**
* VMware Photon OS 4
* Ubuntu Server 20.04 LTS
* Ubuntu Server 18.04 LTS
* Red Hat Enterprise Linux 8 Server
* AlmaLinux 8
* Rocky Linux 8
* CentOS Stream 8
* CentOS Linux 8

**Microsoft Windows** - _Core and Desktop Experience_
* Microsoft Windows Server 2022 - Standard and Datacenter
* Microsoft Windows Server 2019 - Standard and Datacenter
* Microsoft Windows Server 2016 - Standard and Datacenter
* Microsoft Windows 10 Professional

> **NOTE**: Guest customization is [**not supported**](https://partnerweb.vmware.com/programs/guestOS/guest-os-customization-matrix.pdf) for AlmaLinux and Rocky Linux in vCenter Server 7.0 Update 2. 

## Requirements

**Packer**:
* HashiCorp [Packer][packer-install] 1.7.6 or higher.
* HashiCorp [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso`) 1.0.1 or higher.
* [Packer Plugin for Windows Updates][packer-plugin-windows-update] 0.14.0 or higher - a community plugin for HashiCorp Packer.

    >Required plugins are automatically downloaded and initialized when using `./build.sh`. For dark sites, you may download the plugins and place these same directory as your Packer executable `/usr/local/bin` or `$HOME/.packer.d/plugins`.

**Operating Systems**:
* Ubuntu Server 20.04 LTS
* macOS Big Sur (Intel)
* Microsoft Windows Server 2019

    > Operating systems and versions tested with the repository examples.

**Additional Software Packages**:
* [Git][download-git] command line tools.
* A command-line .iso creator. Packer will use one of the following:
  - **xorriso** (Ubuntu: `apt-get install xorriso`)
  - **mkisofs** (Ubuntu: `apt-get install mkisofs`)
  - **hdiutil** (macOS)
  - **oscdimg** (Windows: requires Windows ADK)
* Coreutils (macOS `brew install coreutils`)

**Platform**:
* VMware Cloud Foundation 4.2 or higher, or
* VMware vSphere 7.0 Update 2 or higher

## Configuration

### Step 1 - Download the Release.

Download the [**latest**](https://github.com/rainpole/packer-vsphere/releases/latest) release.

You may also clone `main` for the latest pre-release updates.

Example: 
```
git clone https://github.com/rainpole/packer-vsphere.git
```

The directory structure of the repository.

```

├── build.sh
├── config.sh
├── LICENSE
├── NOTICE
├── README.md
├── builds
│   ├── ansible.pkvars.hcl.example
│   ├── build.pkvars.hcl.example
│   ├── common.pkvars.hcl.example
│   ├── proxy.pkvars.hcl.example
│   ├── rhsm.pkvars.hcl.example
│   ├── vsphere.pkvars.hcl.example
│   ├── linux
│   │   └── distribution-version
│   │       ├── *.pkr.hcl
│   │       ├── *.auto.pkrvars.hcl
│   │       └── data
│   │           └── ks.pkrtpl.hcl
│   └── windows
│       └── version
│           ├── *.pkr.hcl
│           ├── *.auto.pkrvars.hcl
│           └── data
│               └── autounattend.pkrtpl.hcl
├── certificates
│   ├── root-ca.crt.example
│   └── root-ca.p7b.example
├── manifests
└── scripts
    ├── linux
    │   └── *.sh
    └── windows
        └── *.ps1
```
The files are distributed in the following directories.
* **`builds`** - contains the build templates, variables, and configuration files.
* **`scripts`** - contains scripts that are used to initialize and prepare the machine image builds.
* **`certificates`** - contains the Trusted Root Authority certificates.
* **`manifests`** - manifests created after the completion of each build.

### Step 2 - Download the Guest Operating Systems ISOs

1. Download the x64 guest operating system [.iso][iso] images.

    **Linux Distributions**
    * VMware Photon OS 4 Server
        * [Download][download-linux-photon-server-4] the latest release of the **FULL** `.iso` image. (_e.g._ `photon-4.0-ca7c9e933.iso`)
    * Ubuntu Server 20.04 LTS
        * [Download][download-linux-ubuntu-server-20-04-lts] the latest **LIVE** release `.iso` image. (_e.g._ `ubuntu-20.04.2-live-server-amd64.iso`)
    * Ubuntu Server 18.04 LTS
        * [Download][download-linux-ubuntu-server-18-04-lts] the latest legacy **NON-LIVE** release `.iso` image. (_e.g._ `ubuntu-18.04.6-server-amd64.iso`)
    * Red Hat Enterprise Linux 8 Server
        * [Download][download-linux-redhat-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `RHEL-8-x86_64-dvd1.iso`) 
    * AlmaLinux 8 Server
        * [Download][download-linux-almalinux-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `AlmaLinux-8-x86_64-dvd1.iso`)
    * Rocky Linux 8 Server
        * [Download][download-linux-rocky-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `Rocky-8-x86_64-dvd1.iso`)
    * CentOS Stream 8 Server
        * [Download][download-linux-centos-stream-8] the latest release of the **FULL** `.iso` image. (_e.g._ `CentOS-Stream-8-x86_64-dvd1.iso`)
    * CentOS Linux 8 Server
        * [Download][download-linux-centos-server-8] the latest release of the **FULL** `.iso` image. (_e.g._ `CentOS-8-x86_64-dvd1.iso`)

    **Microsoft Windows**
    * Microsoft Windows Server 2022
    * Microsoft Windows Server 2019
    * Microsoft Windows Server 2016
    * Microsoft Windows 10 Professional

3. Obtain the checksum type (_e.g._ `sha256`, `md5`, etc.) and checksum value for each guest operating system `.iso` image. This will be use in the build input variables.

4. [Upload][vsphere-upload] your guest operating system `.iso` images to the ISO datastore and paths that will be used in your variables. 

    Example: `builds/<type>/<build>/*.auto.pkvars.hcl`
    ```
    common_iso_datastore = "sfo-w01-cl01-ds-nfs01"
    ```

    Example: `config/common.pkvars.hcl`
    ```
    iso_path           = "iso/linux/photon"
    iso_file           = "photon-4.0-ca7c9e933.iso"
    iso_checksum_type  = "md5"
    iso_checksum_value = "d8c4bc561e68afaf7815518f78a5b4ab"
    ```

### Step 3 - Configure the Variables

The [variables][packer-variables] are defined in `.pkvars.hcl` files.

#### **Copy the Example Variables**

Run the config script `./config.sh` to copy the `.pkvars.hcl.example` files to the `config` directory.

The `config` folder is the default folder for the first argument of these scripts. you may override the default by passing an alternate value as the first argument. 

```
./config.sh foo
./build.sh foo
```
For example, this is useful for the purposes of running machine image builds for different environment.

**San Francisco:** us-west-1

```
./config.sh config/us-west-1
./build.sh config/us-west-1
```

**Los Angeles:** us-west-2

```
./config.sh config/us-west-2
./build.sh config/us-west-2
```

#### **Build Variables**

Edit the `config/build.pkvars.hcl` file to configure the following:

* Credentials for the default account on machine images. 

Example: `config/build.pkvars.hcl`

```
build_username           = "rainpole"
build_password           = "<plaintext_password>"
build_password_encrypted = "<sha512_encrypted_password>"
build_key                = "<public_key>"
```
You can also override the `build_key` value with contents of a file, if required.

For example:

```
build_key = file("${path.root}/config/ssh/build_id_ecdsa.pub")
```

Generate a SHA-512 encrypted password for the  _`build_password_encrypted`_ using various other tools like OpenSSL, mkpasswd, etc.

Example: OpenSSL on macOS:

```
rainpole@macos>  openssl passwd -6 
Password: ***************
Verifying - Password: ***************
[password hash]
```

Example: mkpasswd on Linux:

```
rainpole@linux>  mkpasswd --method=SHA-512 --rounds=4096
Password: ***************
[password hash]
```
Generate a public key for the `build_password_encrypted` for public key authentication.

Example: macOS and Linux.

```
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
>By default, both Public Key Authentication and Password Authentication are enabled for Linux distributions. If you wish to disable Password Authentication and only use Public Key Authentication, comment or remove the portion of the associated script in the `scripts` directory.

#### **Ansible Variables**

Edit the `config/ansible.pkvars.hcl` file to configure the following:

* Credentials for the Ansible account on Linux machine images. 

Example: `config/ansible.pkvars.hcl`

```
ansible_username = "ansible"
ansible_key      = "<public_key>"
```
>**NOTE**: A random password is generated for the Ansible user.

You can also override the `ansible_key` value with contents of a file, if required.

For example:

```
build_key = file("${path.root}/config/ssh/ansible_id_ecdsa.pub")
```

#### **Common Variables**

Edit the `config/common.pkvars.hcl` file to configure the following common variables:

* Virtual Machine Settings
* Template and Content Library Settings
* Removable Media Settings
* Boot and Provisioning Settings

Example: `config/common.pkvars.hcl`

```
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

`http` is the default provisioning data source for Linux machine image builds.

You can change the `common_data_source` from `http` to `disk` to build supported Linux machine images without the need to user Packer's HTTP server. This is useful for environments that may not be able to route back to the system from which Packer is running. Currently, the only `cd_content` is used when selecting `disk`.

> Note: The following Linux distributions do not support kickstart from a secondary CD-ROM.
> - VMware PhotonOS 4
> - Ubuntu Server 18.04 LTS

If you need to define a specific IPv4 address from your host for Packer's HTTP Server, modify the `common_http_ip` variable from `null` to a `string` value. For example:

```
common_http_ip = "172.16.11.254"
```

#### **Proxy Variables**

Edit the `config/proxy.pkvars.hcl` file to configure the following:

* SOCKS proxy settings used for connecting to Linux machine images.
* Credentials for the proxy server (Optional). 

Example: `config/proxy.pkvars.hcl`

```
communicator_proxy_host     = "proxy.rainpole.io"
communicator_proxy_port     = 1080
communicator_proxy_username = "rainpole"
communicator_proxy_password = "<plaintext_password>"
```
#### **Red Hat Subscription Manager Variables**

Edit the `config/redhat.pkvars.hcl` file to configure the following:

* Credentials for your Red Hat Subscription Manager account. 

Example: `config/redhat.pkvars.hcl`

```
rhsm_username = "rainpole"
rhsm_password = "<plaintext_password>"
```

These variables are **only** used if you are performing a Red Hat Enterprise Linux Server build to register the image with Red Hat Subscription Manager and run a `sudo dnf update -y` within the shell provisioner. Before the build completes, the machine image is unregistered from Red Hat Subscription Manager.

#### **vSphere Variables**

Edit the `builds/vsphere.pkvars.hcl` file to configure the following:

* vSphere Endpoint and Credentials
* vSphere Settings

Example: `config/vsphere.pkvars.hcl`

```
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

#### **Machine Image Variables**

Edit the `*.auto.pkvars.hcl` file in each `builds/<type>/<build>` folder to configure the following virtual machine hardware settings, as required:

* CPU Sockets `(init)`
* CPU Cores `(init)`
* Memory in MB `(init)`
* Primary Disk in MB `(init)`
* .iso Path `(string)`
* .iso File `(string)`
* .iso Checksum Type `(string)`
* .iso Checksum Value `(string)`

    >**Note**: All `variables.auto.pkvars.hcl` default to using the [VMware Paravirtual SCSI controller][vmware-pvscsi] and the [VMXNET 3][vmware-vmxnet3] network card device types.

#### **Using Environmental Variables**

Some of the variables may include sensitive information and environmental data that you would prefer not to save to clear text files. You can add these to environmental variables using the example below:

```
export PKR_VAR_ansible_username="<ansible_password>"
export PKR_VAR_ansible_key="<ansible_key>"
export PKR_VAR_build_username="<build_password>"
export PKR_VAR_build_password="<build_password>"
export PKR_VAR_build_password_encrypted="<build_password_encrypted>"
export PKR_VAR_build_key="<build_key>"
export PKR_VAR_communicator_proxy_host = "<communicator_proxy_host>"
export PKR_VAR_communicator_proxy_port = "<communicator_proxy_port>"
export PKR_VAR_communicator_proxy_username = "<communicator_proxy_username>"
export PKR_VAR_communicator_proxy_password = "communicator_proxy_password>"
export PKR_VAR_rhsm_username="<rhsm_password>"
export PKR_VAR_rhsm_password="<rhsm_password>"
export PKR_VAR_vsphere_endpoint="<vsphere_endpoint_fqdn>"
export PKR_VAR_vsphere_username="<vsphere_username>"
export PKR_VAR_vsphere_password="<vsphere_password>"
export PKR_VAR_vsphere_datacenter="<vsphere_datacenter>>"
export PKR_VAR_vsphere_cluster="<vsphere_cluster>"
export PKR_VAR_vsphere_datastore="<vsphere_datastore>>"
export PKR_VAR_vsphere_network="<vsphere_network>"
export PKR_VAR_vsphere_folder="<vsphere_folder>"
```

## Step 4 - Modify the Configurations and Scripts

If required, modify the configuration and scripts files, for the Linux distributions and Microsoft Windows.

### Linux Distribution Kickstart and Scripts

Username and password variables are passed into the kickstart or cloud-init files for each Linux distribution as Packer template files (`.pkrtpl.hcl`) to generate these on-demand.

### Microsoft Windows Unattended amd Scripts

Variables are passed into the [Microsoft Windows][microsoft-windows-unattend] unattend files (`autounattend.xml`) as Packer template files (`autounattend.pkrtpl.hcl`) to generate these on-demand.

By default, each unattended file set the **Product Key** to use the [KMS client setup keys][microsoft-kms].

**Need help customizing the configuration files?**

* **VMware Photon OS** - Read the [Photon OS Kickstart Documentation][photon-kickstart].
* **Ubuntu Server** - Install and run system-config-kickstart on a Ubuntu desktop.

    ```
    sudo apt-get install system-config-kickstart
    ssh -X rainpole@ubuntu-desktop
    sudo system-config-kickstart
    ```
* **Red Hat Enterprise Linux** (_as well as CentOS Linux/Stream, AlmaLinux, and Rocky Linux_) - Use the [Red Hat Kickstart Generator][redhat-kickstart].
* **Microsoft Windows** - Use the Microsoft Windows [Answer File Generator][microsoft-windows-afg] if you need to customize the provided examples further.

### Step 5 - Configure Certificates

Save a copy of your Root Certificate Authority certificate to `/certificates` in `.crt` and `.p7b` formats.

These files are copied to the guest operating systems with a Packer file provisioner; after which, the a shell provisioner adds the certificate to the Trusted Certificate Authority of the guest operating system.

>**NOTE**: If you do not wish to install the certificates on the guest operating systems, comment or remove the portion of the associated script in the `/scripts` directory and the file provisioner from the `prk.hcl` file for each build. If you need to add an intermediate certificate, add the certificate to `/certificates` and update the shell provisioner scripts in the `scripts` directory with your requirements.

## Build

Start a pre-defined build by running the build script (`./build.sh`). The script presents a menu the which simply calls Packer and the respective build(s).

Example: Menu for `./build.sh`.
```
    ____             __                ____        _ __    __     
   / __ \____ ______/ /_____  _____   / __ )__  __(_) /___/ /____ 
  / /_/ / __  / ___/ //_/ _ \/ ___/  / __  / / / / / / __  / ___/ 
 / ____/ /_/ / /__/ ,< /  __/ /     / /_/ / /_/ / / / /_/ (__  )  
/_/    \__,_/\___/_/|_|\___/_/     /_____/\__,_/_/_/\__,_/____/   

  Select a HashiCorp Packer build for VMware vSphere:

      Linux Distribution:

         1  -  VMware Photon OS 4
         2  -  Ubuntu Server 20.04 LTS
         3  -  Ubuntu Server 18.04 LTS
         4  -  Red Hat Enterprise Linux 8 Server
         5  -  AlmaLinux 8 Server
         6  -  Rocky Linux 8 Server
         7  -  CentOS Stream 8 Server
         8  -  CentOS Linux 8 Server

      Microsoft Windows:

         9  -  Windows Server 2022 - All
        10  -  Windows Server 2022 - Standard Only
        11  -  Windows Server 2022 - Datacenter Only
        12  -  Windows Server 2019 - All
        13  -  Windows Server 2019 - Standard Only
        14  -  Windows Server 2019 - Datacenter Only
        15  -  Windows Server 2016 - All
        16  -  Windows Server 2016 - Standard Only
        17  -  Windows Server 2016 - Datacenter Only
        18  -  Windows 10 Professional

      Other:
      
        I   -  Information
        Q   -  Quit
```
You can also start a build based on a specific source for some of the virtual machine images.

For example, if you simply want to build a Microsoft Windows Server 2022 Standard Core, run the following:

Initialize the plugins:
```
rainpole@macos packer-examples> packer init builds/windows/windows-server-2022
```
Build a specific machine image:
```
rainpole@macos windows-server-2022> packer build -force \
      --only vsphere-iso.windows-server-standard-core \
      -var-file="config/vsphere.pkrvars.hcl" \
      -var-file="config/build.pkrvars.hcl" \
      -var-file="config/common.pkrvars.hcl" \
      builds/windows/windows-server-2022
```
Build a specific machine image using environmental variables:
```
rainpole@macos windows-server-2022> packer build -force \
      --only vsphere-iso.windows-server-standard-core \
      -var-file="config/common.pkrvars.hcl" \
      builds/windows/windows-server-2022
```
Happy building!!!

 -- Your friends at rainpole.io.

## Troubleshoot

* Read [Debugging Packer Builds][packer-debug].

## Credits
* Maher AlAsfar [@vmwarelab][credits-maher-alasfar-twitter]

    [Linux][credits-maher-alasfar-github] Bash scripting hints.
    
* Owen Reynolds [@OVDamn][credits-owen-reynolds-twitter]
    
    [VMware Tools for Windows][credits-owen-reynolds-github] installation PowerShell script.

[//]: Links

[cloud-init]: https://cloudinit.readthedocs.io/en/latest/
[credits-maher-alasfar-twitter]: https://twitter.com/vmwarelab
[credits-maher-alasfar-github]: https://github.com/vmwarelab/cloud-init-scripts
[credits-owen-reynolds-twitter]: https://twitter.com/OVDamn
[credits-owen-reynolds-github]: https://github.com/getvpro/Build-Packer/blob/master/Scripts/Install-VMTools.ps1
[download-git]: https://git-scm.com/downloads
[download-linux-almalinux-server-8]: https://mirrors.almalinux.org/isos.html
[download-linux-centos-server-8]: http://isoredirect.centos.org/centos/8/isos/x86_64/
[download-linux-centos-stream-8]: http://isoredirect.centos.org/centos/8-stream/isos/x86_64/
[download-linux-photon-server-4]: https://packages.vmware.com/photon/4.0/
[download-linux-redhat-server-8]: https://access.redhat.com/downloads/content/479/
[download-linux-rocky-server-8]: https://download.rockylinux.org/pub/rocky/8/isos/x86_64/
[download-linux-ubuntu-server-18-04-lts]: http://cdimage.ubuntu.com/ubuntu/releases/18.04.5/release/
[download-linux-ubuntu-server-20-04-lts]: https://releases.ubuntu.com/20.04.1/
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
[vmware-pvscsi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.hostclient.doc/GUID-7A595885-3EA5-4F18-A6E7-5952BFC341CC.html
[vmware-vmxnet3]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AF9E24A8-2CFA-447B-AC83-35D563119667.html
[vsphere-api]: https://code.vmware.com/apis/968
[vsphere-content-library]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-254B2CE8-20A8-43F0-90E8-3F6776C2C896.html
[vsphere-guestosid]: https://vdc-download.vmware.com/vmwb-repository/dcr-public/b50dcbbf-051d-4204-a3e7-e1b618c1e384/538cf2ec-b34f-4bae-a332-3820ef9e7773/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html
[vsphere-efi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-898217D4-689D-4EB5-866C-888353FE241C.html
[vsphere-upload]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.storage.doc/GUID-58D77EA5-50D9-4A8E-A15A-D7B3ABA11B87.html?hWord=N4IghgNiBcIK4AcIHswBMAEAzAlhApgM4gC+QA
