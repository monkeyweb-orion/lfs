#!/bin/bash
set -e
echo "Building gperf.."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.0 MB"

# 8.37. Gperf generates a perfect hash function from a key set.
tar -xf /sources/gperf-*.tar.gz -C /tmp/ \
    && mv /tmp/gperf-* /tmp/gperf \
    && pushd /tmp/gperf

# prepare
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1

# compile and install
make

# The tests are known to fail if running multiple 
# simultaneous tests (-j option greater than 1). 
# To test the results, issue:
if [ $LFS_TEST -eq 1 ]; then make -j1 check; fi

# Install the package:
make install

# cleanup
popd \
    && rm -rf /tmp/gperf
