#!/bin/bash
set -e
echo "Building Zstd.."
echo "Approximate build time: 1.1 SBU"
echo "Required disk space: 56 MB"

# 8.9. Zstandard is a real-time compression algorithm, providing high 
# compression ratios. It offers a very wide range of compression / speed 
# trade-offs, while being backed by a very fast decoder.
tar -xf /sources/zstd-*.tar.gz -C /tmp/ \
    && mv /tmp/zstd-* /tmp/zstd \
    && pushd /tmp/zstd

patch -Np1 -i /sources/zstd-1.5.2-upstream_fixes-1.patch

make prefix=/usr
make check
make prefix=/usr install

# Remove the static library:
rm -v /usr/lib/libzstd.a

# cleanup
popd \
    && rm -rf /tmp/zstd
