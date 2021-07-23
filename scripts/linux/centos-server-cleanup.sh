#!/bin/bash
# Maintainer: code@rainpole.io
# Prepares a CentOS Server guest operating system.

#### Update the guest operating system. ###
echo '> Updating the guest operating system ...'
sudo yum update -y

### Install additional packages. ### 
echo '> Installing additional packages ...'
sudo yum install -y curl
sudo yum install -y wget
sudo yum install -y git
sudo yum install -y net-tools
sudo yum install -y unzip
sudo yum install -y ca-certificates

### Clearing yum cache. ###
echo '> Clearing yum cache ...'
sudo yum clean all

### Copy the Certificate Authority certificates and add to the certificate authority trust. ###
echo '> Copying the Certificate Authority certificates and adding to the certificate authority trust ...'
sudo chown -R root:root /tmp/root-ca.crt
sudo cat /tmp/root-ca.crt > /etc/pki/ca-trust/source/anchors/root-ca.crt
sudo chmod 644 /etc/pki/ca-trust/source/anchors/root-ca.crt
sudo update-ca-trust extract
sudo rm -rf /tmp/root-ca.crt

### Copy the SSH key to authorized_keys and set permissions. ###
echo '> Copying the SSH key to Authorized Keys and setting permissions ...'
### Comment the lines below to to if you disable Public Key Authentication. ###
sudo mkdir -p /home/$BUILD_USERNAME/.ssh
sudo chmod 700 /home/$BUILD_USERNAME/.ssh
sudo cat /tmp/id_ecdsa.pub > /home/$BUILD_USERNAME/.ssh/authorized_keys
sudo chmod 644 /home/$BUILD_USERNAME/.ssh/authorized_keys
sudo chown -R $BUILD_USERNAME /home/$BUILD_USERNAME/.ssh
sudo rm -rf /tmp/id_ecdsa.pub

### Configure SSH for Public Key Authentication. ###
echo '> Configuring SSH for Public Key Authentication ...'
sudo sed -i 's/.*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
### Comment the line below to to disable Public Key Authentication allow _only_ Password Authentication. ###
sudo sed -i 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
### Uncomment the line below to to disable Password Authentication and enforce _only_ Public Key Authentication. ###
### sudo sed -i 's/PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

### Restart the SSH daemon. ###
echo '> Restarting the SSH daemon. ...'
sudo systemctl restart sshd

### Disable and clean tmp. ### 
echo '> Disabling and clean tmp ...'
SOURCE_TEXT="v /tmp 1777 root root 10d"
DEST_TEXT="#v /tmp 1777 root root 10d"
sudo sed -i "s@${SOURCE_TEXT}@${DEST_TEXT}@g" /usr/lib/tmpfiles.d/tmp.conf
sudo sed -i "s/\(^.*10d.*$\)/#\1/" /usr/lib/tmpfiles.d/tmp.conf

### Add After=dbus.service to VMware Tools daemon. ### 
echo '> Adding After=dbus.service to VMware Tools daemon ...'
sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /usr/lib/systemd/system/vmtoolsd.service

### Create a cleanup script. ###
echo '> Creating cleanup script ...'
sudo cat <<EOF > /tmp/clean.sh
#!/bin/bash

# Cleans all audit logs.
echo '> Cleaning all audit logs ...'
if [ -f /var/log/audit/audit.log ]; then
cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
cat /dev/null > /var/log/lastlog
fi

# Cleans persistent udev rules.
echo '> Cleaning persistent udev rules ...'
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
rm /etc/udev/rules.d/70-persistent-net.rules
fi

# Cleans /tmp directories.
echo '> Cleaning /tmp directories ...'
rm -rf /tmp/*
rm -rf /var/tmp/*

# Cleans SSH keys.
echo '> Cleaning SSH keys ...'
#rm -f /etc/ssh/ssh_host_*

# Sets hostname to localhost.
echo '> Setting hostname to localhost ...'
cat /dev/null > /etc/hostname
hostnamectl set-hostname localhost

# Cleans yum.
echo '> Cleaning yum ...'
yum clean all

# Cleans the machine-id.
echo '> Cleaning the machine-id ...'
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Cleans shell history.
echo '> Cleaning shell history ...'
unset HISTFILE
history -cw
echo > ~/.bash_history
rm -fr /root/.bash_history
EOF

### Change script permissions for execution. ### 
echo '> Changeing script permissions for execution ...'
sudo chmod +x /tmp/clean.sh

### Runs the cleauup script. ### 
echo '> Running the cleanup script ...'
sudo /tmp/clean.sh

### Generate host keys using ssh-keygen ### 
echo '> Generating host keys ...'
sudo ssh-keygen -A

### All done. ### 
echo '> Done.'  
