---
icon: octicons/verified-24
---

# Environment Requirements

## :octicons-cloud-24: &nbsp; Platform

The project is tested on the following platforms:

::spantable::
| Platform        | Version               |
| --------------- | --------------------- |
| VMware vSphere  | 8.0 or later          |
| VMware vSphere  | 7.0 Update 3D or later|
::end-spantable::

## :octicons-stack-24: &nbsp; Operating Systems

The project is tested on the following operating systems for the Packer host [^1] :

::spantable::
| Operating System   | Version   | Architecture           |
| :----------------- | :-------- | :--------------------- |
| VMware Photon OS   | 5.0       | `x86_64`               |
| Ubuntu Server      | 22.04 LTS | `x86_64`               |
| macOS              | Sonoma    | Intel or Apple Silicon |
::end-spantable::

## :simple-packer: &nbsp; Packer

| Component                                                        | Version   | Description      | Resources                                                                                                               |
| :--------------------------------------------------------------- | :-------- | :--------------- | :---------------------------------------------------------------------------------------------------------------------- |
| :simple-packer: &nbsp;&nbsp; Packer                              | >= 1.12.0 | By HashiCorp     | [:fontawesome-brands-github:][packer-repo] &nbsp;&nbsp; [:material-library:][packer]                                    |
| :simple-hashicorp: &nbsp;&nbsp; Packer Plugin for Ansible        | >= 1.1.4  | By HashiCorp     | [:fontawesome-brands-github:][packer-plugin-ansible-repo] &nbsp;&nbsp; [:material-library:][packer-plugin-ansible]      |
| :simple-hashicorp: &nbsp;&nbsp; Packer Plugin for VMware vSphere | >= 2.0.0  | By HashiCorp     | [:fontawesome-brands-github:][packer-plugin-vsphere-repo] &nbsp;&nbsp; [:material-library:][packer-plugin-vsphere-docs] |
| :fontawesome-brands-git: &nbsp;&nbsp; Packer Plugin for Git      | >= 0.6.3  | Community Plugin | [:fontawesome-brands-github:][packer-plugin-git-repo] &nbsp;&nbsp; [:material-library:][packer-plugin-git-docs]         |

### Installation

=== ":fontawesome-brands-linux: &nbsp; VMware Photon OS"

    You can install Packer on VMware Photon OS using the following commands:

    ```shell
    export PACKER_VERSION="1.12.0"
    export OS_PACKAGES="wget unzip"

    tdnf install ${OS_PACKAGES} -y
    wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
    unzip -o -d /usr/local/bin/ packer_${PACKER_VERSION}_linux_amd64.zip
    ```

=== ":fontawesome-brands-ubuntu: &nbsp; Ubuntu"

    You can install Packer on Ubuntu using the following commands:.

    1. Configure the repository:

          ```shell
          sudo bash -c 'wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg'
          ```

    2. Verify the fingerprint:

          ```shell
          gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
          ```

          You can verify that the fingerprint matches the HashiCorp public key published on
          [Security at HashiCorp][hcp-security].

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

Required plugins are automatically downloaded and initialized when using `./build.sh`.

For disconnected sites you may download the plugins and place these same directory as your Packer
executable `/usr/local/bin` or `$HOME/.packer.d/plugins`.

## :octicons-package-dependencies-24: &nbsp; Additional Packages

The following additional software packages must be installed on the operating system running Packer.

