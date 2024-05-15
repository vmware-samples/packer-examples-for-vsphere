---
icon: octicons/play-24
---

# Build the Images

## Using the Build Script

1. Start a build by running the build script (`./build.sh`).

      This example will look for the configuration files in the `config` directory.

      ```shell
      ./build.sh
      ```

       The script displays a menu to initialize a virtual machine image build(s).

       The builds are supported by a JSON configuration file (`project.json`) that includes the details for each guest operating system.

2. Select a guest operating system.

      ```shell
      Select a guest operating system:

      1: Linux
      2: Windows

      Enter q to quit or i for info.
      ```

3. Select a distribution (or edition).

      ```shell
      Select a Linux distribution:

      1: AlmaLinux OS
      2: CentOS
      3: Debian
      4: Fedora Server
      5: Oracle Linux
      6: Red Hat Enterprise Linux
      7: Rocky Linux
      8: SUSE Linux Enterprise Server
      9: Ubuntu Server
      10: VMware Photon OS

      Enter b to go back, or q to quit.
      ```

4. Select a version.

      ```shell
      Select a version:

      1: Ubuntu Server 24.04 LTS
      2: Ubuntu Server 22.04 LTS
      3: Ubuntu Server 20.04 LTS

      Enter b to go back, or q to quit.
      ```

5. The build will start.

      ```shell
      Building a Ubuntu Server 24.04 LTS virtual machine image for VMware vSphere...

      Initializing HashiCorp Packer and required plugins...
      Starting the build of Ubuntu Server 24.04 LTS...
      vsphere-iso.linux-ubuntu: output will be in this color.
      ```

### Demo

![](../assets/images/build.gif)

## Build Script Options

You can use the following options with the script.

| Option   | Short Form | Description                                                     |
| -------- | ---------- | --------------------------------------------------------------- |
| `--help` | `-h`, `-H` | Display the help.                                               |
| `--json` | `-j`, `-J` | Override the default JSON configuration file.                   |
| `--show` | `-s`, `-S` | Display the command that the script uses to initialize a build. |

## Build Directly with Packer

You can also start a build based on a specific source for some of the virtual machine images.

For example, if you simply want to build only Microsoft Windows Server 2022 Standard Core, run the
following:

Initialize the plugins:

```shell
packer init builds/windows/server/2022/.
```

Build the specific machine image:

```shell
packer build -force on-error=ask \
    --only vsphere-iso.windows-server-standard-core \
    -var-file="config/build.pkrvars.hcl" \
    -var-file="config/common.pkrvars.hcl" \
    -var-file="config/vsphere.pkrvars.hcl" \
    builds/windows/server/2022
```

## Build with Environmental Variables

Use environment variables instead of providing sensitive credentials in clear-text files.

An environment variable will always take precedence over a configuration file value.

You can add the environmental variables using the `set-envvars.sh` script.

```shell
. ./set-envvars.sh
```

???+ tip "Tip"

    You must run the script as source or the shorthand "`.`".
---

???+ note "Content Library"

    By default, the machine image artifacts are transferred to a [vSphere Content Library][vsphere-content-library]
    as an OVF template and the temporary machine image is destroyed. [^1]

    If an item of the same name exists in the target content library, Packer will update the
    existing item with the new version of OVF template.

the VMware vSphere [product documentation][vsphere-tpm] for requirements and pre-requisites. The
Microsoft Windows 11 machine image is not transferred to the content library by default. It is **not
supported** to clone an encrypted virtual machine to the content library as an OVF Template. You can
adjust the common content library settings to use VM Templates.

[//]: Links
[vsphere-tpm]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-4DBF65A4-4BA0-4667-9725-AE9F047DE00A.html
