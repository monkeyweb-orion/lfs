#!/bin/bash
set -e
echo "Running build.."

# prepartion
sh $LFS/scripts/build/7.2-changing-ownership.sh
sh $LFS/scripts/build/7.3-prepare-virtual-kernel-file-systems.sh


# enter and continue in chroot environment with tools
# 7.4. Entering the Chroot Environment
sudo chroot "$LFS" /usr/bin/env -i                  \
    HOME=/root                                      \
    TERM="$TERM"                                    \
    PS1='(lfs chroot) \u:\w\$ '                     \
    PATH=/usr/bin:/usr/sbin                         \
    LFS="$LFS"                                      \
    LC_ALL="$LC_ALL"                                \
    LFS_TGT="$LFS_TGT"                              \
    MAKEFLAGS="$MAKEFLAGS"                          \
    LFS_TEST="$LFS_TEST"                            \
    LFS_DOCS="$LFS_DOCS"                            \
    JOB_COUNT="$JOB_COUNT"                          \
    /bin/bash --login +h                            \
    -c "sh /scripts/build/as-chroot-with-tools.sh"

# enter and continue in chroot environment with usr
sudo chroot "$LFS" /usr/bin/env -i                  \
    HOME=/root                                      \
    TERM="$TERM"                                    \
    PS1='(lfs chroot) \u:\w\$ '                     \
    PATH=/usr/bin:/usr/sbin                         \
    LFS="$LFS"                                      \
    LC_ALL="$LC_ALL"                                \
    LFS_TGT="$LFS_TGT"                              \
    MAKEFLAGS="$MAKEFLAGS"                          \
    LFS_TEST="$LFS_TEST"                            \
    LFS_DOCS="$LFS_DOCS"                            \
    JOB_COUNT="$JOB_COUNT"                          \
    /bin/bash --login                               \
    -c "sh /scripts/build/as-chroot-with-usr.sh"

# cleanup
sh $LFS/scripts/build/11.3-cleanup.sh
