#!/bin/bash
set -e
echo "Building Ncurses.."
echo "Approximate build time:  0.7 SBU"
echo "Required disk space: 50 MB"

# 6.3. The Ncurses package contains libraries for terminal-independent handling of character screens.
tar -xf ncurses-*.tar.gz -C /tmp/ \
    && mv /tmp/ncurses-* /tmp/ncurses \
    && pushd /tmp/ncurses \
    && sed -i s/mawk// configure \
    && mkdir build \
    && popd \
    && pushd /tmp/ncurses/build \
        && ../configure \
        && make -C include \
        && make -C progs tic \
    && popd \
    && pushd /tmp/ncurses \
    && ./configure --prefix=/usr         \
            --host=$LFS_TGT              \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-debug              \
            --without-ada                \
            --without-normal             \
            --disable-stripping          \
            --enable-widec               \
    && make \
    && make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install \
    && echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so \
    && popd \
    && rm -rf /tmp/ncurses
