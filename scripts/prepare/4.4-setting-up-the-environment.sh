#!/bin/bash
# 4.4. Setting Up the Environment

sudo cat > /home/lfs/.bash_profile << EOF
exec env -i HOME=/home/lfs TERM=xterm-256color PS1='\u:\w\$ ' /bin/bash
EOF

sudo cat > /home/lfs/.bashrc << EOF
set +h
umask 022
LFS=$LFS
LC_ALL=$LC_ALL
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=$PATH
MAKEFLAGS=$MAKEFLAGS
LFS_TEST=$LFS_TEST
LFS_DOCS=$LFS_DOCS
JOB_COUNT=$JOB_COUNT
CREATE_IMAGE_ISO=$CREATE_ISO_IMAGE
LOOP=$LOOP
IMAGE_SIZE=$IMAGE_SIZE
INITRD_TREE=$INITRD_TREE
IMAGE=$IMAGE
TZ_CONFIG=$TZ_CONFIG
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE MAKEFLAGS LFS_TEST LFS_DOCS JOB_COUNT CREATE_IMAGE_ISO LOOP IMAGE_SIZE IMAGE TZ_CONFIG
EOF

sudo chown -v lfs:lfs /home/lfs/.bash_profile
sudo chown -v lfs:lfs /home/lfs/.bashrc