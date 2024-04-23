---
icon: octicons/stack-24
---

# Guest Operating Systems

The project allows the use of a datastore (default) or a content library to store your guest operating system [ISO][iso] files.

## :fontawesome-brands-linux: Linux Distributions

Download the Linux distribution ISO files from the publisher.

::spantable::
| Operating System                                                        | Version   | Download                                                                                                               |
| :---                                                                    | :---      | :---                                                                                                                   |
| :simple-vmware: &nbsp;&nbsp; VMware Photon OS @span                     | 5.0       | [:fontawesome-solid-cloud-arrow-down:][download-linux-photon-5] &nbsp; `photon-5.0-xxxxxxxxx.x86_64.iso`               |
|                                                                         | 4.0       | [:fontawesome-solid-cloud-arrow-down:][download-linux-photon-4] &nbsp; `photon-4.0-xxxxxxxxx.iso`                      |
| :fontawesome-brands-debian: &nbsp;&nbsp; Debian @span                   | 12        | [:fontawesome-solid-cloud-arrow-down:][download-linux-debian-12] &nbsp; `debian-12.x.x-amd64-netinst.iso`              |
|                                                                         | 11        | [:fontawesome-solid-cloud-arrow-down:][download-linux-debian-11] &nbsp; `debian-11.x.x-amd64-netinst.iso`              |
| :fontawesome-brands-ubuntu: &nbsp;&nbsp; Ubuntu Server @span            | 24.04 LTS | [:fontawesome-solid-cloud-arrow-down:][download-linux-ubuntu-2310] &nbsp; `ubuntu-24.04.x-live-server-amd64.iso`       |
|                                                                         | 22.04 LTS | [:fontawesome-solid-cloud-arrow-down:][download-linux-ubuntu-2204] &nbsp; `ubuntu-22.04.x-live-server-amd64.iso`       |
|                                                                         | 20.04 LTS | [:fontawesome-solid-cloud-arrow-down:][download-linux-ubuntu-2004] &nbsp; `ubuntu-20.04.x-live-server-amd64.iso`       |
| :fontawesome-brands-redhat: &nbsp;&nbsp; Red Hat Enterprise Linux @span | 9         | [:fontawesome-solid-cloud-arrow-down:][download-linux-rhel-9] &nbsp; `rhel-9.x-x86_64-dvd.iso`                         |
|                                                                         | 8         | [:fontawesome-solid-cloud-arrow-down:][download-linux-rhel-8] &nbsp; `rhel-8.x-x86_64-dvd.iso`                         |
|                                                                         | 7         | [:fontawesome-solid-cloud-arrow-down:][download-linux-rhel-7] &nbsp; `rhel-server-7.x-x86_64-dvd.iso`                  |
| :fontawesome-brands-linux: &nbsp;&nbsp; AlmaLinux OS @span              | 9         | [:fontawesome-solid-cloud-arrow-down:][download-linux-alma-9] &nbsp; `AlmaLinux-9.x-x86_64-dvd.iso`                    |
|                                                                         | 8         | [:fontawesome-solid-cloud-arrow-down:][download-linux-alma-8] &nbsp; `AlmaLinux-8.x-x86_64-dvd.iso`                    |
| :simple-rockylinux: &nbsp;&nbsp; Rocky Linux @span                      | 9         | [:fontawesome-solid-cloud-arrow-down:][download-linux-rocky-9] &nbsp; `Rocky-9.x-x86_64-dvd.iso`                       |
|                                                                         | 8         | [:fontawesome-solid-cloud-arrow-down:][download-linux-rocky-8] &nbsp; `Rocky-8.x-x86_64-dvd.iso`                       |
| :simple-oracle: &nbsp;&nbsp; Oracle Linux @span                         | 9         | [:fontawesome-solid-cloud-arrow-down:][download-linux-oracle-9] &nbsp; `OracleLinux-R9-U2-x86_64-dvd.iso`              |
|                                                                         | 8         | [:fontawesome-solid-cloud-arrow-down:][download-linux-oracle-8] &nbsp; `OracleLinux-R8-U8-x86_64-dvd.iso`              |
| :fontawesome-brands-centos: &nbsp;&nbsp; CentOS @span                   | 9 Stream  | [:fontawesome-solid-cloud-arrow-down:][download-linux-centos-stream-9] &nbsp; `CentOS-Stream-9-latest-x86_64-dvd1.iso` |
|                                                                         | 8 Stream  | [:fontawesome-solid-cloud-arrow-down:][download-linux-centos-stream-8] &nbsp; `CentOS-Stream-8-x86_64-latest-dvd1.iso` |
|                                                                         | 7         | [:fontawesome-solid-cloud-arrow-down:][download-linux-centos-7] &nbsp; `CentOS-7-x86_64-DVD.iso`                       |
| :fontawesome-brands-fedora: &nbsp;&nbsp; Fedora Server @span            | 39        | [:fontawesome-solid-cloud-arrow-down:][download-linux-centos-stream-9] &nbsp; `Fedora-Server-dvd-x86_64-39-x.iso.iso`  |
| :fontawesome-brands-suse: &nbsp;&nbsp; SUSE Linux Enterprise @span      | 15        | [:fontawesome-solid-cloud-arrow-down:][download-linux-sles-15] &nbsp; `SLE-15-SPx-Full-x86_64-GM-Media1.iso`           |
::end-spantable::

