#!/bin/bash
set -e
echo "Building Acl.."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.9 MB"

# 8.23. The Acl package contains utilities to administer Access Control
# Lists, which are used to define more fine-grained discretionary access
# rights for files and directories
tar -xf /sources/acl-*.tar.xz -C /tmp/ \
    && mv /tmp/acl-* /tmp/acl \
    && pushd /tmp/acl

# Prepare Acl for compilation:
./configure --prefix=/usr               \
    --disable-static                    \
    --docdir=/usr/share/doc/acl-2.3.1

# Compile the package:
make

# Install the package:
make install

# Cleanup
popd \
    && rm -rf /tmp/acl
