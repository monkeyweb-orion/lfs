#!/bin/bash
set -e
echo "Preparing environment.."

# download toolchain
# $LFS/scripts/prepare/3.2-download-tools.sh
pushd $LFS/sources

# build toolchain
time ( 
$LFS/scripts/prepare/5.2-make-binutils.sh
$LFS/scripts/prepare/5.3-make-gcc.sh
$LFS/scripts/prepare/5.4-make-linux-api-headers.sh
$LFS/scripts/prepare/5.5-make-glibc.sh
$LFS/scripts/prepare/5.6-make-libstdc++.sh

# Cross compilling temporary tools
$LFS/scripts/prepare/6.2-make-m4.sh
$LFS/scripts/prepare/6.3-make-ncurses.sh
$LFS/scripts/prepare/6.4-make-bash.sh
$LFS/scripts/prepare/6.5-make-coreutils.sh
$LFS/scripts/prepare/6.6-make-diffutils.sh
$LFS/scripts/prepare/6.7-make-file.sh
$LFS/scripts/prepare/6.8-make-findutils.sh
$LFS/scripts/prepare/6.9-make-gawk.sh
$LFS/scripts/prepare/6.10-make-grep.sh
$LFS/scripts/prepare/6.11-make-gzip.sh
$LFS/scripts/prepare/6.12-make-make.sh
$LFS/scripts/prepare/6.13-make-patch.sh
$LFS/scripts/prepare/6.14-make-sed.sh
$LFS/scripts/prepare/6.15-make-tar.sh
$LFS/scripts/prepare/6.16-make-xz.sh
$LFS/scripts/prepare/6.17-make-binutils.sh
$LFS/scripts/prepare/6.18-make-gcc.sh 

$LFS/scripts/prepare/6.19-backup-compress-tools.sh ) 2>&1 | tee $LFS/build-$(date +%Y%m%dT%H%M%S).log