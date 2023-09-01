#!/bin/bash
set -e
echo "Building Util-linux.."
echo "Approximate build time: 1.0 SBU"
echo "Required disk space: 283 MB"

# 8.73. The Util-linux package contains miscellaneous utility programs. Among
# them are utilities for handling file systems, consoles, partitions, and messages
tar -xf /sources/util-linux-*.tar.xz -C /tmp/ \
    && mv /tmp/util-linux-* /tmp/util-linux \
    && pushd /tmp/util-linux

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
    --bindir=/usr/bin                             \
    --libdir=/usr/lib                             \
    --sbindir=/usr/sbin                           \
    --docdir=/usr/share/doc/util-linux-2.38.1     \
    --disable-chfn-chsh                           \
    --disable-login                               \
    --disable-nologin                             \
    --disable-su                                  \
    --disable-setpriv                             \
    --disable-runuser                             \
    --disable-pylibmount                          \
    --disable-static                              \
    --without-python                              \
    --without-systemd                             \
    --without-systemdsystemunitdir
make

echo "Util-linux test skipped due to warning."
if [ $LFS_TEST -eq 1 ]; then
    chown -Rv tester .
    su tester -c "make -k check"
fi

# install
make install

# cleanup
popd \
    && rm -rf /tmp/util-linux
