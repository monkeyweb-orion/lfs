#!/bin/bash
# 4.2. Creating a limited directory layout in LFS filesystem
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs
echo "lfs:lfs" | sudo chpasswd
sudo adduser lfs sudo

# Grant lfs full access to all directories under $LFS by making lfs the directory owner:
sudo chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
    x86_64) sudo chown -v lfs $LFS/lib64 ;;
esac

sudo chown -v lfs $LFS/tools
sudo chown -v lfs $LFS/sources

#sudo echo "lfs ALL = NOPASSWD : ALL" >> /etc/sudoers
#echo 'Defaults env_keep += "LFS LC_ALL LFS_TGT PATH MAKEFLAGS FETCH_TOOLCHAIN_MODE LFS_TEST LFS_DOCS JOB_COUNT LOOP IMAGE_SIZE INITRD_TREE IMAGE"' >> /etc/sudoers

sudo cat > /etc/sudoers.d/lfs << EOF
lfs ALL=(ALL) NOPASSWD:ALL
EOF

sudo chmod -v 440 /etc/sudoers.d/lfs

# Copy /home/vagrant/.ssh to user: /home/lfs
sudo cp -rv /home/vagrant/.ssh /home/lfs
sudo chown -vR lfs:lfs $LFS
sudo chown -vR lfs:lfs /home/lfs/.ssh

# Adittional implementations.
# Apply Permissions
# sudo chown clear -v lfs:lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}