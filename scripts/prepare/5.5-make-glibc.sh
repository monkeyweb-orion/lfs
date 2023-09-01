#!/bin/bash
set -e
echo "Building glibc.."
echo "Approximate build time: 4.4 SBU"
echo "Required disk space: 821 MB"

# 5.5. The Glibc package contains the main C library. This library 
# provides the basic routines for allocating memory, searching
# directories, opening and closing files, reading and writing 
# files, string handling, pattern matching, arithmetic, and so on.
tar -xf glibc-*.tar.xz -C /tmp/ \
    && mv /tmp/glibc-* /tmp/glibc \
    && pushd /tmp/glibc

# Link
case $(uname -m) in
    i?86)
        ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) 
        ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
        ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

# Apply Path
patch -Np1 -i $LFS/sources/glibc-2.36-fhs-1.patch

# Compile
mkdir -v build \
    && cd build \
    && echo "rootsbindir=/usr/sbin" > configparms \
    && ../configure                        \
        --prefix=/usr                      \
        --host=$LFS_TGT                    \
        --build=$(../scripts/config.guess) \
        --enable-kernel=3.2                \
        --with-headers=$LFS/usr/include    \
        libc_cv_slibdir=/usr/lib            \
    && make \
    && make DESTDIR=$LFS install \
    && sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

# perform a sanity check that basic functions (compiling and linking)
# are working as expected
echo 'int main(){}' | gcc -xc -
readelf -l a.out | grep ld-linux

rm -v a.out


$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders
    
popd \
    && rm -rf /tmp/glibc
