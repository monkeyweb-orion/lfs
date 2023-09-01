#!/bin/bash
set -e
echo "Building Tcl.."
echo "Approximate build time: 3.4 SBU"
echo "Required disk space: 87 MB"

# 8.15. The Tcl package contains the Tool Command Language, 
# a robust general-purpose scripting language. The Expect
# package is written in the Tcl language.
tar -xf /sources/tcl*-src.tar.gz -C /tmp/
tar -xf /sources/tcl*-html.tar.gz -C /tmp/

mv /tmp/tcl* /tmp/tcl \
    && pushd /tmp/tcl

SRCDIR=$(pwd)
cd unix
./configure --prefix=/usr   \
    --mandir=/usr/share/man

# Build the package: 
make

sed -e "s|$SRCDIR/unix|/usr/lib|" \
    -e "s|$SRCDIR|/usr/include|"  \
    -i tclConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.3|/usr/lib/tdbc1.1.3|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.3/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/tdbc1.1.3/library|/usr/lib/tcl8.6|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.3|/usr/include|"            \
    -i pkgs/tdbc1.1.3/tdbcConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.2|/usr/lib/itcl4.2.2|" \
    -e "s|$SRCDIR/pkgs/itcl4.2.2/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/itcl4.2.2|/usr/include|"            \
    -i pkgs/itcl4.2.2/itclConfig.sh

unset SRCDIR

if [ $LFS_TEST -eq 1 ]; then make test; fi

make install

# Make the installed library writable so debugging 
# ymbols can be removed later: 
chmod -v u+w /usr/lib/libtcl8.6.so

make install-private-headers
ln -sfv tclsh8.6 /usr/bin/tclsh
mv /usr/share/man/man3/{Thread,Tcl_Thread}.3
mkdir -v -p /usr/share/doc/tcl-8.6.12
cp -v -r  ../html/* /usr/share/doc/tcl-8.6.12

popd \
    && rm -rf /tmp/tcl
