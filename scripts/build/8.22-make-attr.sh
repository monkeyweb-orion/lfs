#!/bin/bash
set -e
echo "Building Attr.."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 4.1 MB"

# 8.22. The Attr package contains utilities to administer the extended
# attributes on filesystem objects
tar -xf /sources/attr-*.tar.gz -C /tmp/ \
    && mv /tmp/attr-* /tmp/attr \
    && pushd /tmp/attr

# Prepare Attr for compilation:
./configure --prefix=/usr               \
    --disable-static                    \
    --sysconfdir=/etc                   \
    --docdir=/usr/share/doc/attr-2.5.1

# Compile the package:
make
if [ $LFS_TEST -eq 1 ]; then make check; fi
make install

# Cleanup
popd \
    && rm -rf /tmp/attr
