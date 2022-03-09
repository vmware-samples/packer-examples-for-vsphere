# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Ubuntu Server 18.04 LTS

# Locale and Keyboard
d-i debian-installer/locale string ${vm_guest_os_language}
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/xkb-keymap select ${vm_guest_os_keyboard}

# Clock and Timezone
d-i clock-setup/utc boolean true
d-i time/zone string ${vm_guest_os_timezone}

# Grub and Reboot Message
d-i finish-install/reboot_in_progress note
d-i grub-installer/only_debian boolean true

# Partitioning
d-i partman-auto/method string lvm
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-auto-lvm/new_vg_name string sysvg

d-i partman-auto/expert_recipe string                     \
  custom ::                                               \
    1024 1024 1024 fat32                                  \
    $primary{ }                                           \
    mountpoint{ /boot/efi }                               \
    method{ efi }                                         \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ vfat }                                    \
    label { EFIFS }                                       \
    .                                                     \
    1024 1024 1024 xfs                                    \
    $bootable{ }                                          \
    $primary{ }                                           \
    mountpoint{ /boot }                                   \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { BOOTFS }                                      \
    .                                                     \
    1024 1024 1024 linux-swap                             \
    $lvmok{ }                                             \
    lv_name{ lv_swap }                             	   \
    in_vg { sysvg }                                       \
    method{ swap }                                        \
    format{ }                                             \
    label { SWAPFS }                                      \
    .                                                     \
    12288 12288 -1 xfs                                    \
    $lvmok{ }                                             \
    mountpoint{ / }                                       \
    lv_name{ lv_root }                                    \
    in_vg { sysvg }                                       \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { ROOTFS }                                      \
    .                                                     \
    4096 4096 4096 xfs                                    \
    $lvmok{ }                                             \
    mountpoint{ /home }                                   \
    lv_name{ lv_home }                                    \
    in_vg { sysvg }                                	   \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { HOMEFS }                                      \
    options/nodev{ nodev }                                \
    options/nosuid{ nosuid }                              \
    .                                                     \
    2048 2048 2048 xfs                                    \
    $lvmok{ }                                             \
    mountpoint{ /opt }                                    \
    lv_name{ lv_opt }                                     \
    in_vg { sysvg }                                       \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { OPTFS }                                       \
    options/nodev{ nodev }                                \
    .                                                     \
    3072 3072 3072 xfs                                    \
    $lvmok{ }                                             \
    mountpoint{ /tmp }                                    \
    lv_name{ lv_tmp }                                     \
    in_vg { sysvg }                                	   \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { TMPFS }                                       \
    options/nodev{ nodev }                                \
    options/noexec{ noexec }                              \
    options/nosuid{ nosuid }                              \
    .                                                     \
    4096 4096 4096 xfs                                    \
    $lvmok{ }                                             \
    mountpoint{ /var }                                    \
    lv_name{ lv_var }                                     \
    in_vg { sysvg }                                	   \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { VARFS }                                       \
    options/nodev{ nodev }                                \
    .                                                     \
    4096 4096 4096 xfs                                    \
    $lvmok{ }                                             \
    mountpoint{ /var/log }                                \
    lv_name{ lv_log }                                     \
    in_vg { sysvg }                                	   \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { LOGFS }                                       \
    options/nodev{ nodev }                                \
    options/noexec{ noexec }                              \
    options/nosuid{ nosuid }                              \
    .                                                     \
    4096 4096 4096 xfs                                    \
    $lvmok{ }                                             \
    mountpoint{ /var/log/audit }                          \
    lv_name{ lv_audit }                                   \
    in_vg { sysvg }                                	   \
    method{ format }                                      \
    format{ }                                             \
    use_filesystem{ }                                     \
    filesystem{ xfs }                                     \
    label { AUDITFS }                                     \
    options/nodev{ nodev }                                \
    options/noexec{ noexec }                              \
    options/nosuid{ nosuid }                              \
    .                                                     \

d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# User Configuration
d-i passwd/user-fullname string ${build_username}
d-i passwd/username string ${build_username}
d-i passwd/user-password-crypted password ${build_password_encrypted}
d-i user-setup/allow-password-weak boolean false
d-i user-setup/encrypt-home boolean false

# Root Configuration
d-i passwd/root-login boolean false
d-i passwd/root-password-crypted password ${build_password_encrypted}

# Package Configuration
tasksel tasksel/first standard
d-i pkgsel/include string openssh-server open-vm-tools
d-i pkgsel/install-language-support boolean false

# Disable Automatic Package Updates
d-i pkgsel/update-policy select none
d-i pkgsel/upgrade select full-upgrade

# Add User to Sudoers
d-i preseed/late_command string \
    echo '${build_username} ALL=(ALL) NOPASSWD: ALL' > /target/etc/sudoers.d/${build_username} ; \
    in-target chmod 440 /etc/sudoers.d/${build_username} ;
