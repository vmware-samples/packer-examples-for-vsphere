#!/bin/bash  -eux

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Prepares a VMware Photon OS guest operating system.

### Set the environmental variables. ###
export BUILD_USERNAME
export BUILD_KEY
export ANSIBLE_USERNAME
export ANSIBLE_KEY

### Disable IPv6. ### 
echo '> Disabling IPv6'
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf

### Update the default local user. ###
echo '> Updating the default local user ...'
echo '> Adding authorized_keys for the default local user ...'
sudo mkdir -p /home/$BUILD_USERNAME/.ssh
sudo cat << EOF > /home/$BUILD_USERNAME/.ssh/authorized_keys
$BUILD_KEY
EOF
sudo chown -R $BUILD_USERNAME /home/$BUILD_USERNAME/.ssh
sudo chmod 700 /home/$BUILD_USERNAME/.ssh
sudo chmod 644 /home/$BUILD_USERNAME/.ssh/authorized_keys
echo '> Adding the default local user to passwordless sudoers...'
sudo bash -c "echo \"$BUILD_USERNAME ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"

### Create a local user for Ansible. ###
echo '> Creating a local user for Ansible ...'
sudo groupadd $ANSIBLE_USERNAME
sudo useradd -g $ANSIBLE_USERNAME -m -s /bin/bash $ANSIBLE_USERNAME
sudo usermod -aG sudo $ANSIBLE_USERNAME
echo $ANSIBLE_USERNAME:$(openssl rand -base64 14) | sudo chpasswd
echo '> Adding authorized_keys for local Ansible user ...'
sudo mkdir /home/$ANSIBLE_USERNAME/.ssh
sudo cat << EOF > /home/$ANSIBLE_USERNAME/.ssh/authorized_keys
$ANSIBLE_KEY
EOF
sudo chown -R $ANSIBLE_USERNAME:$ANSIBLE_USERNAME /home/$ANSIBLE_USERNAME/.ssh
sudo chmod 700 /home/$ANSIBLE_USERNAME/.ssh
sudo chmod 600 /home/$ANSIBLE_USERNAME/.ssh/authorized_keys
echo '> Adding local Ansible user to passwordless sudoers...'
sudo bash -c "echo \"$ANSIBLE_USERNAME ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"

### Configure SSH for Public Key Authentication. ###
echo '> Configuring SSH for Public Key Authentication ...'
sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
sudo sed -i 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

### Disable and clean tmp. ### 
echo '> Disabling and clean tmp ...'
sudo sed -i 's/D/#&/' /usr/lib/tmpfiles.d/tmp.conf

### Add After=dbus.service to VMware Tools daemon. ### 
echo '> Adding After=dbus.service to VMware Tools daemon ...'
sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /usr/lib/systemd/system/vmtoolsd.service

### Create a cleanup script. ###
echo '> Creating cleanup script ...'
sudo cat <<EOF > /home/$BUILD_USERNAME/clean.sh
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

# Cleans tdnf.
echo '> Cleaning tdnf ...'
tdnf clean all

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
sudo chmod +x /home/$BUILD_USERNAME/clean.sh

### Runs the cleauup script. ### 
echo '> Running the cleanup script ...'
sudo /home/$BUILD_USERNAME/clean.sh

### Generate host keys using ssh-keygen ### 
echo '> Generating host keys ...'
sudo ssh-keygen -A

### All done. ### 
echo '> Done.'  
