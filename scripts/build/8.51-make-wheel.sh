#!/bin/bash
set -e
echo "Building Python.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 956 KB"

# 8.51. Wheel is a Python library that is the reference 
# implementation of the Python wheel packaging standard.
tar -xf /sources/wheel-*.tar.gz -C /tmp/ \
    && mv /tmp/wheel-* /tmp/wheel \
    && pushd /tmp/wheel

# Install wheel with the following command:
pip3 install --no-index $PWD

# cleanup
popd \
    && rm -rf /tmp/wheel
