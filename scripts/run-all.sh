#!/bin/bash
set -e
echo "Start.."

# prepare to build
sh $LFS/scripts/prepare/run-prepare.sh

# execute rest as root
# echo -e "root\n" | exec sudo -S ls -al
# sudo sh -c "echo root:root | chpasswd"

# echo -e "root\n" | exec sudo -S -E -u root /bin/sh -c "apt-get update"

echo "root\n" | exec sudo -E -u root /bin/sh - <<EOF
#  change ownership
chown -R root:root $LFS/tools
# prevent "bad interpreter: Text file busy"
sync
# continue
sh $LFS/scripts/build/run-build.sh
# prevent "bad interpreter: Text file busy"
sync
EOF

if [[ $CREATE_IMAGE_ISO -eq "1" ]]; then   
echo "root\n" | exec sudo -E -u root /bin/sh - <<EOF
# continue
sync
sh $LFS/scripts/image/run-image.sh
# prevent "bad interpreter: Text file busy"
sync
EOF
fi