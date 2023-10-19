---
icon: octicons/verified-24
---

# Requirements

## :octicons-cloud-24: &nbsp; Platform

The project is tested on the following platforms:

::spantable::
| Platform              | Version                |
| --------------------- | ---------------------- |
| VMware vSphere @span  | 8.0 or later           |
|                       | 7.0 Update 3D or later |
::end-spantable::

## :octicons-stack-24: &nbsp; Operating Systems

The project is tested on the following operating systems for the Packer host [^1] :

::spantable::
| Operating System                                         | Version   | Architecture |
| :---                                                     | :---      | :---         |
| :fontawesome-brands-linux: &nbsp;&nbsp; VMware Photon OS | 5.0       | `x86_64`     |
| :fontawesome-brands-ubuntu: &nbsp;&nbsp; Ubuntu Server   | 22.04 LTS | `x86_64`     |
| :fontawesome-brands-apple: &nbsp;&nbsp; macOS @span      | Ventura   | Intel        |
|                                                          | Sonoma    | Intel        |
::end-spantable::

???+ tip ":material-greater-than-or-equal: OpenSSH 9.0"
    If your :material-ansible: [Ansible][ansible-ssh-connection] control node uses OpenSSH 9.0 or higher, you must add an additional option to enable `scp`.

    1. Check the OpenSSH version:

        ```shell
        ssh -V
        ```

    2. If the version is 9.0 or higher, add the following to your the `ansible/ansible.cfg` file:

        ```vi
        [ssh_connection]
        scp_extra_args = "-O"
        ```

## :simple-packer: &nbsp; Packer

### :octicons-terminal-24: &nbsp; Packer CLI

HashiCorp [Packer][packer-install] 1.9.4 or higher.

=== ":fontawesome-brands-linux: &nbsp; VMware Photon OS"

    You can install Packer on VMware Photon OS using the following commands:

    ```shell
    PACKER_VERSION="1.9.4"
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

=== ":fontawesome-brands-ubuntu: &nbsp; Ubuntu"

    You must configure your system to trust that HashiCorp key for package authentication.

    1. Configure the repository:

          ```shell
          sudo bash -c 'wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg'
          ```

    2. Verify the fingerprint:

          ```shell
          gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
          ```

          The fingerprint must match `E8A0 32E0 94D8 EB4E A189 D270 DA41 8C88 A321 9F7B`. You can also verify the key on [Security at HashiCorp][hcp-security] under Linux Package Checksum Verification.

    3. Add the official HashiCorp repository to your system:

          ```shell
          sudo bash -c 'echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
          https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list'
          ```

    4. Install Packer from the HashiCorp repository:

          ```shell
          sudo apt update && sudo apt install packer
          ```

=== ":fontawesome-brands-apple: &nbsp; macOS"

    You can install Packer on macOS using :simple-homebrew: [Homebrew][homebrew].

    ```shell
    brew tap hashicorp/tap

    brew install hashicorp/tap/packer
    ```

### :octicons-plug-24: &nbsp; Packer Plugins

Required plugins are automatically downloaded and initialized when using `./build.sh`.

For air-gapped or dark sites, you may download the plugins and place these same directory as your Packer executable `/usr/local/bin` or `$HOME/.packer.d/plugins`.

| Plugin                                                                      | Version         | Description      | Resources                                                   |
| :---                                                                        | :---            | :---             | :---                                                        |
| :simple-hashicorp: &nbsp;&nbsp; Packer Plugin for VMware vSphere            | 1.2.1 or later  | By HashiCorp     | [:fontawesome-brands-github:][packer-plugin-vsphere] &nbsp;&nbsp;[:material-library:][packer-plugin-vsphere] |
| :fontawesome-brands-git: &nbsp;&nbsp; Packer Plugin for Git                 | 0.4.3 or later  | Community Plugin | [:fontawesome-brands-github:][packer-plugin-git]            |
| :fontawesome-brands-windows: &nbsp;&nbsp; Packer Plugin for Windows Updates | 0.14.3 or later | Community Plugin | [:fontawesome-brands-github:][packer-plugin-windows-update] |

## :octicons-package-dependencies-24: &nbsp; Additional Software Packages

The following additional software packages must be installed on the operating system running Packer.

=== ":fontawesome-brands-linux: &nbsp; VMware Photon OS"

    - [git][download-git] command-line tools.

    - [ansible-core][ansible-docs] 2.15.

    - [jq][jq] - A command-line JSON processor.

    - xorriso - A command-line ISO creator.

        ```shell
        pip3 install --user ansible-core==2.15
        export PATH="$HOME/.local/bin:$PATH"
        tdnf -y install git jq xorriso
        ```

    - HashiCorp [Terraform][terraform-install] 1.6.0 or higher.

        ```shell
        TERRAFORM_VERSION="1.6.0"
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

=== ":fontawesome-brands-ubuntu: &nbsp; Ubuntu"

    - [git][download-git] command-line tools.

    - [ansible-core][ansible-docs] 2.15.

    - [jq][jq] - A command-line JSON processor.

    - xorriso - A command-line ISO creator.

    - mkpasswd - A password generating utility.

    - HashiCorp [Terraform][terraform-install] 1.6.0 or higher.

        ```shell
        pip3 install --user ansible-core==2.15
        sudo apt -y install git jq xorriso whois terraform
        ```

    - [gomplate][gomplate-install] 3.11.5 or higher.

        ```shell
        GOMPLATE_VERSION="3.11.5"
        LINUX_ARCH="amd64"

        sudo curl -o /usr/local/bin/gomplate -sSL https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-${LINUX_ARCH}
        sudo chmod 755 /usr/local/bin/gomplate
        ```

=== ":fontawesome-brands-apple: &nbsp; macOS"

    - [git][download-git] command-line tools.
    - [ansible-core][ansible-docs] 2.15.
    - [jq][jq] - A command-line JSON processor.
    - Coreutils
    - HashiCorp [Terraform][terraform-install] 1.6.0 or higher.
    - [gomplate][gomplate-install] 3.11.5 or higher.

        ```shell
        pip3 install --user ansible-core==2.15
        brew install git jq coreutils hashicorp/tap/terraform gomplate
        ```

    - mkpasswd - A password generating utility.

        ```shell
        brew install --cask docker
        ```
[^1]: The project may work on other operating systems and versions, but has not been tested by the maintainers.

[//]: Links
[ansible-docs]: https://docs.ansible.com
[ansible-ssh-connection]: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ssh_connection.html#parameter-scp_if_ssh
[download-git]: https://git-scm.com/downloads
[gomplate-install]: https://gomplate.ca/
[hcp-security]: https://www.hashicorp.com/security
[homebrew]: https://brew.sh/
[jq]: https://stedolan.github.io/jq/
[packer-install]: https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
[packer-plugin-git]: https://github.com/ethanmdavidson/packer-plugin-git
[packer-plugin-vsphere]: https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso
[packer-plugin-windows-update]: https://github.com/rgl/packer-plugin-windows-update
[terraform-install]: https://www.terraform.io/docs/cli/install/apt.html
