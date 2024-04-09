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
| Operating System                                         | Version   | Architecture           |
| :---                                                     | :---      | :---                   |
| :fontawesome-brands-linux: &nbsp;&nbsp; VMware Photon OS | 5.0       | `x86_64`               |
| :fontawesome-brands-ubuntu: &nbsp;&nbsp; Ubuntu Server   | 22.04 LTS | `x86_64`               |
| :fontawesome-brands-apple: &nbsp;&nbsp; macOS @span      | Sonoma    | Intel or Apple Silicon |
::end-spantable::

## :simple-packer: &nbsp; Packer

### :octicons-terminal-24: &nbsp; Packer CLI

HashiCorp [Packer][packer-install] 1.10.0 or higher.

=== ":fontawesome-brands-linux: &nbsp; VMware Photon OS"

    You can install Packer on VMware Photon OS using the following commands:

    ```shell
    PACKER_VERSION="1.10.0"
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

          You can verify that the fingerprint matches the HashiCorp public key published on [Security at HashiCorp][hcp-security].

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

For disconnected sites (_e.g._, air-gapped or dark sites), you may download the plugins and place
these same directory as your Packer executable `/usr/local/bin` or `$HOME/.packer.d/plugins`.

| Plugin                                                           | Version  | Description      | Resources                                                                                                               |
| :---                                                             | :---     | :---             | :---                                                                                                                    |
| :simple-hashicorp: &nbsp;&nbsp; Packer Plugin for Ansible        | >= 1.1.0 | By HashiCorp     | [:fontawesome-brands-github:][packer-plugin-ansible-repo] &nbsp;&nbsp; [:material-library:][packer-plugin-ansible-docs] |
| :simple-hashicorp: &nbsp;&nbsp; Packer Plugin for VMware vSphere | >= 1.2.7 | By HashiCorp     | [:fontawesome-brands-github:][packer-plugin-vsphere-repo] &nbsp;&nbsp; [:material-library:][packer-plugin-vsphere-docs] |
| :fontawesome-brands-git: &nbsp;&nbsp; Packer Plugin for Git      | >= 0.6.2 | Community Plugin | [:fontawesome-brands-github:][packer-plugin-git-repo]     &nbsp;&nbsp; [:material-library:][packer-plugin-git-docs]     |


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

    - HashiCorp [Terraform][terraform-install] 1.7.1 or higher.

        ```shell
        TERRAFORM_VERSION="1.7.1"
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

    - HashiCorp [Terraform][terraform-install] 1.7.1 or higher.

        ```shell
        pip3 install --user ansible-core==2.15
        sudo apt -y install git jq xorriso whois terraform
        ```

    - [gomplate][gomplate-install] 3.11.7 or higher.

        ```shell
        GOMPLATE_VERSION="3.11.7"
        LINUX_ARCH="amd64"

        sudo curl -o /usr/local/bin/gomplate -sSL https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-${LINUX_ARCH}
        sudo chmod 755 /usr/local/bin/gomplate
        ```

=== ":fontawesome-brands-apple: &nbsp; macOS"

    - [git][download-git] command-line tools.
    - [ansible-core][ansible-docs] 2.15.
    - [jq][jq] - A command-line JSON processor.
    - Coreutils
    - HashiCorp [Terraform][terraform-install] 1.7.1 or higher.
    - [gomplate][gomplate-install] 3.11.7 or higher.

        ```shell
        pip3 install --user ansible-core==2.15
        brew install git jq coreutils hashicorp/tap/terraform gomplate
        ```

    - mkpasswd - A password generating utility.

        ```shell
        brew install --cask docker
        ```
[^1]: The project may work on other operating systems and versions, but has not been tested by the
maintainers.

[//]: Links
[ansible-docs]: https://docs.ansible.com
[ansible-ssh-connection]: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ssh_connection.html#parameter-scp_if_ssh
[download-git]: https://git-scm.com/downloads
[gomplate-install]: https://gomplate.ca/
[hcp-security]: https://www.hashicorp.com/security
[homebrew]: https://brew.sh/
[jq]: https://stedolan.github.io/jq/
[packer-install]: https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
[packer-plugin-ansible-docs]: https://developer.hashicorp.com/packer/integrations/hashicorp/ansible
[packer-plugin-ansible-repo]: https://github.com/hashicorp/packer-plugin-ansible
[packer-plugin-git-docs]: https://developer.hashicorp.com/packer/integrations/ethanmdavidson/git
[packer-plugin-git-repo]: https://github.com/ethanmdavidson/packer-plugin-git
[packer-plugin-vsphere-docs]: https://developer.hashicorp.com/packer/plugins/builders/vsphere
[packer-plugin-vsphere-repo]: https://github.com/hashicorp/packer-plugin-vsphere
[terraform-install]: https://www.terraform.io/docs/cli/install/apt.html
