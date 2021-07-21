#!/bin/bash
# Maintainer: code@rainpole.io
# Prepares a Ubuntu Server guest operating system.

#### Update the guest operating system. ###
echo '> Updating the guest operating system ...'
sudo apt-get update
sudo apt-get -y upgrade

### Install additional packages. ### 
echo '> Installing additional packages ...'
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y git
sudo apt-get install -y net-tools
sudo apt-get install -y unzip
sudo apt-get install -y ca-certificates

### Clearing apt-get cache. ###
echo '> Clearing apt-get cache ...'
sudo apt-get clean

### Copy the Certificate Authority certificates and add to the certificate authority trust. ###
echo '> Copying the Certificate Authority certificates and adding to the certificate authority trust ...'
sudo chown -R root:root /tmp/root-ca.crt
sudo chmod 644 /tmp/root-ca.crt
sudo cp /tmp/root-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
sudo rm -rf /tmp/root-ca.crt

### Copy the SSH key to authorized_keys and set permissions. ###
echo '> Copying the SSH key to Authorized Keys and setting permissions ...'
sudo mkdir -p /home/$BUILD_USERNAME/.ssh
sudo chmod 700 /home/$BUILD_USERNAME/.ssh
sudo cat /tmp/id_ecdsa.pub > /home/$BUILD_USERNAME/.ssh/authorized_keys
sudo chmod 644 /home/$BUILD_USERNAME/.ssh/authorized_keys
sudo chown -R $BUILD_USERNAME /home/$BUILD_USERNAME/.ssh
sudo rm -rf /tmp/id_ecdsa.pub

### Configure SSH for Public Key Authentication. ###
echo '> Configuring SSH for Public Key Authentication ...'
sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

### Restart the SSH daemon. ###
echo '> Restarting the SSH daemon. ...'
sudo systemctl restart sshd

### Disable and clean tmp. ### 
echo '> Disabling and clean tmp ...'
sudo sed -i 's/D/#&/' /usr/lib/tmpfiles.d/tmp.conf

### Add After=dbus.service to open-vm-tools. ### 
echo '> Adding After=dbus.service to open-vm-tools ...'
sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /lib/systemd/system/open-vm-tools.service

### Create a cleanup script. ###
echo '> Creating cleanup script ...'
sudo cat <<EOF > /tmp/cleanup.sh
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
rm -f /etc/ssh/ssh_host_*

# Sets hostname to localhost.
echo '> Setting hostname to localhost ...'
cat /dev/null > /etc/hostname
hostnamectl set-hostname localhost

# Cleans apt-get.
echo '> Cleaning apt-get ...'
apt-get clean

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
sudo chmod +x /tmp/cleanup.sh

### Runs the cleauup script. ### 
echo '> Running the cleanup script ...'
sudo /tmp/cleanup.sh

### Generate host keys using ssh-keygen ### 
echo '> Generating host keys ...'
sudo ssh-keygen -A

### All done. ### 
echo '> Done.'  