| Package                                                | Version   | Description                                        | Resources                       |
| :----------------------------------------------------- |:----------| :------------------------------------------------- | :------------------------------ |
| :simple-ansible: &nbsp;&nbsp; ansible-core             | >= 2.16   | Automation engine for IT infrastructure            | [:material-library:][ansible]   |
| :fontawesome-brands-git: &nbsp;&nbsp; git              | >= 2.43.0 | Version control system for tracking changes        | [:material-library:][git]       |
| :material-code-braces: &nbsp;&nbsp; gomplate           | >= 4.3.0  | Template renderer                                  | [:material-library:][gomplate]  |
| :simple-json: &nbsp;&nbsp; jq                          | >= 1.8.3  | Command-line JSON parser                           | [:material-library:][jq]        |
| :simple-terraform: &nbsp;&nbsp; terraform              | >= 1.10.0 | Infrastructure as Code (IaC) tool by HashiCorp     | [:material-library:][terraform] |
| :fontawesome-solid-compact-disc: &nbsp;&nbsp; xorriso  | >= 1.5.6  | ISO filesystem images creator for Linux             | [:material-library:][xorriso]   |

### Installation

=== ":fontawesome-brands-linux: &nbsp; VMware Photon OS"

    Packages:

    ```shell
    tdnf -y install ansible git jq xorriso wget unzip
    echo "ansible-core $(ansible --version | grep 'ansible.*core' | awk '{print $3}' | tr -d ']')"
    echo "terraform $(terraform version | awk -Fv '{print $2}' | head -n 1)"
    export PATH="$HOME/.local/bin:$PATH"
    ```

    Terraform:

    ```shell
    export TERRAFORM_VERSION="1.10.0"
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    unzip -o -d /usr/local/bin/ terraform_${TERRAFORM_VERSION}_linux_${LINUX_ARCH}.zip
    ```

    Gomplate

    ```shell
    export GOMPLATE_VERSION="4.3.0"
    wget -q https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64
    chmod +x gomplate_linux-amd64
    sudo mv gomplate_linux-amd64 /usr/local/bin/gomplate
    ```

=== ":fontawesome-brands-ubuntu: &nbsp; Ubuntu"

    Packages:

    ```shell
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y python3 python3-pip ansible git jq xorriso whois unzip terraform
    echo "ansible-core $(ansible --version | grep 'ansible.*core' | awk '{print $3}' | tr -d ']')"
    echo "terraform $(terraform version | awk -Fv '{print $2}' | head -n 1)"
    export PATH="$HOME/.local/bin:$PATH"
    ```

    Gomplate:

    ```shell
    export GOMPLATE_VERSION="4.3.0"
    wget -q https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64
    chmod +x gomplate_linux-amd64
    sudo mv gomplate_linux-amd64 /usr/local/bin/gomplate
    ```

=== ":fontawesome-brands-apple: &nbsp; macOS"

    Packages

    ```shell
    brew install ansible git jq coreutils hashicorp/tap/terraform gomplate
    echo "ansible-core $(ansible --version | grep 'ansible.*core' | awk '{print $3}' | tr -d ']')"
    echo "terraform $(terraform version | awk -Fv '{print $2}' | head -n 1)"
    export PATH="$HOME/.local/bin:$PATH"
    ```

[^1]:
    The project may work on other operating systems and versions, but has not been tested by the
    maintainers.

[//]: Links
[ansible]: https://docs.ansible.com
[git]: https://git-scm.com/downloads
[gomplate]: https://gomplate.ca/
[hcp-security]: https://www.hashicorp.com/security
[homebrew]: https://brew.sh/
[jq]: https://stedolan.github.io/jq/
[packer]: https://developer.hashicorp.com/packer
[packer-repo]: https://github.com/hashicorp/packer
[packer-plugin-ansible]: https://developer.hashicorp.com/packer/integrations/hashicorp/ansible
[packer-plugin-ansible-repo]: https://github.com/hashicorp/packer-plugin-ansible
[packer-plugin-git-docs]: https://developer.hashicorp.com/packer/integrations/ethanmdavidson/git
[packer-plugin-git-repo]: https://github.com/ethanmdavidson/packer-plugin-git
[packer-plugin-vsphere-docs]: https://developer.hashicorp.com/packer/plugins/builders/vsphere
[packer-plugin-vsphere-repo]: https://github.com/hashicorp/packer-plugin-vsphere
[terraform]: https://developer.hashicorp.com/terraform
[xorriso]: https://www.gnu.org/software/xorriso/
