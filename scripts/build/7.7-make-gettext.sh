#!/bin/bash
set -e
echo "Building gettext.."
echo "Approximate build time: 1.6 SBU"
echo "Required disk space: 282 MB"

# 7.7. The Gettext package contains utilities for internationalization 
# and localization. These allow programs to be compiled with NLS 
# (Native Language Support), enabling them to output messages in 
# the user's native language.
tar -xf /sources/gettext-*.tar.xz -C /tmp/ \
    && mv /tmp/gettext-* /tmp/gettext \
    && pushd /tmp/gettext \
    && ./configure --disable-shared \
    && make \
    && cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin \
    && popd \
    && rm -rf /tmp/gettext
