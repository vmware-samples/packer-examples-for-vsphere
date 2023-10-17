<?xml version="1.0"?>
<!DOCTYPE profile>
<profile xmlns="http://www.suse.com/1.0/yast2ns" xmlns:config="http://www.suse.com/1.0/configns">
  <bootloader t="map">
    <global t="map">
      <append>splash=silent mitigations=auto quiet crashkernel=204M,high</append>
      <cpu_mitigations>auto</cpu_mitigations>
      <gfxmode>auto</gfxmode>
      <hiddenmenu>false</hiddenmenu>
      <os_prober>false</os_prober>
      <secure_boot>true</secure_boot>
      <terminal>gfxterm</terminal>
      <timeout t="integer">8</timeout>
      <update_nvram>true</update_nvram>
      <xen_kernel_append>vga=gfx-1024x768x16 crashkernel=204M\&lt;4G</xen_kernel_append>
    </global>
    <loader_type>grub2-efi</loader_type>
  </bootloader>
  <kdump>
    <add_crash_kernel config:type="boolean">false</add_crash_kernel>
  </kdump>
  <firewall t="map">
    <default_zone>public</default_zone>
    <enable_firewall t="boolean">true</enable_firewall>
    <log_denied_packets>off</log_denied_packets>
    <start_firewall t="boolean">true</start_firewall>
    <zones t="list">
      <zone t="map">
        <description>Unsolicited incoming network packets are rejected. Incoming packets that are related to outgoing network connections are accepted. Outgoing network connections are allowed.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>block</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list"/>
        <short>Block</short>
        <target>%%REJECT%%</target>
      </zone>
      <zone t="map">
        <description>For computers in your demilitarized zone that are publicly-accessible with limited access to your internal network. Only selected incoming connections are accepted.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>dmz</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list">
          <service>ssh</service>
        </services>
        <short>DMZ</short>
        <target>default</target>
      </zone>
      <zone t="map">
        <description>All network connections are accepted.</description>
        <interfaces t="list">
          <interface>docker0</interface>
        </interfaces>
        <masquerade t="boolean">false</masquerade>
        <name>docker</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list"/>
        <short>docker</short>
        <target>ACCEPT</target>
      </zone>
      <zone t="map">
        <description>Unsolicited incoming network packets are dropped. Incoming packets that are related to outgoing network connections are accepted. Outgoing network connections are allowed.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>drop</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list"/>
        <short>Drop</short>
        <target>DROP</target>
      </zone>
      <zone t="map">
        <description>For use on external networks. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">true</masquerade>
        <name>external</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list">
          <service>ssh</service>
        </services>
        <short>External</short>
        <target>default</target>
      </zone>
      <zone t="map">
        <description>For use in home areas. You mostly trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>home</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list">
          <service>dhcpv6-client</service>
          <service>mdns</service>
          <service>samba-client</service>
          <service>ssh</service>
        </services>
        <short>Home</short>
        <target>default</target>
      </zone>
      <zone t="map">
        <description>For use on internal networks. You mostly trust the other computers on the networks to not harm your computer. Only selected incoming connections are accepted.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>internal</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list">
          <service>dhcpv6-client</service>
          <service>mdns</service>
          <service>samba-client</service>
          <service>ssh</service>
        </services>
        <short>Internal</short>
        <target>default</target>
      </zone>
      <zone t="map">
        <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>public</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list">
          <service>dhcpv6-client</service>
          <service>ssh</service>
        </services>
        <short>Public</short>
        <target>default</target>
      </zone>
      <zone t="map">
        <description>All network connections are accepted.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>trusted</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list"/>
        <short>Trusted</short>
        <target>ACCEPT</target>
      </zone>
      <zone t="map">
        <description>For use in work areas. You mostly trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
        <interfaces t="list"/>
        <masquerade t="boolean">false</masquerade>
        <name>work</name>
        <ports t="list"/>
        <protocols t="list"/>
        <services t="list">
          <service>dhcpv6-client</service>
          <service>ssh</service>
        </services>
        <short>Work</short>
        <target>default</target>
      </zone>
    </zones>
  </firewall>
  <general t="map">
    <mode t="map">
      <confirm t="boolean">false</confirm>
    </mode>
  </general>
  <groups t="list">
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>100</gid>
      <group_password>x</group_password>
      <groupname>users</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>492</gid>
      <group_password>x</group_password>
      <groupname>cdrom</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>490</gid>
      <group_password>x</group_password>
      <groupname>disk</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>479</gid>
      <group_password>x</group_password>
      <groupname>systemd-resolve</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>36</gid>
      <group_password>x</group_password>
      <groupname>kvm</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>495</gid>
      <group_password>x</group_password>
      <groupname>lock</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>481</gid>
      <group_password>x</group_password>
      <groupname>systemd-journal</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>491</gid>
      <group_password>x</group_password>
      <groupname>dialout</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>475</gid>
      <group_password>x</group_password>
      <groupname>chrony</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>486</gid>
      <group_password>x</group_password>
      <groupname>tape</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>498</gid>
      <group_password>!</group_password>
      <groupname>mail</groupname>
      <userlist>postfix</userlist>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>477</gid>
      <group_password>x</group_password>
      <groupname>systemd-coredump</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>482</gid>
      <group_password>x</group_password>
      <groupname>polkitd</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>488</gid>
      <group_password>x</group_password>
      <groupname>lp</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>478</gid>
      <group_password>x</group_password>
      <groupname>systemd-timesync</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>71</gid>
      <group_password>x</group_password>
      <groupname>ntadmin</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>62</gid>
      <group_password>x</group_password>
      <groupname>man</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>480</gid>
      <group_password>x</group_password>
      <groupname>systemd-network</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>42</gid>
      <group_password>x</group_password>
      <groupname>trusted</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>0</gid>
      <group_password>x</group_password>
      <groupname>root</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>476</gid>
      <group_password>x</group_password>
      <groupname>nscd</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>1</gid>
      <group_password>x</group_password>
      <groupname>bin</groupname>
      <userlist>daemon</userlist>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>65533</gid>
      <group_password>x</group_password>
      <groupname>nogroup</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>15</gid>
      <group_password>x</group_password>
      <groupname>shadow</groupname>
      <userlist>vnc</userlist>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>485</gid>
      <group_password>x</group_password>
      <groupname>video</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>489</gid>
      <group_password>x</group_password>
      <groupname>input</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>496</gid>
      <group_password>x</group_password>
      <groupname>kmem</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>65534</gid>
      <group_password>x</group_password>
      <groupname>nobody</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>499</gid>
      <group_password>x</group_password>
      <groupname>messagebus</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>494</gid>
      <group_password>x</group_password>
      <groupname>utmp</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>483</gid>
      <group_password>!</group_password>
      <groupname>sshd</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>59</gid>
      <group_password>x</group_password>
      <groupname>maildrop</groupname>
      <userlist>postfix</userlist>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>497</gid>
      <group_password>x</group_password>
      <groupname>wheel</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>2</gid>
      <group_password>x</group_password>
      <groupname>daemon</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>51</gid>
      <group_password>x</group_password>
      <groupname>postfix</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>493</gid>
      <group_password>x</group_password>
      <groupname>audio</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>474</gid>
      <group_password>x</group_password>
      <groupname>vnc</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>5</gid>
      <group_password>x</group_password>
      <groupname>tty</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>484</gid>
      <group_password>x</group_password>
      <groupname>audit</groupname>
      <userlist/>
    </group>
    <group t="map">
      <encrypted t="boolean">true</encrypted>
      <gid>487</gid>
      <group_password>x</group_password>
      <groupname>render</groupname>
      <userlist/>
    </group>
  </groups>
  <networking t="map">
    <dhcp_options t="map">
      <dhclient_client_id/>
      <dhclient_hostname_option>AUTO</dhclient_hostname_option>
    </dhcp_options>
    <dns t="map">
      <dhcp_hostname t="boolean">true</dhcp_hostname>
      <hostname>localhost</hostname>
      <resolv_conf_policy>auto</resolv_conf_policy>
    </dns>
    <interfaces t="list">
      <interface t="map">
        <bootproto>dhcp</bootproto>
        <name>eth0</name>
        <startmode>auto</startmode>
      </interface>
    </interfaces>
    <ipv6 t="boolean">true</ipv6>
    <keep_install_network t="boolean">true</keep_install_network>
    <managed t="boolean">false</managed>
    <routing t="map">
      <ipv4_forward t="boolean">false</ipv4_forward>
      <ipv6_forward t="boolean">false</ipv6_forward>
    </routing>
  </networking>
  <ntp-client t="map">
    <ntp_policy>auto</ntp_policy>
    <ntp_servers t="list"/>
    <ntp_sync>manual</ntp_sync>
  </ntp-client>
  <partitioning t="list">
    <drive t="map">
      <device>/dev/sysvg</device>
      <enable_snapshots t="boolean">false</enable_snapshots>
      <partitions t="list">
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">false</format>
          <label>AUDITFS</label>
          <lv_name>lv_audit</lv_name>
          <mount>/var/log/audit</mount>
          <mountby t="symbol">device</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>4294967296</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">false</format>
          <label>HOMEFS</label>
          <lv_name>lv_home</lv_name>
          <mount>/home</mount>
          <mountby t="symbol">label</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>4294967296</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">false</format>
          <label>LOGFS</label>
          <lv_name>lv_log</lv_name>
          <mount>/var/log</mount>
          <mountby t="symbol">device</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>4294967296</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">false</format>
          <label>OPTFS</label>
          <lv_name>lv_opt</lv_name>
          <mount>/opt</mount>
          <mountby t="symbol">device</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>2147483648</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">false</format>
          <label>ROOTFS</label>
          <lv_name>lv_root</lv_name>
          <mount>/</mount>
          <mountby t="symbol">device</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>12884901888</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">swap</filesystem>
          <format t="boolean">false</format>
          <label>SWAPFS</label>
          <lv_name>lv_swap</lv_name>
          <mount>swap</mount>
          <mountby t="symbol">device</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>1073741824</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">false</format>
          <label>TMPFS</label>
          <lv_name>lv_tmp</lv_name>
          <mount>/tmp</mount>
          <mountby t="symbol">device</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>4294967296</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">false</format>
          <label>VARFS</label>
          <lv_name>lv_var</lv_name>
          <mount>/var</mount>
          <mountby t="symbol">device</mountby>
          <pool t="boolean">false</pool>
          <resize t="boolean">false</resize>
          <size>4294967296</size>
          <stripes t="integer">1</stripes>
          <stripesize t="integer">0</stripesize>
        </partition>
      </partitions>
      <pesize>4194304</pesize>
      <type t="symbol">CT_LVM</type>
    </drive>
    <drive t="map">
      <device>/dev/sda</device>
      <disklabel>gpt</disklabel>
      <partitions t="list">
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">vfat</filesystem>
          <format t="boolean">true</format>
          <fstopt>utf8</fstopt>
          <label>EFIFS</label>
          <mount>/boot/efi</mount>
          <mountby t="symbol">uuid</mountby>
          <partition_id t="integer">259</partition_id>
          <partition_nr t="integer">1</partition_nr>
          <resize t="boolean">false</resize>
          <size>1073741824</size>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <filesystem t="symbol">xfs</filesystem>
          <format t="boolean">true</format>
          <label>BOOTFS</label>
          <mount>/boot</mount>
          <mountby t="symbol">uuid</mountby>
          <partition_id t="integer">131</partition_id>
          <partition_nr t="integer">2</partition_nr>
          <resize t="boolean">false</resize>
          <size>1073741824</size>
        </partition>
        <partition t="map">
          <create t="boolean">true</create>
          <format t="boolean">false</format>
          <lvm_group>sysvg</lvm_group>
          <partition_id t="integer">142</partition_id>
          <partition_nr t="integer">3</partition_nr>
          <resize t="boolean">false</resize>
          <size>40801123840</size>
        </partition>
      </partitions>
      <type t="symbol">CT_DISK</type>
      <use>all</use>
    </drive>
  </partitioning>
  <proxy t="map">
    <enabled t="boolean">false</enabled>
  </proxy>
  <security t="map">
    <console_shutdown>reboot</console_shutdown>
    <cracklib_dict_path>/usr/lib/cracklib_dict</cracklib_dict_path>
    <disable_restart_on_update>no</disable_restart_on_update>
    <disable_stop_on_removal>no</disable_stop_on_removal>
    <extra_services>insecure</extra_services>
    <fail_delay>3</fail_delay>
    <gid_max>60000</gid_max>
    <gid_min>1000</gid_min>
    <hibernate_system>active_console</hibernate_system>
    <kernel.sysrq>184</kernel.sysrq>
    <mandatory_services>secure</mandatory_services>
    <net.ipv4.ip_forward>0</net.ipv4.ip_forward>
    <net.ipv4.tcp_syncookies>0</net.ipv4.tcp_syncookies>
    <net.ipv6.conf.all.forwarding>0</net.ipv6.conf.all.forwarding>
    <pass_max_days>99999</pass_max_days>
    <pass_min_days>0</pass_min_days>
    <pass_min_len>5</pass_min_len>
    <pass_warn_age>7</pass_warn_age>
    <passwd_encryption>sha512</passwd_encryption>
    <passwd_remember_history>0</passwd_remember_history>
    <passwd_use_cracklib>yes</passwd_use_cracklib>
    <permission_security>easy</permission_security>
    <run_updatedb_as/>
    <selinux_mode>enforcing</selinux_mode>
    <smtpd_listen_remote>no</smtpd_listen_remote>
    <sys_gid_max>499</sys_gid_max>
    <sys_gid_min>100</sys_gid_min>
    <sys_uid_max>499</sys_uid_max>
    <sys_uid_min>100</sys_uid_min>
    <syslog_on_no_error>no</syslog_on_no_error>
    <uid_max>60000</uid_max>
    <uid_min>1000</uid_min>
    <useradd_cmd>/usr/sbin/useradd.local</useradd_cmd>
    <userdel_postcmd>/usr/sbin/userdel-post.local</userdel_postcmd>
    <userdel_precmd>/usr/sbin/userdel-pre.local</userdel_precmd>
  </security>
  <services-manager t="map">
    <default_target>multi-user</default_target>
    <services t="map">
      <enable t="list">
        <service>YaST2-Firstboot</service>
        <service>YaST2-Second-Stage</service>
        <service>apparmor</service>
        <service>auditd</service>
        <service>klog</service>
        <service>cron</service>
        <service>firewalld</service>
        <service>wickedd-auto4</service>
        <service>wickedd-dhcp4</service>
        <service>wickedd-dhcp6</service>
        <service>wickedd-nanny</service>
        <service>display-manager</service>
        <service>haveged</service>
        <service>irqbalance</service>
        <service>issue-generator</service>
        <service>kbdsettings</service>
        <service>kdump</service>
        <service>kdump-early</service>
        <service>lvm2-monitor</service>
        <service>wicked</service>
        <service>nscd</service>
        <service>postfix</service>
        <service>purge-kernels</service>
        <service>rollback</service>
        <service>rsyslog</service>
        <service>smartd</service>
        <service>sshd</service>
        <service>systemd-remount-fs</service>
        <service>vgauthd</service>
        <service>vmtoolsd</service>
      </enable>
    </services>
  </services-manager>
  <software t="map">
    <install_recommended t="boolean">true</install_recommended>
    <instsource/>
    <packages t="list">
      <package>xfsprogs</package>
      <package>sles-release</package>
      <package>shim</package>
      <package>openssh</package>
      <package>numactl</package>
      <package>mokutil</package>
      <package>kexec-tools</package>
      <package>kdump</package>
      <package>irqbalance</package>
      <package>grub2-x86_64-efi</package>
      <package>lvm2</package>
      <package>glibc</package>
      <package>firewalld</package>
      <package>dosfstools</package>
      <package>wicked</package>
      <package>autoyast2</package>
      <package>open-vm-tools</package>
      <package>perl</package>
    </packages>
    <patterns t="list">
      <pattern>apparmor</pattern>
      <pattern>base</pattern>
      <pattern>basic_desktop</pattern>
      <pattern>enhanced_base</pattern>
      <pattern>minimal_base</pattern>
      <pattern>x11</pattern>
      <pattern>x11_yast</pattern>
      <pattern>yast2_basis</pattern>
    </patterns>
    <products t="list">
      <product>SLES</product>
    </products>
  </software>
  <ssh_import t="map">
    <copy_config t="boolean">false</copy_config>
    <import t="boolean">false</import>
  </ssh_import>
  <suse_register t="map">
    <addons t="list">
      <addon t="map">
        <arch>x86_64</arch>
        <name>sle-module-server-applications</name>
        <release_type>nil</release_type>
        <version>15.5</version>
      </addon>
      <addon t="map">
        <arch>x86_64</arch>
        <name>sle-module-basesystem</name>
        <release_type>nil</release_type>
        <version>15.5</version>
      </addon>
    </addons>
    <do_registration t="boolean">true</do_registration>
    <install_updates t="boolean">false</install_updates>
    <email>${scc_email}</email>
    <reg_code>${scc_code}</reg_code>
    <reg_server>https://scc.suse.com</reg_server>
    <slp_discovery t="boolean">false</slp_discovery>
  </suse_register>
  <timezone t="map">
    <timezone>${vm_guest_os_timezone}</timezone>
  </timezone>
  <user_defaults t="map">
    <expire/>
    <group>100</group>
    <groups/>
    <home>/home</home>
    <inactive>-1</inactive>
    <no_groups t="boolean">true</no_groups>
    <shell>/bin/bash</shell>
    <skel>/etc/skel</skel>
    <umask>022</umask>
  </user_defaults>
  <users t="list">
    <user t="map">
      <authorized_keys t="list"/>
      <encrypted t="boolean">true</encrypted>
      <fullname>Build User</fullname>
      <gid>100</gid>
      <home>/home/${build_username}</home>
      <home_btrfs_subvolume t="boolean">false</home_btrfs_subvolume>
      <password_settings t="map">
        <expire/>
        <flag/>
        <inact/>
        <max>99999</max>
        <min>0</min>
        <warn>7</warn>
      </password_settings>
      <shell>/bin/bash</shell>
      <uid>1000</uid>
      <user_password>${build_password_encrypted}</user_password>
      <username>${build_username}</username>
    </user>
  </users>
  <scripts>
    <post-scripts config:type="list">
      <script>
        <filename>post.sh</filename>
        <interpreter>shell</interpreter>
        <feedback config:type="boolean">false</feedback>
        <source><![CDATA[
          #!/bin/sh
          usermod -aG wheel ${build_username}
          echo '${build_username} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/${build_username}
          sed -i '/NOPASSWD/s/^# //g' /etc/sudoers
          ]]>
        </source>
      </script>
    </post-scripts>
  </scripts>
</profile>
