#!/bin/bash

set -e

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH=`pwd`/gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf/bin:$PATH
cd u-boot

echo "CONFIG_BOOTDELAY=-1" >> configs/vexpress_ca9x4_defconfig

make clean
make vexpress_ca9x4_config
make -j `nproc`

cp u-boot ../uboot-a9
