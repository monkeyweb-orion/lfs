#!/bin/bash
set -e
echo "Building ncurses.."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 45 MB"

# 8.28. Ncurses package contains libraries for terminal-independent
# handling of character screens
tar -xf /sources/ncurses-*.tar.gz -C /tmp/ \
    && mv /tmp/ncurses-* /tmp/ncurses \
    && pushd /tmp/ncurses

# Prepare Ncurses for compilation:
./configure --prefix=/usr                       \
    --mandir=/usr/share/man                     \
    --with-shared                               \
    --without-debug                             \
    --without-normal                            \
    --with-cxx-shared                           \
    --enable-pc-files                           \
    --enable-widec                              \
    --with-pkg-config-libdir=/usr/lib/pkgconfig

# Compile the package:
make

# Install the package:
make DESTDIR=$PWD/dest install
install -vm755 dest/usr/lib/libncursesw.so.6.3 /usr/lib
rm -v dest/usr/lib/libncursesw.so.6.3
cp -av dest/* /

# Many applications still expect the linker to be able to find
# non-wide-character Ncurses libraries. Trick such applications
# into linking with wide-character libraries by means of
# symlinks and linker scripts:
for lib in ncurses form panel menu ; do
    rm -vf                      /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" >   /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc          /usr/lib/pkgconfig/${lib}.pc
done

# Finally, make sure that old applications that look for -lcurses
# at build time are still buildable:
rm -vf                      /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" >  /usr/lib/libcursesw.so
ln -sfv libncurses.so       /usr/lib/libcurses.so

mkdir -pv       /usr/share/doc/ncurses-6.3
cp -v -R doc/*  /usr/share/doc/ncurses-6.3

# cleanup
popd \
    && rm -rf /tmp/ncurses
