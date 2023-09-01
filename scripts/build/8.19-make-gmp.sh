#!/bin/bash
set -e
echo "Building GMP.."
echo "Approximate build time: 0.9 SBU"
echo "Required disk space: 53 MB"

# 8.19. The GMP package contains math libraries. These have 
# useful functions for arbitrary precision arithmetic.
tar -xf /sources/gmp-*.tar.xz -C /tmp/ \
    && mv /tmp/gmp-* /tmp/gmp \
    && pushd /tmp/gmp

./configure --prefix=/usr               \
    --enable-cxx                        \
    --disable-static                    \
    --docdir=/usr/share/doc/gmp-6.2.1
make
make html
make check 2>&1 | tee gmp-check-log
awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
make install
make install-html

popd \
  && rm -rf /tmp/gmp
