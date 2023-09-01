#!/bin/bash
set -e
echo "Building bzip2.."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 7.2 MB"

# 8.7. The Bzip2 package contains programs for compressing and decompressing 
# files. Compressing text files with bzip2 yields a much better compression 
# percentage than with the traditional gzip.
tar -xf /sources/bzip2-*.tar.gz -C /tmp/ \
    && mv /tmp/bzip2-* /tmp/bzip2 \
    && pushd /tmp/bzip2

# The following command ensures installation of symbolic links are relative
patch -Np1 -i /sources/bzip2-1.0.8-install_docs-1.patch

# Ensure the man pages are installed into the correct location
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# Prepare Bzip2 for compilation with:
make -f Makefile-libbz2_so
make clean

# Compile and test the package:
make

# Install the programs:
make PREFIX=/usr install

# Install the shared bzip2 binary into the /bin directory, make some
# necessary symbolic links, and clean up:
cp -av libbz2.so.* /usr/lib
ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so
cp -v bzip2-shared /usr/bin/bzip2
for i in /usr/bin/{bzcat,bunzip2}; do
    ln -sfv bzip2 $i
done

rm -fv /usr/lib/libbz2.a

# Cleanup
popd \
  && rm -rf /tmp/bzip2
