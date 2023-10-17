---
icon: octicons/play-24
---

# Build

## Build Script Options

If you need help for script options, pass the `--help` or `-h` flag to the build script to display the help for the build script.

```shell
./build.sh --help
```

If you need to enable debugging, pass the `--debug` or `-d` flag to the build script to enable debug mode for Packer.

This example will look for the configuration files in the `config` directory and enable debug mode for Packer.

```shell
./build.sh --debug
```

This example will look for the configuration files in the `us-west-1` directory and enable debug mode for Packer.

```shell
./build.sh --debug us-west-1
```

## Using the Build Script

### Build with Defaults

Start a build by running the build script (`./build.sh`). The script presents a menu the which simply calls Packer and the respective build(s).

This example will look for the configuration files in the `config` directory.

```shell
./build.sh
```

### Build a Specific Configuration

This example will look for the configuration files in the `us-west-1` directory.

```shell
./build.sh us-west-1
```

## Generate a Custom Build Script

The build script (`./build.sh`) can be generated with Gomplate using a template (`./build.tmpl`) and a configuration file in YAML (`./build.yaml`).

Generate a custom build script:

```shell
gomplate -c build.yaml -f build.tmpl -o build.sh
```

or

```shell
make update-build-script
```

## Build Directly with Packer

You can also start a build based on a specific source for some of the virtual machine images.

For example, if you simply want to build a Microsoft Windows Server 2022 Standard Core, run the following:

Initialize the plugins:

```shell
packer init builds/windows/server/2022/.
```

Build a specific machine image:

```shell
packer build -force on-error=ask\
    --only vsphere-iso.windows-server-standard-core \
    -var-file="config/vsphere.pkrvars.hcl" \
    -var-file="config/build.pkrvars.hcl" \
    -var-file="config/common.pkrvars.hcl" \
    builds/windows/server/2022
```

## Build with Environmental Variables

You can set your environment variables if you would prefer not to save sensitive information in clear-text files.

You can add these to environmental variables using the included `set-envvars.sh` script.

```shell
. ./set-envvars.sh
```

???+ tip "Tip"
    You must run the script as source or the shorthand "`.`".

---

???+ note "Content Library"
    By default, the machine image artifacts are transferred to a [vSphere Content Library][vsphere-content-library] as an OVF template and the temporary machine image is destroyed. [^1]

    If an item of the same name exists in the target content library, Packer will update the existing item with the new version of OVF template.

[^1]: The Microsoft Windows 11 machine image uses a virtual trusted platform module (vTPM). Refer to the VMware vSphere [product documentation][vsphere-tpm] for requirements and pre-requisites. The Microsoft Windows 11 machine image is not transferred to the content library by default. It is **not supported** to clone an encrypted virtual machine to the content library as an OVF Template. You can adjust the common content library settings to use VM Templates.

[//]: Links
[vsphere-content-library]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-254B2CE8-20A8-43F0-90E8-3F6776C2C896.html
[vsphere-tpm]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-4DBF65A4-4BA0-4667-9725-AE9F047DE00A.html
