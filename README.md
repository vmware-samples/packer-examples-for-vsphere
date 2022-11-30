# HashiCorp Packer and VMware vSphere to Build Private Cloud Machine Images

![Last Commit](https://img.shields.io/github/last-commit/vmware-samples/packer-examples-for-vsphere?style=for-the-badge&logo=github)

[![The Changelog](https://img.shields.io/badge/The%20Changelog-Read-blue?style=for-the-badge&logo=github)](CHANGELOG.md)

![Packer 1.8.4+](https://img.shields.io/badge/HashiCorp%20Packer-1.8.4+-blue?style=for-the-badge&logo=packer&logoColor=white)

## Table of Contents

1. [Introduction](#introduction)
1. [Requirements](#requirements)
1. [Configuration](#configuration)
1. [Build](#build)
1. [Troubleshoot](#troubleshoot)
1. [Credits](#credits)

## Introduction

This repository provides infrastructure-as-code examples to automate the creation of virtual machine images and their guest operating systems on VMware vSphere using [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso`). All examples are authored in the HashiCorp Configuration Language ("HCL2").

Use of this project is mentioned in the **_VMware Validated Solution: Private Cloud Automation for VMware Cloud Foundation_** authored by the maintainer. Learn more about this solution at [vmware.com/go/vvs](https://vmware.com/go/vvs).

By default, the machine image artifacts are transferred to a [vSphere Content Library][vsphere-content-library] as an OVF template and the temporary machine image is destroyed. If an item of the same name exists in the target content library, Packer will update the existing item with the new version of OVF template.

The following builds are available:

### Linux Distributions

- VMware Photon OS 4
- Debian 11
- Ubuntu Server 22.04 LTS (cloud-init)
- Ubuntu Server 20.04 LTS (cloud-init)
- Ubuntu Server 18.04 LTS
- Red Hat Enterprise Linux 9 Server
- Red Hat Enterprise Linux 8 Server
- Red Hat Enterprise Linux 7 Server
- AlmaLinux OS 9
- AlmaLinux OS 8
- Rocky Linux 9
- Rocky Linux 8
- CentOS Stream 9
- CentOS Stream 8
- CentOS Linux 7
- SUSE Linux Enterprise Server 15

### Microsoft Windows - _Core and Desktop Experience_

- Microsoft Windows Server 2022 - Standard and Datacenter
- Microsoft Windows Server 2019 - Standard and Datacenter
- Microsoft Windows 11
- Microsoft Windows 10

> **Note**
>
> - The Microsoft Windows 11 machine image uses a virtual trusted platform module (vTPM). Refer to the VMware vSphere [product documenation][vsphere-tpm] for requirements and pre-requisites.
>
> - The Microsoft Windows 11 machine image is not transferred to the content library by default. It is **not supported** to clone an encrypted virtual machine to the content library as an OVF Template. You can adjust the common content library settings to use VM Templates.

## Requirements

**Operating Systems**:

Operating systems and versions tested with the project:

- VMware Photon OS 4.0 (`x86_64`)
- Ubuntu Server 22.04 LTS (`x86_64`)
- macOS Monterey (Intel)

> **Note**
>
> Update your `/etc/ssh/ssh_config` or `~/.ssh/ssh_config` to allow ssh authentication with RSA keys if you are using VMware Photon OS 4.0 or Ubuntu 22.04.
>
> Update to include the following:
>
> `HostKeyAlgorithms +ssh-rsa`
> `PubKeyAcceptedAlgorithms +ssh-rsa`

**Packer**:

- HashiCorp [Packer][packer-install] 1.8.4 or higher.

  > **Note**
  >
  > Click on the operating system name to display the installation steps.

  - <details>
      <summary>Photon OS</summary>

    ```shell
    PACKER_VERSION="1.8.4"
    OS_PACKAGES="wget unzip"

    if [[ $(uname -m) == "x86_64" ]]; then
      LINUX_ARCH="amd64"
    elif [[ $(uname -m) == "aarch64" ]]; then
      LINUX_ARCH="arm64"
    fi

    tdnf install ${OS_PACKAGES} -y

    wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_${LINUX_ARCH}.zip

    unzip -o -d /usr/local/bin/ packer_${PACKER_VERSION}_linux_${LINUX_ARCH}.zip
    ```

    </details>

  - <details>
      <summary>Ubuntu</summary>

    The Terraform packages are signed using a private key controlled by HashiCorp, so you must configure your system to trust that HashiCorp key for package authentication.

    To configure your repository:

    ```shell
    sudo bash -c 'wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg'
    ```

    Verify the key's fingerprint:

    ```shell
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
    ```

    The fingerprint must match E8A0 32E0 94D8 EB4E A189 D270 DA41 8C88 A321 9F7B. You can also verify the key on [Security at HashiCorp][hcp-security] under Linux Package Checksum Verification.

    Add the official HashiCorp repository to your system:

    ```shell
    sudo bash -c 'echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list'
    ```

    Install Packer from HashiCorp repository:

    ```shell
    sudo apt update && sudo apt install packer
    ```

    </details>

  - <details>
      <summary>macOS</summary>

    ```shell
    brew tap hashicorp/tap

    brew install hashicorp/tap/packer
    ```

    </details>

- Packer plugins:

  > **Note**
  >
  > Required plugins are automatically downloaded and initialized when using `./build.sh`. For dark sites, you may download the plugins and place these same directory as your Packer executable `/usr/local/bin` or `$HOME/.packer.d/plugins`.

  - HashiCorp [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso`) 1.1.0 or higher.
  - [Packer Plugin for Git][packer-plugin-git] 0.3.2 or higher - a community plugin for HashiCorp Packer.
  - [Packer Plugin for Windows Updates][packer-plugin-windows-update] 0.14.1 or higher - a community plugin for HashiCorp Packer.

**Additional Software Packages**:

The following additional software packages must be installed on the operating system running Packer.

> **Note**
>
> Click on the operating system name to display the installation steps for all prerequisites.

- <details>
    <summary>Photon OS</summary>

  - [Git][download-git] command-line tools.

  - [Ansible][ansible-docs] 2.9 or higher.

  - [jq][jq] A command-line JSON processor.

  - xorriso - A command-line .iso creator.

    ```shell
    tdnf -y install git ansible jq xorriso
    ```

  - HashiCorp [Terraform][terraform-install] 1.3.6 or higher.

    ```shell
    TERRAFORM_VERSION="1.3.6"
    OS_PACKAGES="wget unzip"

    if [[ $(uname -m) == "x86_64" ]]; then
      LINUX_ARCH="amd64"
    elif [[ $(uname -m) == "aarch64" ]]; then
      LINUX_ARCH="arm64"
    fi

    tdnf install ${OS_PACKAGES} -y

    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${LINUX_ARCH}.zip

    unzip -o -d /usr/local/bin/ terraform_${TERRAFORM_VERSION}_linux_${LINUX_ARCH}.zip
    ```

  </details>

- <details>
    <summary>Ubuntu</summary>

  - [Git][download-git] command-line tools.

  - [Ansible][ansible-docs] 2.9 or higher.

  - [jq][jq] A command-line JSON processor.

  - xorriso - A command-line .iso creator.

  - mkpasswd - Password generating utility

  - HashiCorp [Terraform][terraform-install] 1.3.6 or higher.

    ```shell
    sudo apt -y install git ansible jq xorriso whois terraform
    ```

  - [Gomplate][gomplate-install] 3.11.3 or higher.

    ```shell
    GOMPLATE_VERSION="3.11.3"
    LINUX_ARCH="amd64"

    sudo curl -o /usr/local/bin/gomplate -sSL https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-${LINUX_ARCH}
    sudo chmod 755 /usr/local/bin/gomplate
    ```

  </details>

- <details>
    <summary>macOS</summary>

  - [Git][download-git] command-line tools.

  - [Ansible][ansible-docs] 2.9 or higher.

  - [jq][jq] A command-line JSON processor.

  - Coreutils

  - HashiCorp [Terraform][terraform-install] 1.3.6 or higher.

  - [Gomplate][gomplate-install] 3.11.3 or higher.

    ```shell
    brew install git ansible jq coreutils hashicorp/tap/terraform gomplate
    ```

  - mkpasswd - Password generating utility

    ```shell
    brew install --cask docker
    ```

  </details>

**Platform**:

- VMware vSphere 8.0
- VMware vSphere 7.0 Update 3D or later.

## Configuration

### Step 1 - Download the Source

You can choose between two options to get the source code:

1. [Download the Release Archive](#download-the-latest-release)
1. [Clone the Repository](#clone-the-repository)

#### Download the Latest Release

```console
TAG_NAME=$(curl -s https://api.github.com/repos/vmware-samples/packer-examples-for-vsphere/releases | jq  -r '.[0].tag_name')
TARBALL_URL=$(curl -s https://api.github.com/repos/vmware-samples/packer-examples-for-vsphere/releases | jq  -r '.[0].tarball_url')

mkdir packer-examples-for-vsphere
cd packer-examples-for-vsphere
curl -sL $TARBALL_URL | tar xvfz - --strip-components 1
git init -b main
git add .
git commit -m "Initial commit"
git switch -c $TAG_NAME HEAD
```

#### Clone the Repository

> **Note**
>
> You may also clone `main` for the latest prerelease updates.

```console
TAG_NAME=$(curl -s https://api.github.com/repos/vmware-samples/packer-examples-for-vsphere/releases | jq  -r '.[0].tag_name')

git clone https://github.com/vmware-samples/packer-examples-for-vsphere.git
cd packer-examples-for-vsphere
git switch -c $TAG_NAME $TAG_NAME
```

> **Warning**
>
> A branch is mandatory because it is used for the build version and the virtual machine name. It does not matter if it is based on the HEAD or a release tag.

The directory structure of the repository.

```console
├── build.sh
├── build.tmpl
├── build.yaml
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── config.sh
├── CONTRIBUTING.md
├── LICENSE
├── MAINTAINERS.md
├── NOTICE
├── README.md
├── set-envvars.sh
├── ansible
│   ├── ansible.cfg
│   ├── main.yml
│   └── roles
│       └── <role>
│           └── *.yml
├── artifacts
├── builds
│   ├── ansible.pkrvars.hcl.example
│   ├── build.pkrvars.hcl.example
│   ├── common.pkrvars.hcl.example
│   ├── proxy.pkrvars.hcl.example
│   ├── rhsm.pkrvars.hcl.example
│   ├── scc.pkrvars.hcl.example
│   ├── vsphere.pkrvars.hcl.example
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
├── manifests
├── scripts
│   ├── linux
│   └── windows
│       └── *.ps1
└── terraform
    ├── vsphere-role
    │   └── *.tf
    └── vsphere-virtual-machine
        ├── content-library-ovf-linux-cloud-init
        │   └── *.tf
        ├── content-library-ovf-linux-cloud-init-hcp-packer
        │   └── *.tf
        ├── content-library-ovf-linux-guest-customization
        │   └── *.tf
        ├── content-library-ovf-linux-guest-customization-hcp-packer
        │   └── *.tf
        ├── content-library-ovf-windows-guest-customization
        │   └── *.tf
        ├── content-library-ovf-windows-guest-customization-hcp-packer
        │   └── *.tf
        ├── content-library-template-linux-guest-customization-hcp-packer
        │   └── *.tf
        ├── content-library-template-windows-guest-customization-hcp-packer
        │   └── *.tf
        ├── template-linux-cloud-init
        │   └── *.tf
        ├── template-linux-cloud-init-hcp-packer
        │   └── *.tf
        ├── template-linux-guest-customization
        │   └── *.tf
        ├── template-linux-guest-customization-hcp-packer
        │   └── *.tf
        ├── template-windows-guest-customization
        │   └── *.tf
        └── template-windows-guest-customization-hcp-packer
            └── *.tf
```

The files are distributed in the following directories.

- **`ansible`** - contains the Ansible roles to prepare Linux machine image builds.
- **`artifacts`** - contains the OVF artifacts exported by the builds, if enabled.
- **`builds`** - contains the templates, variables, and configuration files for the machine image builds.
- **`scripts`** - contains the scripts to initialize and prepare Windows machine image builds.
- **`manifests`** - manifests created after the completion of the machine image builds.
- **`terraform`** - contains example Terraform plans to create a custom role and test machine image builds.

> **Warning**
>
> When forking the project for upstream contribution, please be mindful not to make changes that may expose your sensitive information, such as passwords, keys, certificates, etc.

### Step 2 - Configure Service Account Privileges in vSphere

Create a custom vSphere role with the required privileges to integrate HashiCorp Packer with VMware vSphere. A service account can be added to the role to ensure that Packer has least privilege access to the infrastructure. Clone the default **Read-Only** vSphere role and add the following privileges:

| Category                 | Privilege                                           | Reference                                          |
| ---------------          | --------------------------------------------------- | -------------------------------------------------- |
| Content Library          | Add library item                                    | `ContentLibrary.AddLibraryItem`                    |
| ...                      | Update Library Item                                 | `ContentLibrary.UpdateLibraryItem`                 |
| Cryptographic Operations | Direct Access (Required for `packer_cache` upload.) | `Cryptographer.Access`                             |
| ...                      | Encrypt (Required for vTPM.)                        | `Cryptographer.Encrypt`                            |
| Datastore                | Allocate space                                      | `Datastore.AllocateSpace`                          |
| ...                      | Browse datastore                                    | `Datastore.Browse`                                 |
| ...                      | Low level file operations                           | `Datastore.FileManagement`                         |
| Host                     | Configuration > System Management                   | `Host.Config.SystemManagement`                     |
| Network                  | Assign network                                      | `Network.Assign`                                   |
| Resource                 | Assign virtual machine to resource pool             | `Resource.AssignVMToPool`                          |
| vApp                     | Export                                              | `vApp.Export`                                      |
| Virtual Machine          | Configuration > Add new disk                        | `VirtualMachine.Config.AddNewDisk`                 |
| ...                      | Configuration > Add or remove device                | `VirtualMachine.Config.AddRemoveDevice`            |
| ...                      | Configuration > Advanced configuration              | `VirtualMachine.Config.AdvancedConfig`             |
| ...                      | Configuration > Change CPU count                    | `VirtualMachine.Config.CPUCount`                   |
| ...                      | Configuration > Change memory                       | `VirtualMachine.Config.Memory`                     |
| ...                      | Configuration > Change settings                     | `VirtualMachine.Config.Settings`                   |
| ...                      | Configuration > Change Resource                     | `VirtualMachine.Config.Resource`                   |
| ...                      | Configuration > Modify device settings              | `VirtualMachine.Config.EditDevice`                 |
| ...                      | Configuration > Set annotation                      | `VirtualMachine.Config.Annotation`                 |
| ...                      | Edit Inventory > Create from existing               | `VirtualMachine.Inventory.CreateFromExisting`      |
| ...                      | Edit Inventory > Create new                         | `VirtualMachine.Inventory.Create`                  |
| ...                      | Edit Inventory > Remove                             | `VirtualMachine.Inventory.Delete`                  |
| ...                      | Interaction > Configure CD media                    | `VirtualMachine.Interact.SetCDMedia`               |
| ...                      | Interaction > Configure floppy media                | `VirtualMachine.Interact.SetFloppyMedia`           |
| ...                      | Interaction > Connect devices                       | `VirtualMachine.Interact.DeviceConnection`         |
| ...                      | Interaction > Inject USB HID scan codes             | `VirtualMachine.Interact.PutUsbScanCodes`          |
| ...                      | Interaction > Power off                             | `VirtualMachine.Interact.PowerOff`                 |
| ...                      | Interaction > Power on                              | `VirtualMachine.Interact.PowerOn`                  |
| ...                      | Provisioning > Create template from virtual machine | `VirtualMachine.Provisioning.CreateTemplateFromVM` |
| ...                      | Provisioning > Mark as template                     | `VirtualMachine.Provisioning.MarkAsTemplate`       |
| ...                      | Provisioning > Mark as virtual machine              | `VirtualMachine.Provisioning.MarkAsVM`             |
| ...                      | State > Create snapshot                             | `VirtualMachine.State.CreateSnapshot`              |

If you would like to automate the creation of the custom vSphere role, a Terraform example is included in the project.

1. Navigate to the directory for the example.

   ```console
   cd terraform/vsphere-role
   ```

1. Duplicate the `terraform.tfvars.example` file to `terraform.tfvars` in the directory.

   ```console
   cp terraform.tfvars.example terraform.tfvars
   ```

1. Open the `terraform.tfvars` file and update the variables according to your environment.

1. Initialize the current directory and the required Terraform provider for VMware vSphere.

   ```console
   terraform init
   ```

1. Create a Terraform plan and save the output to a file.

   ```console
   terraform plan -out=tfplan
   ```

1. Apply the Terraform plan.

   ```console
   terraform apply tfplan
   ```

Once the custom vSphere role is created, assign **Global Permissions** in vSphere for the service account that will be used for the HashiCorp Packer to VMware vSphere integration in the next step. Global permissions are required for the content library. For example:

1. Log in to the vCenter Server at _<management_vcenter_server_fqdn>/ui_ as `administrator@vsphere.local`.
1. Select **Menu** > **Administration**.
1. Create service account in vSphere SSO if it does not exist: In the left pane, select **Single Sign On** > **Users and Groups** and click on **Users**, from the dropdown select the domain in which you want to create the user (_e.g.,_ rainpole.io) and click **ADD**, fill all the username (_e.g.,_ svc-packer-vsphere) and all required details, then click **ADD** to create the user.
1. In the left pane, select **Access control** > **Global permissions** and click the **Add permissions** icon.
1. In the **Add permissions** dialog box, enter the service account (_e.g.,_ svc-packer-vsphere@rainpole.io), select the custom role (_e.g.,_ Packer to vSphere Integration Role) and the **Propagate to children** checkbox, and click OK.

In an environment with many vCenter Server instances, such as management and workload domains, you may wish to further reduce the scope of access across the infrastructure in vSphere for the service account. For example, if you do not want Packer to have access to your management domain, but only allow access to workload domains:

1. From the **Hosts and clusters** inventory, select management domain vCenter Server to restrict scope, and click the **Permissions** tab.

1. Select the service account with the custom role assigned and click the **Edit**.

1. In the **Change role** dialog box, from the **Role** drop-down menu, select **No Access**, select the **Propagate to children** checkbox, and click **OK**.

### Step 3 - Configure the Variables

The [variables][packer-variables] are defined in `.pkrvars.hcl` files.

#### Copy the Example Variables

Run the config script `./config.sh` to copy the `.pkrvars.hcl.example` files to the `config` directory.

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

Edit the `config/build.pkrvars.hcl` file to configure the following:

- Credentials for the default account on machine images.

**Example**: `config/build.pkrvars.hcl`

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

**Example**: mkpasswd using Docker on Photon:

```console
rainpole@photon> sudo systemctl start docker
rainpole@photon> sudo docker run -it --rm alpine:latest
mkpasswd -m sha512
Password: ***************
[password hash]
rainpole@photon> sudo systemctl stop docker
```

**Example**: mkpasswd using Docker on macOS:

```console
rainpole@macos> docker run -it --rm alpine:latest
mkpasswd -m sha512
Password: ***************
[password hash]
```

**Example**: mkpasswd on Ubuntu:

```console
rainpole@ubuntu> mkpasswd -m sha-512
Password: ***************
[password hash]
```

Generate a public key for the `build_key` for public key authentication.

**Example**: macOS and Linux.

```console
rainpole@macos> ssh-keygen -t ecdsa -b 512 -C "code@rainpole.io"
Generating public/private ecdsa key pair.
Enter file in which to save the key (/Users/rainpole/.ssh/id_ecdsa):
Enter passphrase (empty for no passphrase): **************
Enter same passphrase again: **************
Your identification has been saved in /Users/rainpole/.ssh/id_ecdsa.
Your public key has been saved in /Users/rainpole/.ssh/id_ecdsa.pub.
```

The content of the public key, `build_key`, is added the key to the `~/.ssh/authorized_keys` file of the `build_username` on the guest operating system.

> **Warning**
>
> Replace the default public keys and passwords.
>
> By default, both Public Key Authentication and Password Authentication are enabled for Linux distributions. If you wish to disable Password Authentication and only use Public Key Authentication, comment or remove the portion of the associated Ansible `configure` role.

##### Ansible Variables

Edit the `config/ansible.pkrvars.hcl` file to configure the following:

- Credentials for the Ansible account on Linux machine images.

**Example**: `config/ansible.pkrvars.hcl`

```hcl
ansible_username = "ansible"
ansible_key      = "<public_key>"
```

> **Note**
>
> A random password is generated for the Ansible user.

You can also override the `ansible_key` value with contents of a file, if required.

For example:

```hcl
ansible_key = file("${path.root}/config/ssh/ansible_id_ecdsa.pub")
```

##### Common Variables

Edit the `config/common.pkrvars.hcl` file to configure the following common variables:

- Virtual Machine Settings
- Template and Content Library Settings
- OVF Export Settings
- Removable Media Settings
- Boot and Provisioning Settings
- HCP Packer Registry

**Example**: `config/common.pkrvars.hcl`

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

##### Data Source Options

`http` is the default provisioning data source for Linux machine image builds.

If iptables is enabled on your Packer host, you will need to open `common_http_port_min` through `common_http_port_max` ports.

**Example**: Open a port range in iptables.

```shell
iptables -A INPUT -p tcp --match multiport --dports 8000:8099 -j ACCEPT`
```

You can change the `common_data_source` from `http` to `disk` to build supported Linux machine images without the need to use Packer's HTTP server. This is useful for environments that may not be able to route back to the system from which Packer is running.

The `cd_content` option is used when selecting `disk` unless the distribution does not support a secondary CD-ROM. For distributions that do not support a secondary CD-ROM the `floppy_content` option is used.

```hcl
common_data_source = "disk"
```

##### HTTP Binding (Optional)

If you need to define a specific IPv4 address from your host for Packer's HTTP Server, modify the `common_http_ip` variable from `null` to a `string` value that matches an IP address on your Packer host. For example:

```hcl
common_http_ip = "172.16.11.254"
```

##### Proxy Variables (Optional)

Edit the `config/proxy.pkrvars.hcl` file to configure the following:

- SOCKS proxy settings used for connecting to Linux machine images.
- Credentials for the proxy server.

**Example**: `config/proxy.pkrvars.hcl`

```hcl
communicator_proxy_host     = "proxy.rainpole.io"
communicator_proxy_port     = 8080
communicator_proxy_username = "rainpole"
communicator_proxy_password = "<plaintext_password>"
```

##### Red Hat Subscription Manager Variables

Edit the `config/redhat.pkrvars.hcl` file to configure the following:

- Credentials for your Red Hat Subscription Manager account.

**Example**: `config/redhat.pkrvars.hcl`

```hcl
rhsm_username = "rainpole"
rhsm_password = "<plaintext_password>"
```

These variables are **only** used if you are performing a Red Hat Enterprise Linux Server build and are used to register the image with Red Hat Subscription Manager during the build for system updates and package installation. Before the build completes, the machine image is unregistered from Red Hat Subscription Manager.

##### SUSE Customer Connect Variables

Edit the `config/scc.pkrvars.hcl` file to configure the following:

- Credentials for your SUSE Customer Connect account.

**Example**: `config/scc.pkrvars.hcl`

```hcl
scc_email = "hello@rainpole.io"
scc_code  = "<plaintext_code>"
```

These variables are **only** used if you are performing a SUSE Linux Enterprise Server build and are used to register the image with SUSE Customer Connect during the build for system updates and package installation. Before the build completes, the machine image is unregistered from SUSE Customer Connect.

##### vSphere Variables

Edit the `builds/vsphere.pkrvars.hcl` file to configure the following:

- vSphere Endpoint and Credentials
- vSphere Settings

**Example**: `config/vsphere.pkrvars.hcl`

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

#### Using Environment Variables

If you prefer not to save potentially sensitive information in cleartext files, you add the variables to environmental variables using the included `set-envvars.sh` script:

```console
rainpole@macos> . ./set-envvars.sh
```

> **Note**
>
> You need to run the script as source or the shorthand "`.`".

#### Machine Image Variables (Optional)

Edit the `*.auto.pkrvars.hcl` file in each `builds/<type>/<build>` folder to configure the following virtual machine hardware settings, as required:

- CPUs `(int)`
- CPU Cores `(int)`
- Memory in MB `(int)`
- Primary Disk in MB `(int)`
- .iso URL `(string)`
- .iso Path `(string)`
- .iso File `(string)`
- .iso Checksum Type `(string)`
- .iso Checksum Value `(string)`

  > **Note**
  >
  > All `variables.auto.pkrvars.hcl` default to using the [VMware Paravirtual SCSI controller][vmware-pvscsi] and the [VMXNET 3][vmware-vmxnet3] network card device types.

### Step 4 - Guest Operating Systems ISOs

The project supports configuring the ISO from either a datastore or URL source. By default, the project uses the datastore source.

Follow the steps below to configure either option.

#### Using a Datastore Source

If you are using a datastore to store your guest operating system [`.iso`][iso] files, you must download and upload these to a datastore path.

1. Download the x64 guest operating system `.iso` files.

   <details>
   <summary>Linux Distributions:</summary>

   - VMware Photon OS 4
     - [Download][download-linux-photon-server-4] the latest release of the **FULL** `.iso` image. (_e.g._ `photon-4.0-xxxxxxxxx.iso`)
   - Debian 11
     - [Download][download-linux-debian-11] the 11.5 **netinst** release `.iso` image. (_e.g._ `debian-11.x.0-amd64-netinst.iso`)
   - Ubuntu Server 22.04 LTS
     - [Download][download-linux-ubuntu-server-22-04-lts] the latest **LIVE** release `.iso` image. (_e.g.,_ `ubuntu-22.04.x-live-server-amd64.iso`)
   - Ubuntu Server 20.04 LTS
     - [Download][download-linux-ubuntu-server-20-04-lts] the latest **LIVE** release `.iso` image. (_e.g.,_ `ubuntu-20.04.x-live-server-amd64.iso`)
   - Ubuntu Server 18.04 LTS
     - [Download][download-linux-ubuntu-server-18-04-lts] the latest legacy **NON-LIVE** release `.iso` image. (_e.g.,_ `ubuntu-18.04.x-server-amd64.iso`)
   - Red Hat Enterprise Linux 9 Server
     - [Download][download-linux-redhat-server-9] the latest release of the **FULL** `.iso` image. (_e.g.,_ `rhel-baseos-9.x-x86_64-dvd.iso`)
   - Red Hat Enterprise Linux 8 Server
     - [Download][download-linux-redhat-server-8] the latest release of the **FULL** `.iso` image. (_e.g.,_ `rhel-8.x-x86_64-dvd1.iso`)
   - Red Hat Enterprise Linux 7 Server
     - [Download][download-linux-redhat-server-7] the latest release of the **FULL** `.iso` image. (_e.g.,_ `rhel-server-7.x-x86_64-dvd1.iso`)
   - AlmaLinux OS 9
     - [Download][download-linux-almalinux-server-9] the latest release of the **FULL** `.iso` image. (_e.g.,_ `AlmaLinux-9.x-x86_64-dvd1.iso`)
   - AlmaLinux OS 8
     - [Download][download-linux-almalinux-server-8] the latest release of the **FULL** `.iso` image. (_e.g.,_ `AlmaLinux-8.x-x86_64-dvd1.iso`)
   - Rocky Linux 9
     - [Download][download-linux-rocky-server-9] the latest release of the **FULL** `.iso` image. (_e.g.,_ `Rocky-9.x-x86_64-dvd1.iso`)
   - Rocky Linux 8
     - [Download][download-linux-rocky-server-8] the latest release of the **FULL** `.iso` image. (_e.g.,_ `Rocky-8.x-x86_64-dvd1.iso`)
   - CentOS Stream 9
     - [Download][download-linux-centos-stream-9] the latest release of the **FULL** `.iso` image. (_e.g.,_ `CentOS-Stream-9-xxxxxxxx.x-x86_64-dvd1.iso`)
   - CentOS Stream 8
     - [Download][download-linux-centos-stream-8] the latest release of the **FULL** `.iso` image. (_e.g.,_ `CentOS-Stream-8-x86_64-xxxxxxxx-dvd1.iso`)
   - CentOS Linux 7
     - [Download][download-linux-centos-server-7] the latest release of the **FULL** `.iso` image. (_e.g.,_ `CentOS-7-x86_64-DVD.iso`)
   - SUSE Linux Enterprise 15 \* [Download][download-suse-linux-enterprise-15] the latest 15.4 release of the **FULL** `.iso` image. (_e.g.,_ `SLE-15-SP4-Full-x86_64-GM-Media1.iso`)
   </details>

   <details>
   <summary>Microsoft Windows:</summary>

   - Microsoft Windows Server 2022
   - Microsoft Windows Server 2019
   - Microsoft Windows 11
   - Microsoft Windows 10
   </details>

1. Obtain the checksum type (_e.g.,_ `sha256`, `md5`, etc.) and checksum value for each guest operating system `.iso` from the vendor. This will be use in the build input variables.

1. [Upload][vsphere-upload] or your guest operating system `.iso` files to the datastore and update the configuration variables, leaving the `iso_url` variable as `null`.

   **Example**: `config/common.pkrvars.hcl`

   ```hcl
   common_iso_datastore = "sfo-w01-cl01-ds-nfs01"
   ```

   **Example**: `builds/<type>/<build>/*.auto.pkrvars.hcl`

   ```hcl
   iso_url            = null
   iso_path           = "iso/linux/photon"
   iso_file           = "photon-4.0-xxxxxxxxx.iso"
   iso_checksum_type  = "md5"
   iso_checksum_value = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
   ```

#### Using a URL Source

If you are using a URL source to obtain your guest operating system [`.iso`][iso] files, you must update the input variables to use the URL source.

Update the `iso_url` variable to download the `.iso` from a URL. The `iso_url` variable takes presedence over any other `iso_*` variables.

**Example**: `builds/<type>/<build>/*.auto.pkrvars.hcl`

```hcl
iso_url = "https://artifactory.rainpole.io/iso/linux/photon/4.0/x86_64/photon-4.0-xxxxxxxxx.iso"
```

### Step 5 - Modify the Configurations (Optional)

If required, modify the configuration files for the Linux distributions and Microsoft Windows.

#### Linux Distribution Kickstart and Ansible Roles

Username and password variables are passed into the kickstart or [cloud-init][cloud-init] files for each Linux distribution as Packer template files (`.pkrtpl.hcl`) to generate these on-demand. Ansible roles are then used to configure the Linux machine image builds.

#### Microsoft Windows Unattended amd Scripts

Variables are passed into the [Microsoft Windows][microsoft-windows-unattend] unattend files (`autounattend.xml`) as Packer template files (`autounattend.pkrtpl.hcl`) to generate these on-demand. By default, each unattended file is set to use the [KMS client setup keys][microsoft-kms] as the **Product Key**.

PowerShell scripts are used to configure the Windows machine image builds.

Need help customizing the configuration files?

- **VMware Photon OS** - Read the [Photon OS Kickstart Documentation][photon-kickstart].
- **Ubuntu Server** - Install and run system-config-kickstart on a Ubuntu desktop.

  ```console
  sudo apt-get install system-config-kickstart
  ssh -X rainpole@ubuntu
  sudo system-config-kickstart
  ```

- **Red Hat Enterprise Linux** (_as well as CentOS Linux/Stream, AlmaLinux OS, and Rocky Linux_) - Use the [Red Hat Kickstart Generator][redhat-kickstart].
- **SUSE Linux Enterprise Server** - Use the [SUSE Configuration Management System][suse-autoyast].
- **Microsoft Windows** - Use the Microsoft Windows [Answer File Generator][microsoft-windows-afg] if you need to customize the provided examples further.

### Step 6 - Enable HCP Packer Registry (Optional)

If you are new to HCP Packer, review the following documentation and video to learn more before enabling an HCP Packer registry:

- [What is HCP Packer?][hcp-packer-docs]
- [Introduction to HCP Packer][hcp-packer-intro]

#### Create an HCP Packer Registry

Before you can use the HCP Packer registry, you need to create it by following [Create HCP Packer Registry][hcp-packer-create] procedure.

#### Configure an HCP Packer Registry

Edit the `config/common.pkrvars.hcl` file to enable the HCP Packer registry.

```hcl
// HCP Packer
common_hcp_packer_registry_enabled = true
```

Then, export your HCP credentials before building.

```console
rainpole@macos> export HCP_CLIENT_ID=<client_id>
rainpole@macos> export HCP_CLIENT_SECRET=<client_secret>
```

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

You can set your environment variables if you would prefer not to save sensitive information in cleartext files.

You can add these to environmental variables using the included `set-envvars.sh` script.

```console
rainpole@macos> . ./set-envvars.sh
```

> **Note**
>
> You need to run the script as source or the shorthand "`.`".

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

### Generate a Custom Build Script

The build script (`./build.sh`) can be generated using a template (`./build.tmpl`) and a configuration file in YAML (`./build.yaml`).

Generate a custom build script:

```console
rainpole@macos> gomplate -c build.yaml -f build.tmpl -o build.sh
```

Happy building!!!

## Troubleshoot

- Read [Debugging Packer Builds][packer-debug].

## Credits

- Owen Reynolds [@OVDamn][credits-owen-reynolds-twitter]

  [VMware Tools for Windows][credits-owen-reynolds-github] installation PowerShell script.

[//]: Links
[ansible-docs]: https://docs.ansible.com
[cloud-init]: https://cloudinit.readthedocs.io/en/latest/
[credits-owen-reynolds-twitter]: https://twitter.com/OVDamn
[credits-owen-reynolds-github]: https://github.com/getvpro/Build-Packer/blob/master/Scripts/Install-VMTools.ps1
[download-git]: https://git-scm.com/downloads
[download-linux-almalinux-server-8]: https://mirrors.almalinux.org/isos/x86_64/8.6.html
[download-linux-almalinux-server-9]: https://mirrors.almalinux.org/isos/x86_64/9.0.html
[download-linux-centos-server-7]: http://isoredirect.centos.org/centos/7/isos/x86_64/
[download-linux-centos-stream-9]: http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/
[download-linux-centos-stream-8]: http://isoredirect.centos.org/centos/8-stream/isos/x86_64/
[download-linux-debian-11]: https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/
[download-linux-photon-server-4]: https://packages.vmware.com/photon/4.0/
[download-linux-redhat-server-7]: https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.9/x86_64/product-software
[download-linux-redhat-server-8]: https://access.redhat.com/downloads/content/479/ver=/rhel---8/8.7/x86_64/product-software
[download-linux-redhat-server-9]: https://access.redhat.com/downloads/content/479/ver=/rhel---9/9.1/x86_64/product-software
[download-linux-rocky-server-9]: https://download.rockylinux.org/pub/rocky/9/isos/x86_64/
[download-linux-rocky-server-8]: https://download.rockylinux.org/pub/rocky/8/isos/x86_64/
[download-suse-linux-enterprise-15]: https://www.suse.com/download/sles/#
[download-linux-ubuntu-server-18-04-lts]: http://cdimage.ubuntu.com/ubuntu/releases/18.04.5/release/
[download-linux-ubuntu-server-20-04-lts]: https://releases.ubuntu.com/20.04/
[download-linux-ubuntu-server-22-04-lts]: https://releases.ubuntu.com/22.04/
[gomplate-install]: https://gomplate.ca/
[hcp-packer-create]: https://learn.hashicorp.com/tutorials/packer/hcp-push-image-metadata?in=packer/hcp-get-started#create-hcp-packer-registry
[hcp-packer-docs]: https://developer.hashicorp.com/hcp/docs/packer
[hcp-packer-intro]: https://www.youtube.com/watch?v=r0I4TTO957w
[hcp-security]: https://www.hashicorp.com/security
[iso]: https://en.wikipedia.org/wiki/ISO_image
[jq]: https://stedolan.github.io/jq/
[microsoft-kms]: https://docs.microsoft.com/en-us/windows-server/get-started/kmsclientkeys
[microsoft-windows-afg]: https://www.windowsafg.com
[microsoft-windows-unattend]: https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/
[packer]: https://www.packer.io
[packer-debug]: https://developer.hashicorp.com/packer/docs/debugging
[packer-install]: https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
[packer-plugin-git]: https://github.com/ethanmdavidson/packer-plugin-git
[packer-plugin-vsphere]: https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso
[packer-plugin-windows-update]: https://github.com/rgl/packer-plugin-windows-update
[packer-variables]: https://developer.hashicorp.com/packer/docs/templates/hcl_templates/variables
[photon-kickstart]: https://vmware.github.io/photon/docs/user-guide/kickstart-through-http/packer-template/
[redhat-kickstart]: https://access.redhat.com/labs/kickstartconfig/
[suse-autoyast]: https://documentation.suse.com/sles/15-SP3/single-html/SLES-autoyast/index.html#CreateProfile-CMS
[terraform-install]: https://www.terraform.io/docs/cli/install/apt.html
[vmware-pvscsi]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.hostclient.doc/GUID-7A595885-3EA5-4F18-A6E7-5952BFC341CC.html
[vmware-vmxnet3]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AF9E24A8-2CFA-447B-AC83-35D563119667.html
[vsphere-content-library]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-254B2CE8-20A8-43F0-90E8-3F6776C2C896.html
[vsphere-upload]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.storage.doc/GUID-58D77EA5-50D9-4A8E-A15A-D7B3ABA11B87.html
[vsphere-tpm]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-4DBF65A4-4BA0-4667-9725-AE9F047DE00A.html
