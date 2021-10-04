#!/bin/bash

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Prepares a Red Hat Enterprise Linux 8 guest operating system.

export BUILD_USERNAME
export BUILD_KEY
export ANSIBLE_USERNAME
export ANSIBLE_KEY

#### Checking Red Hat Subscription Manager status. ###
echo '> Checking the Red Hat Subscription Manager status ...'
subscription-manager refresh

#### Update the guest operating system. ###
echo '> Updating the guest operating system ...'
sudo dnf update -y

### Install additional packages. ### 
echo '> Installing additional packages ...'
sudo dnf install -y \
    curl \
    wget \
    git \
    vim \
    net-tools \
    unzip \
    ca-certificates

### Install the Certificate Authority certificates and add to the certificate authority trust. ###
echo '> Installing the Certificate Authority certificates and adding to the certificate authority trust ...'
sudo chown -R root:root /tmp/root-ca.crt
sudo cat /tmp/root-ca.crt > /etc/pki/ca-trust/source/anchors/root-ca.crt
sudo chmod 644 /etc/pki/ca-trust/source/anchors/root-ca.crt
sudo update-ca-trust extract
sudo rm -rf /tmp/root-ca.crt

### Update the default local user. ###
echo '> Updating the default local user ...'
sudo mkdir -p /home/$BUILD_USERNAME/.ssh
sudo cat << EOF > /home/$BUILD_USERNAME/.ssh/authorized_keys
$BUILD_KEY
EOF
sudo chown -R $BUILD_USERNAME /home/$BUILD_USERNAME/.ssh
sudo chmod 700 /home/$BUILD_USERNAME/.ssh
sudo chmod 644 /home/$BUILD_USERNAME/.ssh/authorized_keys

### Create a local user for Ansible. ###
echo '> Creating a local user for Ansible ...'
sudo groupadd $ANSIBLE_USERNAME
sudo useradd -g $ANSIBLE_USERNAME -G wheel -m -s /bin/bash $ANSIBLE_USERNAME
echo $ANSIBLE_USERNAME:$(openssl rand -base64 14) | sudo chpasswd
sudo mkdir /home/$ANSIBLE_USERNAME/.ssh
sudo cat << EOF > /home/$ANSIBLE_USERNAME/.ssh/authorized_keys
$ANSIBLE_KEY
EOF
sudo chown -R $ANSIBLE_USERNAME:$ANSIBLE_USERNAME /home/$ANSIBLE_USERNAME/.ssh
sudo chmod 700 /home/$ANSIBLE_USERNAME/.ssh
sudo chmod 600 /home/$ANSIBLE_USERNAME/.ssh/authorized_keys

### Configure SSH for Public Key Authentication. ###
echo '> Configuring SSH for Public Key Authentication ...'
sudo sed -i 's/.*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
### Comment the line below to to disable Public Key Authentication allow _only_ Password Authentication. ###
sudo sed -i 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
### Uncomment the line below to to disable Password Authentication and enforce _only_ Public Key Authentication. ###
### sudo sed -i 's/PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

### Disable SELinux. ### 
echo '> Disabling SELinux ...'
sudo sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

### Restart the SSH daemon. ###
echo '> Restarting the SSH daemon. ...'
sudo systemctl restart sshd

#### Unregister from Red Hat Subscription Manager. ###
echo '> Unregistering from Red Hat Subscription Manager ...'
subscription-manager unsubscribe --all
subscription-manager unregister
subscription-manager clean

### Create a clean script. ###
echo '> Creating clean script ...'
sudo cat <<EOF > /tmp/clean.sh
#!/bin/bash

### Cleans the audit logs. ###
echo '> Cleaning the audit logs ...'
if [ -f /var/log/audit/audit.log ]; then
cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
cat /dev/null > /var/log/lastlog
fi

### Cleans the persistent udev rules. ###
echo '> Cleaning persistent udev rules ...'
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
rm /etc/udev/rules.d/70-persistent-net.rules
fi

### Clean the /tmp directories. ###
echo '> Cleaning the /tmp directories ...'
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/log/rhsm/*
rm -rf /var/cache/dnf/*

### Clean the SSH keys. ###
echo '> Cleaning the SSH keys ...'
#rm -f /etc/ssh/ssh_host_*

### Sets the hostname to localhost. ###
echo '> Setting the hostname to localhost ...'
cat /dev/null > /etc/hostname
hostnamectl set-hostname localhost

### Clean the dnf cache. ###
echo '> Cleaning the  cache ...'
dnf clean all

### Clean the machine-id. ###
echo '> Cleaning the machine-id ...'
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

### Clean the shell history. ###
echo '> Cleaning the shell history ...'
unset HISTFILE
history -cw
echo > ~/.bash_history
rm -fr /root/.bash_history

### Run a sync. ###
echo '> Running a sync ...'
sync && sync

EOF

### Change script permissions on /tmp/clean.sh. ###
echo '> Changing script permissions on /tmp/clean.sh ...'
sudo chmod +x /tmp/clean.sh

### Run the cleau script. ###
echo '> Running the clean script ...'
sudo /tmp/clean.sh
### END: Clean the guest operating system. ###

### Generate the host keys using ssh-keygen. ###
echo '> Generating the host keys using ssh-keygen ...'
sudo ssh-keygen -A

### Done. ###
echo '> Done.'