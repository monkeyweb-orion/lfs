#!/bin/bash
set -e
echo "Building Expect.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 3.9 MB"

# 8.16. The Expect package contains tools for automating, via 
# scripted dialogues, interactive applications such as telnet,
# ftp, passwd, fsck, rlogin, and tip. Expect is also useful 
# for testing these same applications as well as easing all 
# sorts of tasks that are prohibitively difficult with anything 
# else. The DejaGnu framework is written in Expect.
tar -xf /sources/expect*.tar.gz -C /tmp/ \
    && mv /tmp/expect* /tmp/expect \
    && pushd /tmp/expect

# Prepare Expect for compilation:
./configure --prefix=/usr                   \
            --with-tcl=/usr/lib             \
            --enable-shared                 \
            --mandir=/usr/share/man         \
            --with-tclinclude=/usr/include
make
if [ $LFS_TEST -eq 1 ]; then make test; fi
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

popd \
    && rm -rf /tmp/expect
