#!/bin/bash
set -e
echo "Building man-pages.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 33 MB"

# 8.3. The Man-pages package contains over 2,200 man pages.
tar -xf /sources/man-pages-*.tar.xz -C /tmp/ \
    && mv /tmp/man-pages-* /tmp/man-pages \
    && pushd /tmp/man-pages

make prefix=/usr install

# cleanup
popd \
    && rm -rf /tmp/man-pages || true
