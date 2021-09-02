
![Rainpole](icon.png)

# HashiCorp Packer and VMware vSphere to Build Private Cloud Machine Images

<img alt="Last Commit" src="https://img.shields.io/github/last-commit/rainpole/packer-vsphere?style=for-the-badge&logo=github"> [<img alt="Changelog" src="https://img.shields.io/badge/Changelog-Read-blue?style=for-the-badge&logo=github">](CHANGELOG.md) [<img alt="Discussions" src="https://img.shields.io/github/discussions/rainpole/packer-vsphere?style=for-the-badge&logo=github">](https://github.com/rainpole/packer-vsphere/discussions)
<br/>
<img alt="VMware vSphere 7.0 Update 2" src="https://img.shields.io/badge/VMware%20vSphere-7.0%20Update%202-blue?style=for-the-badge">
<img alt="Packer 1.7.4" src="https://img.shields.io/badge/HashiCorp%20Packer-1.7.4-blue?style=for-the-badge">

## Table of Contents
1.	[Introduction](#Introduction)
1.	[Requirements](#Requirements)
1.	[Configuration](#Configuration)
1.	[Build](#Build)
1.	[Troubleshoot](#Troubleshoot)
1.	[Credits](#Credits)
    
## Introduction

This repository provides examples to automate the creation of virtual machine images and their guest operating systems on VMware vSphere using [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-vsphere-iso] (`vsphere-iso`). All examples are authored in the HashiCorp Configuration Language ("HCL2") instead of JSON.

The resulting machine image artifacts are, by default, transferred to a [vSphere Content Library][vsphere-content-library] as an OVF template and the temporary machine image is destroyed. If an item of the same name exists in the target content library, Packer will update the existing item with the new OVF template. This method is extremely useful for vRealize Automation / vRealize Automation Cloud as image mappings do not need to be updated when a virtual machine image update is executed and finalized.

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
* Microsoft Windows Server 2019 - Standard and Datacenter
* Microsoft Windows Server 2016 - Standard and Datacenter

> **NOTE**: Guest customization is [**not supported**](https://partnerweb.vmware.com/programs/guestOS/guest-os-customization-matrix.pdf) for AlmaLinux and Rocky Linux in vCenter Server 7.0 Update 2. 

## Requirements

Packer:
* HashiCorp [Packer][packer-install] 1.7.4 or higher.
* HashiCorp [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso`) 1.0.1 or higher.
* [Packer Plugin for Windows Updates][packer-plugin-windows-update] 0.14.0 or higher - a community plugin for HashiCorp Packer.

    >Required plugins are automatically downloaded and initialized when using `./build.sh`. Alternatively, you may download the plugins and place these same directory as your Packer executable `/usr/local/bin` or `$HOME/.packer.d/plugins`.

Operating Systems:
* macOS Big Sur (Intel)
* Ubuntu Server 20.04 LTS
* Microsoft Windows Server 2019

    > Operating systems and versions tested with the repository examples.

Additional Software Packages:
* [Git][download-git] command line tools.

Platform:
* vSphere 7.0 Update 2 or higher.

## Configuration

### Step 1 - Clone the Repository

Clone the GitHub repository using Git.

Example: 
```
git clone https://github.com/rainpole/packer-vsphere.git
```

The directory structure of the repository.

```
packer-vsphere/ 
├── build.sh
├── README.md
├── builds
│   └── ansible.pkvars.hcl
│   └── build.pkvars.hcl
│   └── common.pkvars.hcl
│   └── rhsm.pkvars.hcl
│   └── vsphere.pkvars.hcl
│   └── linux
│       └── distribution version
|           (e.g. ubuntu-server-20-04-lts)
│           └── build files
|               (e.g. variables.auto.pkrvars.hcl and *.pkr.hcl)
│   └── windows
│       └── version 
|           (e.g. windows-server-2019)
│           └── build files 
|               (e.g. variables.auto.pkrvars.hcl and *.pkr.hcl)
├── certificates
│   └── root-ca.crt
│   └── root-ca.p7b
├── configs
│   └── linux
│       └── distribution
|           (e.g. ubuntu-server)
│           └── kickstart files 
|               (e.g. ks*.cfg or ks.json)
│   └── windows
│       └── version
|           (e.g. windows-server-2019)
│           └── edition-experience
|               (e.g. standard-core)
│               └── efi-secure 
│                   └── autounattend.xml
│               └── bios 
│                   └── autounattend.xml
├── manifests
├── scripts
│   └── linux
│       (e.g. ubuntu-server.sh)
│   └── windows
│       (e.g. windows-server-cleanup.ps1)
```
The files are distributed in to five main directories.
1. The `builds` directory contains the build templates and variables.
2. The `configs` directory contains Kickstart files for Linux and autounattend files for Microsoft Windows guest operating systems.
3. The `scripts` directory contains scripts that are used to prepare the machine image builds.
4. The `certificates` directory contains the Trusted Root Authority certificates.
5. The `manifests` directory contains the manifest created after the completion of each build.

### Step 2 - Prepare the Guest Operating Systems ISOs

1. Download the x64 guest operating system [.iso][iso] images.

    **Linux Distributions**
    * VMware Photon OS 4 Server
        * [Download][download-linux-photon-server-4] the latest full release.
    * Ubuntu Server 20.04 LTS
        * [Download][download-linux-ubuntu-server-20-04-lts] the latest **LIVE** release.
    * Ubuntu Server 18.04 LTS
        * [Download][download-linux-ubuntu-server-18-04-lts] the latest legacy **NON-LIVE** release.
    * Red Hat Enterprise Linux 8 Server
        * [Download][download-linux-redhat-server-8] the latest release of the full (e.g `RHEL-8-x86_64-dvd1.iso`) .iso image.
    * AlmaLinux 8 Server
        * [Download][download-linux-almalinux-server-8] the latest release of the full (e.g `AlmaLinux-8-x86_64-dvd1.iso`) .iso image.
    * Rocky Linux 8 Server
        * [Download][download-linux-rocky-server-8] the latest release of the full (e.g `Rocky-8-x86_64-dvd1.iso`) .iso image.
    * CentOS Stream 8 Server
        * [Download][download-linux-centos-stream-8] the latest release of the full (e.g `CentOS-Stream-8-x86_64-dvd1.iso`) .iso image.
    * CentOS Linux 8 Server
        * [Download][download-linux-centos-server-8] the latest release of the full (e.g `CentOS-8-x86_64-dvd1.iso`) .iso image.

    **Microsoft Windows**
    * Microsoft Windows Server 2019
    * Microsoft Windows Server 2016

2. Rename your guest operating system `.iso` images. The examples in this repository _generally_ use the format of `iso-family-vendor-type-version.iso`. 

    For example:

    * `iso-linux-photon-4.iso`
    * `iso-linux-ubuntu-server-20-04-lts.iso`
    * `iso-linux-ubuntu-server-18-04-lts.iso`
    * `iso-linux-redhat-linux-8`
    * `iso-linux-almalinux-8`
    * `iso-linux-rocky-linux-8`
    * `iso-linux-centos-stream-8`
    * `iso-linux-centos-linux-8`
    * `iso-windows-server-2019.iso`
    * `iso-windows-server-2016.iso`

3. Obtain the SHA-512 checksum for each guest operating system `.iso` image. This will be use in the build input variables.

    * macOS terminal: `shasum -a 512 [filename.iso]`
    * Linux shell: `sha512sum [filename.iso]`
    * Windows command: `certutil -hashfile [filename.iso] sha512`

4. [Upload][vsphere-upload] your guest operating system `.iso` images to the datastore and path defined in your common variables. For example, `[sfo-w01-ds-nfs01] /iso`.

### Step 3 - Configure the Variables

The [variables][packer-variables] are defined in `.pkvars.hcl` files.

#### **Build Variables**

Edit the `/builds/build.pkvars.hcl` file to configure the following:

* Credentials for the default account on machine images. 

Example: `/builds/build.pkvars.hcl`

```
// Communicator Credentials
build_username = "rainpole"
build_password = "R@in!$aG00dThing."
build_key      = "<public_key>"
```
Generate a public key for authentication.

Example: `id_ecdsa.pub` on macOS and Linux.

```
rainpole@macos> cd .ssh/
rainpole@macos ~/.ssh> ssh-keygen -t ecdsa -b 521 -C "code@rainpole.io"
Generating public/private ecdsa key pair.
Enter file in which to save the key (/Users/rainpole/.ssh/id_ecdsa): 
Enter passphrase (empty for no passphrase): **************
Enter same passphrase again: **************
Your identification has been saved in /Users/rainpole/.ssh/id_ecdsa.
Your public key has been saved in /Users/rainpole/.ssh/id_ecdsa.pub.
    
This content of the public is adds the key to the `.ssh/authorized_keys` file of the `build_username` on the guest operating system. 
```

>**WARNING**: Replace the default public keys.
>By default, both Public Key Authentication and Password Authentication are enabled for Linux distributions. If you wish to disable Password Authentication and only use Public Key Authentication, comment or remove the portion of the associated script in the `/scripts` directory.

#### **Build Variables**

Edit the `/builds/ansible.pkvars.hcl` file to configure the following:

* Credentials for the Ansible account on Linux machine images. 

Example: `/builds/ansible.pkvars.hcl`

```
// Ansible Credentials
ansible_username = "ansible"
ansible_key      = "<public_key>"
```

#### **Common Variables**

Edit the `/builds/common.pkvars.hcl` file to configure the following:

* Common Virtual Machine Settings
* Common Template and Content Library Settings
* Common Removable Media Settings
* Common Boot and Provisioning Settings

Example: `/builds/common.pkvars.hcl`

```
// Template and Content Library Settings
common_template_conversion     = false
common_content_library_name    = "sfo-w01-lib01"
common_content_library_ovf     = true
common_content_library_destroy = true
```

#### **vSphere Variables**

Edit the `/buils/vsphere.pkvars.hcl` file to configure the following:

* vSphere Endpoint and Credentials
* vSphere Settings

Example: `/builds/vsphere.pkvars.hcl`

```
// vSphere Credentials
vsphere_endpoint             = "sfo-w01-vc01.sfo.rainpole.io"
vsphere_username             = "svc-packer-vsphere@rainpole.io"
vsphere_password             = "R@in!$aG00dThing."
vsphere_insecure_connection  = true

// vSphere Settings
vsphere_datacenter           = "sfo-w01-dc01"
vsphere_cluster              = "sfo-w01-cl01"
vsphere_datastore            = "sfo-w01-cl01-ds-vsan01"
vsphere_network              = "sfo-w01-seg-dhcp"
vsphere_folder               = "sfo-w01-fd-templates"
```

#### **Red Hat Subscription Manager Variables**

Edit the `/builds/redhat.pkvars.hcl` file to configure the following:

* Credentials for your Red Hat Subscription Manager account. 

Example: `/builds/redhat.pkvars.hcl`

```
// Red Hat Subscription Manager Credentials
rhsm_username = "rainpole"
rhsm_password = "R@in!$aG00dThing."
```

These variables are **only** used if you are performing a Red Hat Enterprise Linux Server build to register the image with Red Hat Subscription Manager and run a `sudo yum update -y` within the shell provisioner. Before the build completes, the image is unregistered.

#### **Build Variables**

Edit the `variables.auto.pkvars.hcl` file in each `builds/<type>/<build>` folder to configure the following virtual machine hardware settings, as required:

* CPU Sockets `(init)`
* CPU Cores `(init)`
* Memory in MB `(init)`
* Primary Disk in MB `(init)`
* .iso Image File `(string)`
* .iso Image SHA-512 Checksum `(string)`

    >**Note**: All `variables.auto.pkvars.hcl` default to using the the recommended firmware for the guest operating system, the [VMware Paravirtual SCSI controller][vmware-pvscsi] and the [VMXNET 3][vmware-vmxnet3] network card device types.

#### Using Environmental Variables

Some of the variables may include sensitive information and environmental data that you would prefer not to save to clear text files. You can save use environmental variables before running a build using the example below:

```
export PKR_VAR_vsphere_endpoint="<vsphere_endpoint_fqdn>"
export PKR_VAR_vsphere_username="<vsphere_username>"
export PKR_VAR_vsphere_password="<vsphere_password>"
export PKR_VAR_vsphere_datacenter="<vsphere_datacenter>>"
export PKR_VAR_vsphere_cluster="<vsphere_cluster>"
export PKR_VAR_vsphere_datastore="<vsphere_datastore>>"
export PKR_VAR_vsphere_network="<vsphere_network>"
export PKR_VAR_vsphere_folder="<vsphere_folder>"
export PKR_VAR_build_username="<build_password>"
export PKR_VAR_build_password="<build_password>"
export PKR_VAR_build_key="<build_key>"
export PKR_VAR_ansible_username="<ansible_password>"
export PKR_VAR_ansible_key="<ansible_key>"
export PKR_VAR_rhsm_username="<rhsm_password>"
export PKR_VAR_rhsm_password="<rhsm_password>"
```
## Step 4 - Modify the Configurations and Scripts

Modify the configuration and scripts files, as required, for the Linux distributions and Microsoft Windows.

### Linux Distribution Kickstart and Scripts

```
packer-vsphere/ 
├── configs
│   └── linux
│       └── distribution
|           (e.g. ubuntu-server)
│           └── kickstart files 
|               (e.g. ks.cfg or ks.json)
└── scripts
│   └── linux
│       (e.g. ubuntu-server.sh)
```

The kickstart files for each Linux distribution includes a SHA-512 encrypted password for the `root` account and the name and SHA-512 encrypted password for the the build user (e.g. `rainpole`). It also adds the build user to the sudoers. Update these lines as necessary.

You can generate a SHA-512 password using various other tools like OpenSSL, mkpasswd, etc.

**OpenSSL on macOS**:
```
rainpole@macos>  openssl passwd -6 
Password: ***************
Verifying - Password: ***************
[password hash]
```
**mkpasswd on Linux**:
```
rainpole@linux>  mkpasswd --method=SHA-512 --rounds=4096
Password: ***************
[password hash]
```

**Example 1**: VMware Photon OS `ks.json` file.

```
"password":
    {
        "crypted": true,
        "text": "[password hash]"
    },
    ...
    "postinstall": [
        ...
        "useradd -m -p '[password hash]' -s /bin/bash rainpole",
        "usermod -aG sudo rainpole"
    ],
```
>**NOTE**: Update the `public_key` with the desired public key for the root user. This will be added to the `.ssh/authorized_keys` file for the `root` account. 

**Example 2**: Ubuntu Server 20.04 (and later) `user-data` and `meta-data` files.

 The `user-data` and `meta-data` files are [cloud-init][cloud-init] configuration files used to build the Ubuntu Server 20.04 LTS and later machine images. You must update the `user-data` file, but the contents of the `meta-data` file should remain empty.

Ubuntu Server `user-data` file.
```
identity:
    hostname: ubuntu-server
    username: rainpole
    password: '[password hash]'

late-commands:
- echo 'rainpole ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/rainpole
- curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/rainpole
```

**Example 3**: Ubuntu Server 18.04 `ks.cfg` file.

```
# User Configuration

d-i passwd/user-fullname string rainpole

d-i passwd/username string rainpole

d-i passwd/user-password-crypted password [password hash]

# Root Configuration
d-i passwd/root-password-crypted password [password hash]

# Add User to Sudoers
d-i preseed/late_command string \
    echo 'rainpole ALL=(ALL) NOPASSWD: ALL' > /target/etc/sudoers.d/rainpole ; \
    in-target chmod 440 /etc/sudoers.d/rainpole ;
```

**Example 4**: Red Hat Enterprise Linux, CentOS Linux/Stream, AlmaLinux, and Rocky Linux `ks.cfg` file:

```
rootpw [password hash] --iscrypted

user --name=rainpole --groups=wheel --iscrypted --password=[password hash]
...
echo "rainpole ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/rainpole
```

### Microsoft Windows Unattended amd Scripts

```
packer-vsphere/ 
├── configs
│   └── windows
│       └── version
|           (e.g. windows-server-2019)
│           └── edition-experience
|               (e.g. standard-core)
│               └── unattended files 
|                   (e.g. autounattend.xml)
└── scripts
│   └── windows
│       (e.g. windows-server-cleanup.sh)
```

The [Microsoft Windows][microsoft-windows-unattend] `autounattend.xml` files include configurations to:
* Add the Registration Name and Organization
* Set the Product Key
* Add a local account for the build user.
* Set the password for the Administrator and the build user.

The **Registration Name** and **Organization** must be changed - update this code block in each `autounattend.xml`. 

By default, each unattended file set the **Product Key** to use the [KMS client setup keys][microsoft-kms].

The password for the `<UserAccounts>` - which includes the `administrator` and build user (e.g. `rainpole`) - and the [`<AutoLogon>`][microsoft-windows-autologon] must be changed - update these code blocks in each `autounattend.xml` file.

Example: Administrator and Local Accounts
```
<UserAccounts>
<AdministratorPassword>
    <Value>R@in!$aG00dThing.</Value>
    <PlainText>true</PlainText>
</AdministratorPassword>
<LocalAccounts>
    <LocalAccount wcm:action="add">
        <Password>
            <Value>R@in!$aG00dThing.</Value>
            <PlainText>true</PlainText>
        </Password>
        <Group>administrators</Group>
        <DisplayName>Rainpole</DisplayName>
        <Name>rainpole</Name>
        <Description>Build Account by Rainpole</Description>
    </LocalAccount>
</LocalAccounts>
</UserAccounts>
```
Example: Auto Logon
```
<AutoLogon>
<Password>
    <Value>R@in!$aG00dThing.</Value>
    <PlainText>true</PlainText>
</Password>
<Enabled>true</Enabled>
<Username>rainpole</Username>
</AutoLogon>

```
If you would like to encrypt the passwords in the `autounattend.xml`, you can do so using the following. But please note that the can be easily decrypted.

Example: Encode a password with PowerShell on macOS.

```
PS /Users/rainpole> $UnEncodedText = 'R@in!$aG00dThing.'
PS /Users/rainpole> $EncodedText =[Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($UnEncodedText))
PS /Users/rainpole> write-host "Encoded Password:" $EncodedText             

Encoded Password: [encoded password]
```
Example: Decode a password with PowerShell on macOS.

```
PS /Users/rainpole $DecodedText = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($EncodedText))
PS /Users/rainpole> write-host "Decoded Password:" $DecodedText              

Decoded Password: [decoded password]

```
Example: Use the encoded password in a `autounattend.xml` file.

```
<Password>
    <Value>[encoded password]</Value>
    <PlainText>false</PlainText>
</Password>
```
**Need help customizing the configuration files further?**

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

```
packer-vsphere/ 
├── certificates
│   └── root-ca.crt
│   └── root-ca.p7b
```
These files are copied to the guest operating systems with a Packer file provisioner; after which, the a shell provisioner adds the certificate to the Trusted Certificate Authority of the guest operating system.

>**NOTE**: If you do not wish to install the certificates on the guest operating systems, comment or remove the portion of the associated script in the `/scripts` directory and the file provisioner from the `prk.hcl` file for each build. If you need to add an intermediate certificate, add the certificate to `/certificates` and update the shell provisioner scripts in the `scripts` directory with your requirements.

## Build

Start a pre-defined build by running the build script (`./build.sh`). The script presents a menu the which simply calls Packer and the respective build(s).

Example: Launch`./build.sh`.
```
rainpole@macos packer-examples> ./build.sh
```

The menu will allow you to execute and confirm a build using Packer and the `vsphere-iso` provisioner.

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

         9  -  Windows Server 2019 - All
        10  -  Windows Server 2019 - Standard Only
        11  -  Windows Server 2019 - Datacenter Only
        12  -  Windows Server 2016 - All
        13  -  Windows Server 2016 - Standard Only
        14  -  Windows Server 2016 - Datacenter Only


      Other:
      
        I   -  Information
        Q   -  Quit
```
You can also start a build based on a specific source for some of the virtual machine images.

For example, if you simply want to build a Microsoft Windows Server 2019 Standard Core, run the following:

Initialize plugins:
```
rainpole@macos packer-examples> cd builds/windows/windows-server-2019/
rainpole@macos packer-examples> packer init .
```
Build a specific machine image:
```
rainpole@macos windows-server-2019> packer build -force \
      --only vsphere-iso.windows-server-standard-core \
      -var-file="../../vsphere.pkrvars.hcl" \
      -var-file="../../build.pkrvars.hcl" \
      -var-file="../../ansible.pkrvars.hcl" \
      -var-file="../../common.pkrvars.hcl" .
```
Build a specific machine image using environmental variables:
```
rainpole@macos windows-server-2019> packer build -force \
      --only vsphere-iso.windows-server-standard-core \
      -var-file="../../common.pkrvars.hcl" .
```
Happy building!!!

 -- Your friends at rainpole.io.

## Troubleshoot

* Read [Debugging Packer Builds][packer-debug].

## Credits
* Maher AlAsfar [@vmwarelab][credits-maher-alasfar-twitter]

    [Linux][credits-maher-alasfar-github] Bash scripting code.
    
* Owen Reynolds [@OVDamn][credits-owen-reynolds-twitter]
    
    [VMware Tools for Windows][credits-owen-reynolds-github] installation PowerShell script.

[//]: Links

[chocolatey]: https://chocolatey.org/why-chocolatey
[cloud-init]: https://cloudinit.readthedocs.io/en/latest/
[credits-maher-alasfar-twitter]: https://twitter.com/vmwarelab
[credits-maher-alasfar-github]: https://github.com/vmwarelab/cloud-init-scripts
[credits-owen-reynolds-twitter]: https://twitter.com/OVDamn
[credits-owen-reynolds-github]: https://github.com/getvpro/Build-Packer/blob/master/Scripts/Install-VMTools.ps1
[download-git]: https://git-scm.com/downloads
[download-linux-photon-server-4]: https://packages.vmware.com/photon/4.0/
[download-linux-ubuntu-server-20-04-lts]: https://releases.ubuntu.com/20.04.1/
[download-linux-ubuntu-server-18-04-lts]: http://cdimage.ubuntu.com/ubuntu/releases/18.04.5/release/
[download-linux-redhat-server-8]: https://access.redhat.com/downloads/content/479/
[download-linux-redhat-server-7]: https://access.redhat.com/downloads/content/69/
[download-linux-almalinux-server-8]: https://mirrors.almalinux.org/isos.html
[download-linux-rocky-server-8]: https://download.rockylinux.org/pub/rocky/8/isos/x86_64/
[download-linux-centos-stream-8]: http://isoredirect.centos.org/centos/8-stream/isos/x86_64/
[download-linux-centos-server-8]: http://isoredirect.centos.org/centos/8/isos/x86_64/
[download-linux-centos-server-7]: http://isoredirect.centos.org/centos/7/isos/x86_64/
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
[packer-variables]: https://www.packer.io/docs/from-1.5/variables#variable-definitions-pkrvars-hcl-files
[photon-kickstart]: https://vmware.github.io/photon/assets/files/html/3.0/photon_user/kickstart.html
[redhat-kickstart]: https://access.redhat.com/labs/kickstartconfig/
[ssh-keygen]: https://www.ssh.com/ssh/keygen/
[vmware-pvscsi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.hostclient.doc/GUID-7A595885-3EA5-4F18-A6E7-5952BFC341CC.html
[vmware-vmxnet3]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AF9E24A8-2CFA-447B-AC83-35D563119667.html
[vsphere-api]: https://code.vmware.com/apis/968
[vsphere-content-library]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-254B2CE8-20A8-43F0-90E8-3F6776C2C896.html
[vsphere-guestosid]: https://vdc-download.vmware.com/vmwb-repository/dcr-public/b50dcbbf-051d-4204-a3e7-e1b618c1e384/538cf2ec-b34f-4bae-a332-3820ef9e7773/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html
[vsphere-efi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-898217D4-689D-4EB5-866C-888353FE241C.html
[vsphere-upload]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.storage.doc/GUID-58D77EA5-50D9-4A8E-A15A-D7B3ABA11B87.html?hWord=N4IghgNiBcIK4AcIHswBMAEAzAlhApgM4gC+QA
