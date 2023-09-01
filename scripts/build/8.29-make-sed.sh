#!/bin/bash
set -e
echo "Building Sed.."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 31 MB"

# 8.29. The Sed package contains a stream editor.
tar -xf /sources/sed-*.tar.xz -C /tmp/ \
    && mv /tmp/sed-* /tmp/sed \
    && pushd /tmp/sed

# Prepare Sed for compilation:
./configure --prefix=/usr

# Compile the package and generate the HTML documentation:
make
make html

# Test the results as a non-privileged user, but do not stop at errors:
# Run tests
if [ $LFS_TEST -eq 1 ]; then
    chown -Rv tester .
    su tester -c "PATH=$PATH make check"
fi

# Install the package and its documentation:
make install
install -d -m755            /usr/share/doc/sed-4.8
install -m644 doc/sed.html  /usr/share/doc/sed-4.8

# Cleanup
popd \
    && rm -rf /tmp/sed
