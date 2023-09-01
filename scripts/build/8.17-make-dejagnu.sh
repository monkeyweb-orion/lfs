#!/bin/bash
set -e
echo "Building DejaGNU.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 6.9 MB"

# 8.17. The DejaGnu package contains a framework for running 
# test suites on GNU tools. It is written in expect, which 
# itself uses Tcl (Tool Command Language). 
tar -xf /sources/dejagnu-*.tar.gz -C /tmp/ \
    && mv /tmp/dejagnu-* /tmp/dejagnu \
    && pushd /tmp/dejagnu \
    && mkdir -v build \
    && cd build

# Prepare DejaGNU for compilation:     
../configure --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

# Build and install the package:
make install
install -v -dm755  /usr/share/doc/dejagnu-1.6.3
install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3

if [ $LFS_TEST -eq 1 ]; then make check; fi

popd \
    && rm -rf /tmp/dejagnu
