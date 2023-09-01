#!/bin/bash
set -e
echo "Building Python.."
echo "Approximate build time: 3.4 SBU"
echo "Required disk space: 283 MB"

# 8.50. The Python 3 package contains the Python development environment. It is useful
# for object-oriented programming, writing scripts, prototyping large programs or
# developing entire applications.
tar -xf /sources/Python-*.tar.xz -C /tmp/ \
    && mv /tmp/Python-* /tmp/python \
    && pushd /tmp/python

# prepare for compilation
./configure --prefix=/usr \
  --enable-shared         \
  --with-system-expat     \
  --with-system-ffi       \
  --enable-optimizations

# compile, test and install
make

# install tool
make install

cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF

# install the documentation
if [ $LFS_DOCS -eq 1 ]; then
    # Install documentation
    install -v -dm755 /usr/share/doc/python-3.10.6/html

    # Extract archive
    tar --strip-components=1                    \
        --no-same-owner                         \
        --no-same-permissions                   \
        -C /usr/share/doc/python-3.10.6/html    \
        -xvf ../python-3.10.6-docs-html.tar.bz2
fi

# cleanup
popd \
    && rm -rf /tmp/python
