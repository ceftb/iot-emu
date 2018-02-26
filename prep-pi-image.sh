#!/bin/bash

set -e

# make a copy of the raspbian image so we don't have to download again if
# something goes sideways
rm -rf img
mkdir img
cp raspbian_lite_latest.img img/pi.img
cd img

# mount the to partitions in the pi image
mkdir p1 p2
loopdev=`losetup -f`
sudo losetup -f -P pi.img
sudo mount -o sync ${loopdev}p1 p1
sudo mount -o sync ${loopdev}p2 p2

#nuke the boot directory - this is all raspberry pi hardware specific stuff
sudo rm -rf p1/*
#copy in the u-boot kernel image
sudo cp ../linux-stable/arch/arm/boot/uImage p1/
#copy in the device tree
sudo cp ../linux-stable/arch/arm/boot/dts/vexpress-v2p-ca9.dtb p1/
#copy a working fstab for vexpress-a9
sudo cp ../pi-fstab p2/etc/fstab

# finished modifying image unmount and close loopback device
sudo umount -l p1
sudo umount -l p2
sudo losetup -d ${loopdev}

# make a qcow2 image from the raw image
qemu-img convert -O qcow2 pi.img piq.img

cp piq.img ../

