#!/bin/bash

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Prepares a Ubuntu Server 18.xx guest operating system.

### Set the environmental variables. ###
export BUILD_USERNAME
export BUILD_KEY
export ANSIBLE_USERNAME
export ANSIBLE_KEY

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
sudo sed -i 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
### Uncomment the line below to to disable Password Authentication and enforce _only_ Public Key Authentication. ###
### sudo sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

### Restart the SSH daemon. ###
echo '> Restarting the SSH daemon. ...'
sudo systemctl restart sshd

### Create the clean script. ###
echo '> Creating the clean script ...'
sudo cat <<EOF > /home/$BUILD_USERNAME/clean.sh
#!/bin/bash

###  Cleans all audit logs. ###
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

### Cleans persistent udev rules. ###
echo '> Cleaning persistent udev rules ...'
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
rm /etc/udev/rules.d/70-persistent-net.rules
fi

### Clean the /tmp directories. ###
echo '> Cleaning /tmp directories ...'
rm -rf /tmp/*
rm -rf /var/tmp/*

### Clean the SSH keys. ###
echo '> Cleaning the SSH keys ...'
rm -f /etc/ssh/ssh_host_*

### Set the hostname to localhost. ###
echo '> Setting the hostname to localhost ...'
cat /dev/null > /etc/hostname
hostnamectl set-hostname localhost

### Clean apt cache. ###
echo '> Cleaning apt cache ...'
apt-get autoremove
apt-get clean

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
EOF

### Change the permissions on /home/$BUILD_USERNAME/clean.sh. ###
echo '> Changing the permissions on /home/$BUILD_USERNAME/clean.sh ...'
sudo chmod +x /home/$BUILD_USERNAME/clean.sh

### Run the clean script. ###
echo '> Running the clean script ...'
sudo /home/$BUILD_USERNAME/clean.sh

### Generate the host keys using ssh-keygen. ###
echo '> Generating the host keys using ssh-keygen ...'
sudo ssh-keygen -A

### Done. ###
echo '> Done.'