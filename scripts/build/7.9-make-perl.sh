#!/bin/bash
set -e
echo "Building perl.."
echo "Approximate build time: 1.6 SBU"
echo "Required disk space: 282 MB"

# 7.9. The Perl package contains the Practical Extraction and Report Language.
tar -xf /sources/perl-5*.tar.xz -C /tmp/ \
  && mv /tmp/perl-* /tmp/perl \
  && pushd /tmp/perl

# Prepare Perl for compilation:
sh Configure -des                                           \
              -Dprefix=/usr                                 \
              -Dvendorprefix=/usr                           \
              -Dprivlib=/usr/lib/perl5/5.36/core_perl       \
              -Darchlib=/usr/lib/perl5/5.36/core_perl       \
              -Dsitelib=/usr/lib/perl5/5.36/site_perl       \
              -Dsitearch=/usr/lib/perl5/5.36/site_perl      \
              -Dvendorlib=/usr/lib/perl5/5.36/vendor_perl   \
              -Dvendorarch=/usr/lib/perl5/5.36/vendor_perl

# Build the package:
make

# Install
make install

popd \
  && rm -rf /tmp/perl
