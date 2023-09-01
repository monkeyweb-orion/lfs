#!/bin/bash
set -e
echo "Building readline.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 16 MB"

# 8.11. The Readline package is a set of libraries that 
# offers command-line editing and history capabilities.
tar -xf /sources/readline-*.tar.gz -C /tmp/ \
    && mv /tmp/readline-* /tmp/readline \
    && pushd /tmp/readline

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

./configure --prefix=/usr                   \
    --disable-static                        \
    --with-curses                           \
    --docdir=/usr/share/doc/readline-8.1.2

make SHLIB_LIBS="-lncursesw"
make SHLIB_LIBS="-lncursesw" install

install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.1.2

popd \
    && rm -rf /tmp/readline
