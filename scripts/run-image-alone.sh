#!/bin/bash
set -e
echo "Start.. (Image ISO)"

echo "root\n" | exec sudo -E -u root /bin/sh - <<EOF
# continue
sync
sh $LFS/scripts/image/run-image.sh
# prevent "bad interpreter: Text file busy"
sync
EOF