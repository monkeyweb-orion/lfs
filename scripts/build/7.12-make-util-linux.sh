#!/bin/bash
set -e
echo "Building Util-linux.."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 149 MB"

# 7.12. The Util-linux package contains miscellaneous utility programs.
tar -xf /sources/util-linux-*.tar.xz -C /tmp/ \
    && mv /tmp/util-linux-* /tmp/util-linux \
    && pushd /tmp/util-linux \
    && mkdir -pv /var/lib/hwclock \
    && ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime    \
        --libdir=/usr/lib                                   \
        --docdir=/usr/share/doc/util-linux-2.38.1           \
        --disable-chfn-chsh                                 \
        --disable-login                                     \
        --disable-nologin                                   \
        --disable-su                                        \
        --disable-setpriv                                   \
        --disable-runuser                                   \
        --disable-pylibmount                                \
        --disable-static                                    \
        --without-python                                    \
        runstatedir=/run                                    \
  && make \
  && make install \
  && popd \
  && rm -rf /tmp/util-linux
