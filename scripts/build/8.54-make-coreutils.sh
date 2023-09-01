#!/bin/bash
set -e
echo "Building coreutils.."
echo "Approximate build time: 2.8 SBU"
echo "Required disk space: 159 MB"

# 8.54. The Coreutils package contains utilities for showing and
# setting the basic system characteristics.
tar -xf /sources/coreutils-*.tar.xz -C /tmp/ \
    && mv /tmp/coreutils-* /tmp/coreutils \
    && pushd /tmp/coreutils

# The following patch fixes this non-compliance and other
# internationalization-related bugs.
patch -Np1 -i /sources/coreutils-9.1-i18n-1.patch

# Now prepare Coreutils for compilation:
autoreconf -fiv
FORCE_UNSAFE_CONFIGURE=1 ./configure      \
  --prefix=/usr                           \
  --enable-no-install-program=kill,uptime

# Compile the package
make

## Run tests
if [ $LFS_TEST -eq 1 ]; then
    make NON_ROOT_USERNAME=tester check-root
    echo "dummy:x:102:tester" >> /etc/group
    chown -Rv tester .
    # test programs test-getlogin and date-debug are known to fail in a partially
    # built system environment like the chroot environment here
    su tester -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check" || true
    sed -i '/dummy/d' /etc/group
fi

# install
make install

# move programs to the locations specified by the FHS
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8

# cleanup
popd \
    && rm -rf /tmp/coreutils
