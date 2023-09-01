#!/bin/bash
set -e
echo "Building findutils.."
echo "Approximate build time: 0.8 SBU"
echo "Required disk space: 52 MB"

# 8.58. Findutils package contains programs to find files
tar -xf /sources/findutils-*.tar.xz -C /tmp/ \
    && mv /tmp/findutils-* /tmp/findutils \
    && pushd /tmp/findutils

case $(uname -m) in
    i?86)   TIME_T_32_BIT_OK=yes ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
    x86_64) ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
esac

make

if [ $LFS_TEST -eq 1 ]; then 
    chown -Rv tester .
    su tester -c "PATH=$PATH make check"
fi

make install

# cleanup
popd \
    && rm -rf /tmp/findutils
