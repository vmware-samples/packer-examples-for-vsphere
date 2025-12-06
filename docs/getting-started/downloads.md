---
icon: octicons/download-16
---

# Guest Operating Systems

Download the guest operating system ISOs using the download script (`./download.sh`) or directly from the publisher.

::spantable::
| Operating System                                            | Version   | Automated Download                                                    |
| :---                                                        | :---      | :---                                                                  |
| :simple-broadcom: VMware Photon OS @span                    | 5.0       | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 4.0       | :octicons-check-circle-16:{ .green }                                  |
| :fontawesome-brands-debian: Debian @span                    | 13        | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 12        | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 11        | :octicons-check-circle-16:{ .green }                                  |
| :fontawesome-brands-ubuntu: Ubuntu Server @span             | 24.04     | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 22.04     | :octicons-check-circle-16:{ .green }                                  |
| :fontawesome-brands-redhat: Red Hat Enterprise Linux @span  | 9         | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 8         | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 7         | :octicons-check-circle-16:{ .green }                                  |
| :simple-almalinux: AlmaLinux OS @span                       | 9         | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 8         | :octicons-check-circle-16:{ .green }                                  |
| :simple-rockylinux: Rocky Linux @span                       | 9         | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 8         | :octicons-check-circle-16:{ .green }                                  |
| :simple-oracle: Oracle Linux @span                          | 9         | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 8         | :octicons-check-circle-16:{ .green }                                  |
| :fontawesome-brands-centos: CentOS @span                    | 10 Stream | :octicons-check-circle-16:{ .green }                                  |
|                                                             | 9 Stream  | :octicons-check-circle-16:{ .green }                                  |
| :fontawesome-brands-fedora: Fedora Server* @span            | 42        | :octicons-check-circle-16:{ .green }                                  |
| :fontawesome-brands-suse: SUSE Linux Enterprise @span       | 15        | :octicons-x-circle-16:{ .red }                                        |
| :fontawesome-brands-windows: Microsoft Windows Server @span | 2025      | :octicons-check-circle-16:{ .green } &nbsp; Windows Evaluation Center |
|                                                             | 2022      | :octicons-check-circle-16:{ .green } &nbsp; Windows Evaluation Center |
|                                                             | 2019      | :octicons-check-circle-16:{ .green } &nbsp; Windows Evaluation Center |
| :fontawesome-brands-windows: Microsoft Windows @span        | 11        | :octicons-check-circle-16:{ .green } &nbsp; Windows Evaluation Center |
|                                                             | 10        | :octicons-check-circle-16:{ .green } &nbsp; Windows Evaluation Center |
::end-spantable::

## Using the Download Script

1. Start a download by running the download script (`./download.sh`).

      ```shell
      ./download.sh
      ```

       The downloads are supported by a JSON configuration file (`project.json`) that includes the details for each guest operating system.

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

      Select a version: 1
      ```

5. The download will start.

      ```shell
      Downloading: ubuntu-24.04-live-server-amd64.iso => iso/linux/ubuntu-server/24.04-lts/amd64.

        % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                       Dload  Upload   Total   Spent    Left  Speed
      100 2627M  100 2627M    0     0  20.4M      0  0:02:08  0:02:08 --:--:-- 19.7M
        % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                       Dload  Upload   Total   Spent    Left  Speed
      100   299  100   299    0     0    535      0 --:--:-- --:--:-- --:--:--   535

      Verifying: sha256 checksum for ubuntu-24.04-live-server-amd64.iso.
      Verification of checksum successful for ubuntu-24.04-live-server-amd64.iso.
              - Expected: 8762f7e74e4d64d72fceb5f70682e6b069932deedb4949c6975d0f0fe0a91be3
              - Actual:   8762f7e74e4d64d72fceb5f70682e6b069932deedb4949c6975d0f0fe0a91be3

      Would you like to (c)ontinue or (q)uit?
      ```

### Demo

![](../assets/images/download.gif)

## Download Script Options

You can use the following options with the script.

| Option   | Short Form | Description                                   |
| -------- | ---------- | --------------------------------------------- |
| `--help` | `-h`, `-H` | Display the help for the script.              |
| `--json` | `-j`, `-J` | Override the default JSON configuration file. |
| `--deps` | `-d`, `-D` | Check the the required dependencies.          |

## Upload ISOs

The project allows the use of a datastore or a content library to store your guest
operating system [ISO][iso] files. The content library is disabled by default.

Upload the guest operating system ISO files and update the path in the configuration variables.

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

   ```hcl title="config/linux-ubuntu-16-04-lts.pkrvars.hcl"
   iso_datastore_path       = "iso/linux/ubuntu"
   iso_content_library_item = "ubuntu-16.04-live-server-amd64"
   iso_file                 = "ubuntu-16.04-live-server-amd64.iso"
   ```

[//]: Links
[iso]: https://en.wikipedia.org/wiki/ISO_imageGUID-58D77EA5-50D9-4A8E-A15A-D7B3ABA11B87.html
