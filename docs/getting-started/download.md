---
icon: octicons/download-24
---

# Download

You can choose between two options to get the source code:

1. Download the latest release from GitHub.
2. Clone the repository from GitHub.

=== ":octicons-download-24: &nbsp; Download the Latest Release"

      ```shell
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

=== ":octicons-repo-clone-24: &nbsp; Clone the Repository"

      ```shell
      TAG_NAME=$(curl -s https://api.github.com/repos/vmware-samples/packer-examples-for-vsphere/releases | jq  -r '.[0].tag_name')

      git clone https://github.com/vmware-samples/packer-examples-for-vsphere.git
      cd packer-examples-for-vsphere
      git switch -c $TAG_NAME $TAG_NAME
      ```

???+ tip "Prerelease Updates"
      You may also clone the `develop` branch for the latest prerelease updates.

???+ info "Prerelease Updates"
    :octicons-git-branch-16: A branch is mandatory since it is used for the build version and in the virtual machine name.

    It does not matter if it is based on the `HEAD` or a release tag.

## :octicons-file-directory-24: &nbsp; Directory Structure

The directory structure of the project.

```shell
├── build.sh
├── build.tmpl
├── build-ci.tmpl
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
        ├── example
        │   └── *.tf
        └── ...
            └── *.tf
```

The following table describes the directory structure.

| Directory       | Description                                                                              |
| :---            | :---                                                                                     |
| **`ansible`**   | Contains the Ansible roles to prepare Linux machine image builds.                        |
| **`artifacts`** | Contains the OVF artifacts exported by the builds, if enabled.                           |
| **`builds`**    | Contains the templates, variables, and configuration files for the machine image builds. |
| **`manifests`** | Manifests created after the completion of the machine image builds.                      |
| **`scripts`**   | Contains the scripts to initialize and prepare Windows machine image builds.             |
| **`terraform`** | Contains example Terraform plans to create a custom role and test machine image builds.  |

???+ warning "Forking the Project"
    When forking the project for upstream contribution, please be mindful not to make changes that may expose your sensitive information, such as passwords, keys, certificates, etc.