## :fontawesome-brands-windows: Microsoft Windows

Download the Microsoft Windows ISO files from the Microsoft.

::spantable::
| Operating System                                                         | Version | Download                                                                                              |
| :---                                                                     | :---    | :---                                                                                                  |
| :fontawesome-brands-windows: &nbsp;&nbsp; Microsoft Windows Server @span | 2025    | [:fontawesome-solid-cloud-arrow-down:][download-windows-server-2025] &nbsp; Windows Insiders Preview  |
|                                                                          | 2022    | [:fontawesome-solid-cloud-arrow-down:][download-windows-server-2022] &nbsp; Windows Evaluation Center |
|                                                                          | 2019    | [:fontawesome-solid-cloud-arrow-down:][download-windows-server-2019] &nbsp; Windows Evaluation Center |
| :fontawesome-brands-windows: &nbsp;&nbsp; Microsoft Windows @span        | 11      | [:fontawesome-solid-cloud-arrow-down:][download-windows-11] &nbsp; Windows Evaluation Center          |
|                                                                          | 10      | [:fontawesome-solid-cloud-arrow-down:][download-windows-10] &nbsp; Windows Evaluation Center          |
::end-spantable::

Upload the guest operating system ISO files to the datastore and update the path in the
configuration variables.

=== ":material-database: &nbsp; Datastore (Default)"

    ```hcl title="config/common.pkrvars.hcl"
    common_iso_datastore               = "sfo-w01-cl01-ds-nfs01"
    common_iso_content_library         = ""
    common_iso_content_library_enabled = false
    ```

=== ":material-library-shelves: &nbsp; Content Library"

    ```hcl title="config/common.pkrvars.hcl"
    common_iso_datastore               = ""
    common_iso_content_library         = "sfo-w01-lib01"
    common_iso_content_library_enabled = true
    ```

Update the ISO path and file for each guest operating system in the configuration variables.

```hcl title="builds/linux/photon/5/packer.auto.pkrvars.hcl"
iso_datastore_path       = "iso/linux/photon"
iso_content_library_item = "photon-5.0-xxxxxxxxx"
iso_file                 = "photon-5.0-xxxxxxxxx.iso"
```

[//]: Links
[download-linux-alma-8]: https://mirrors.almalinux.org/isos/x86_64/8.9.html
[download-linux-alma-9]: https://mirrors.almalinux.org/isos/x86_64/9.3.html
[download-linux-centos-7]: http://isoredirect.centos.org/centos/7/isos/x86_64/
[download-linux-centos-stream-8]: http://isoredirect.centos.org/centos/8-stream/isos/x86_64/
[download-linux-centos-stream-9]: http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/
[download-linux-debian-11]: https://cdimage.debian.org/cdimage/archive/11.9.0/amd64/iso-cd/
[download-linux-debian-12]: https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/
[download-linux-fedora-39]: https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/iso/
[download-linux-oracle-8]: https://yum.oracle.com/oracle-linux-isos.html
[download-linux-oracle-9]: https://yum.oracle.com/oracle-linux-isos.html
[download-linux-photon-4]: https://packages.vmware.com/photon/4.0/Rev2/iso/
[download-linux-photon-5]: https://packages.vmware.com/photon/5.0/GA/iso/
[download-linux-rhel-7]: https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.9/x86_64/product-software
[download-linux-rhel-8]: https://access.redhat.com/downloads/content/479/ver=/rhel---8/8.9/x86_64/product-software
[download-linux-rhel-9]: https://access.redhat.com/downloads/content/479/ver=/rhel---9/9.3/x86_64/product-software
[download-linux-rocky-8]: https://download.rockylinux.org/pub/rocky/8/isos/x86_64/
[download-linux-rocky-9]: https://download.rockylinux.org/pub/rocky/9/isos/x86_64/
[download-linux-sles-15]: https://www.suse.com/download/sles/
[download-linux-ubuntu-2004]: https://releases.ubuntu.com/20.04/
[download-linux-ubuntu-2204]: https://releases.ubuntu.com/22.04/
[download-linux-ubuntu-2404]: https://releases.ubuntu.com/24.04/
[download-windows-server-2019]: https://www.microsoft.com/evalcenter/evaluate-windows-server-2019
[download-windows-server-2022]: https://www.microsoft.com/evalcenter/evaluate-windows-server-2022
[download-windows-server-2025]: https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserver
[download-windows-10]: https://www.microsoft.com/evalcenter/evaluate-windows-10-enterprise
[download-windows-11]: https://www.microsoft.com/evalcenter/evaluate-windows-11-enterprise
[iso]: https://en.wikipedia.org/wiki/ISO_imageGUID-58D77EA5-50D9-4A8E-A15A-D7B3ABA11B87.html
