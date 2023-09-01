#!/bin/bash
# 2.2. Host System Requirements

# sed -i 's|http://archive.|http://br.archive.|g' /etc/apt/sources.list

apt-get update
apt-get install -y build-essential bison texinfo parted gawk
ln -fs bash /bin/sh

chmod +x /vagrant/scripts/*.sh
chmod +x /vagrant/scripts/prepare/*.sh
chmod +x /vagrant/scripts/build/*.sh
chmod +x /vagrant/scripts/image/*.sh


/vagrant/scripts/version-check.sh

# 2.4. Creating a New Partition
parted -a optimal /dev/sdb mklabel msdos
parted -a optimal /dev/sdb mkpart primary 0% 32GiB
parted -a optimal /dev/sdb mkpart primary 32GiB 100%
# 2.5. Creating a File System on the Partition
mkfs -v -t ext4 /dev/sdb1
mkswap /dev/sdb2

# 2.6. Setting The $LFS Variable
# export LFS=/mnt/lfs

# Loader environment
source /vagrant/.env

# 2.7. Mounting the New Partition
mkdir -pv $LFS
mount -v -t ext4 /dev/sdb1 $LFS
/sbin/swapon -v /dev/sdb2
cat >> /etc/fstab << EOF
/dev/sdb1 $LFS ext4 defaults 0 0
/dev/sdb2 none swap defaults 0 0
EOF

# 3.1. Introduction
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

# 3.2. Download All Packages / Tools
/vagrant/scripts/prepare/3.2-download-tools.sh

# Copy Files
cp -rv /vagrant/sources $LFS
cp -rv /vagrant/scripts $LFS
cp -rv /vagrant/config $LFS

# 4.2. Creating the $LFS/tools Directory
/vagrant/scripts/prepare/4.2-creating-limited-filesystem.sh

# 4.3. Adding the LFS User
/vagrant/scripts/prepare/4.3-adding-lfs-user.sh

# 4.4. Setting Up the Environment
/vagrant/scripts/prepare/4.4-setting-up-the-environment.sh

# Root Password
sudo sh -c "echo root:root | chpasswd"