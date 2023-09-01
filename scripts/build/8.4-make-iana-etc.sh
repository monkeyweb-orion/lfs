#!/bin/bash
set -e
echo "Building Iana-Etc.."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 4.8 MB"

# 8.4. The Iana-Etc package provides data for network services and protocols.
tar -xf /sources/iana-etc-*.tar.gz -C /tmp/ \
  && mv /tmp/iana-etc-* /tmp/iana-etc \
  && pushd /tmp/iana-etc

cp services protocols /etc

# cleanup
popd \
  && rm -rf /tmp/iana-etc
