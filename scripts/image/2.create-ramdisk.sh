#!/bin/bash
set -e
echo "Creating ramdisk.."

LOOP_DIR=$(pwd)/$LOOP
RAMDISK=$(pwd)/ramdisk

# Create yet another loop device if not exist
[ -e $LOOP ] || mknod $LOOP b 7 0

# create ramdisk file of IMAGE_SIZE
# dd if=/dev/zero of=$RAMDISK bs=1k count=$IMAGE_SIZE
sudo dd if=/dev/zero of=$RAMDISK bs=100M count=$IMAGE_SIZE

# plug off any virtual fs from loop device
sudo losetup -j /dev/loop0 || sudo losetup -d $LOOP && echo "... $LOOP ..."

# associate it with ${LOOP}
sudo losetup $LOOP $RAMDISK || true

# make an ext2 filesystem
sudo mkfs.ext4 -q -m 0 $LOOP $IMAGE_SIZE

# ensure loop2 directory
[ -d $LOOP_DIR ] || mkdir -pv $LOOP_DIR

# mount it
sudo mount $LOOP $LOOP_DIR
rm -rf $LOOP_DIR/lost+found

# copy LFS system without build artifacts
pushd $INITRD_TREE
cp -dpR $(ls -A | grep -Ev "sources|tools") $LOOP_DIR
popd

# show statistics
df $LOOP_DIR

echo "Compressing system ramdisk image.."
bzip2 -c $RAMDISK > $IMAGE

# Copy compressed image to /tmp dir (need for dockerhub)
cp -v $IMAGE .

# Cleanup
sudo umount $LOOP_DIR
sudo losetup -d $LOOP
rm -rf $LOOP_DIR
rm -f $RAMDISK
