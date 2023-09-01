#!/bin/bash
set -e
echo "Managing devices.."

# generate udev rules for networking
bash /usr/lib/udev/init-net-rules.sh

# inspect generated
cat /etc/udev/rules.d/70-persistent-net.rules || true

# If you wish to see the values that the udev scripts will use, 
# then for the appropriate CD-ROM device, find the corresponding 
# directory under /sys (e.g., this can be /sys/block/hdd ) and 
# run a command similar to the following:
# udevadm test /sys/block/hdd

# sed -e 's/"write_cd_rules"/"write_cd_rules mode"/' \
#    -i /etc/udev/rules.d/83-cdrom-symlinks.rules

# Dealing with duplicate devices
# udevadm info -a -p /sys/class/video4linux/video0

cat > /etc/udev/rules.d/83-duplicate_devs.rules << "EOF"
# Persistent symlinks for webcam and tuner
KERNEL=="video*", ATTRS{idProduct}=="1910", ATTRS{idVendor}=="0d81", SYMLINK+="webcam"
KERNEL=="video*", ATTRS{device}=="0x036f", ATTRS{vendor}=="0x109e", SYMLINK+="tvtuner"
EOF