#!/bin/bash
set -e
echo "Continue with chroot environment.."

# SKIP remove the "I have no name!" promp
# exec /scripts/build/bin/bash --login +h

# build toolchain
sh /scripts/build/7.5-create-directories.sh
sh /scripts/build/7.6-create-essentials.sh
sh /scripts/build/7.7-make-gettext.sh
sh /scripts/build/7.8-make-bison.sh
sh /scripts/build/7.9-make-perl.sh
sh /scripts/build/7.10-make-python.sh
sh /scripts/build/7.11-make-texinfo.sh
sh /scripts/build/7.12-make-util-linux.sh

# If you want to make a backup
sh /scripts/build/7.13-cleaning-and-saving.sh

# SKIP switching to built bash
# exec /bin/bash --login +h

# Installing Basic System
sh /scripts/build/8.3-make-man-pages.sh
sh /scripts/build/8.4-make-iana-etc.sh
sh /scripts/build/8.5-make-glibc.sh
sh /scripts/build/8.6-make-zlib.sh
sh /scripts/build/8.7-make-bzip2.sh
sh /scripts/build/8.8-make-xz.sh
sh /scripts/build/8.9-make-zstd.sh
sh /scripts/build/8.10-make-file.sh
sh /scripts/build/8.11-make-readline.sh
sh /scripts/build/8.12-make-m4.sh
sh /scripts/build/8.13-make-bc.sh
sh /scripts/build/8.14-make-flex.sh
sh /scripts/build/8.15-make-tcl.sh
sh /scripts/build/8.16-make-expect.sh
sh /scripts/build/8.17-make-dejagnu.sh
sh /scripts/build/8.18-make-binutils.sh
sh /scripts/build/8.19-make-gmp.sh
sh /scripts/build/8.20-make-mpfr.sh
sh /scripts/build/8.21-make-mpc.sh
sh /scripts/build/8.22-make-attr.sh
sh /scripts/build/8.23-make-acl.sh
sh /scripts/build/8.24-make-libcap.sh
sh /scripts/build/8.25-make-shadow.sh
sh /scripts/build/8.26-make-gcc.sh
sh /scripts/build/8.27-make-pkg-config.sh
sh /scripts/build/8.28-make-ncurses.sh
sh /scripts/build/8.29-make-sed.sh
sh /scripts/build/8.30-make-psmisc.sh
sh /scripts/build/8.31-make-gettext.sh
sh /scripts/build/8.32-make-bison.sh
sh /scripts/build/8.33-make-grep.sh
sh /scripts/build/8.34-make-bash.sh
sh /scripts/build/8.35-make-libtool.sh
sh /scripts/build/8.36-make-gdbm.sh
sh /scripts/build/8.37-make-gperf.sh
sh /scripts/build/8.38-make-expat.sh
sh /scripts/build/8.39-make-inetutils.sh
sh /scripts/build/8.40-make-less.sh
sh /scripts/build/8.41-make-perl.sh
sh /scripts/build/8.42-make-xml-parser.sh
sh /scripts/build/8.43-make-intltool.sh
sh /scripts/build/8.44-make-autoconf.sh
sh /scripts/build/8.45-make-automake.sh
sh /scripts/build/8.46-make-openssl.sh
sh /scripts/build/8.47-make-kmod.sh
sh /scripts/build/8.48-make-libelf.sh
sh /scripts/build/8.49-make-libffi.sh
sh /scripts/build/8.50-make-python.sh
sh /scripts/build/8.51-make-wheel.sh
sh /scripts/build/8.52-make-ninja.sh
sh /scripts/build/8.53-make-meson.sh
sh /scripts/build/8.54-make-coreutils.sh
sh /scripts/build/8.55-make-check.sh
sh /scripts/build/8.56-make-diffutils.sh
sh /scripts/build/8.57-make-gawk.sh
sh /scripts/build/8.58-make-findutils.sh
sh /scripts/build/8.59-make-groff.sh
sh /scripts/build/8.60-make-grub.sh
sh /scripts/build/8.61-make-gzip.sh
sh /scripts/build/8.62-make-iproute2.sh
sh /scripts/build/8.63-make-kbd.sh
sh /scripts/build/8.64-make-libpipeline.sh
sh /scripts/build/8.65-make-make.sh
sh /scripts/build/8.66-make-patch.sh
sh /scripts/build/8.67-make-tar.sh
sh /scripts/build/8.68-make-texinfo.sh
sh /scripts/build/8.69-make-vim.sh
sh /scripts/build/8.70-make-eudev.sh
sh /scripts/build/8.71-make-man-db.sh
sh /scripts/build/8.72-make-procps-ng.sh
sh /scripts/build/8.73-make-util-linux.sh
sh /scripts/build/8.74-make-e2fsprogs.sh
sh /scripts/build/8.75-make-sysklogd.sh
sh /scripts/build/8.76-make-sysvinit.sh

# --------------------------------------------------
# Stripping
# --------------------------------------------------
# This section is optional. If the intended user is not a programmer 
# and does not plan to do any debugging on the system software, the 
# system size can be decreased by about 2 GB by removing the 
# debugging symbols and unneeded symbol table entries from binaries
# and libraries. This causes no inconvenience other than not being 
# able to debug the software fully anymore.
# --------------------------------------------------
# sh /scripts/build/8.78-strip.sh

# Cleaning Up
sh /scripts/build/8.79-clean.sh

exit