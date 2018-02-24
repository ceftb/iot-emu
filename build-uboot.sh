#!/bin/bash

set -e

export ARCH=arm
export CROSS_COMPILE=aarch64-linux-gnu-
export PATH=`pwd`/gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu/bin:$PATH
cd u-boot

sed -i \
  "s/CONFIG_BOOTDELAY.*/CONFIG_BOOTDELAY=-1/g" \
  configs/vexpress_aemv8a_semi_defconfig

make clean
make vexpress_aemv8a_semi_config
make
