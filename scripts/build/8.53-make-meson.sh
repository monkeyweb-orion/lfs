#!/bin/bash
set -e
echo "Building Meson.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 38 MB"

# 8.53. Meson is an open source build system meant to be both extremely fast,
# and, even more importantly, as user friendly as possible.
tar -xf /sources/meson-*.tar.gz -C /tmp/ \
    && mv /tmp/meson-* /tmp/meson \
    && pushd /tmp/meson

# Compile Meson with the following command:
pip3 wheel -w dist --no-build-isolation --no-deps $PWD

# Install package
pip3 install --no-index --find-links dist meson
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson

# cleanup
popd \
    && rm -rf /tmp/meson
