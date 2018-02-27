# ceftb iot-emu

This repository contains code in support of iot device emulation for ceftb. Currently this includes

- Linux kernel build automation for versatile express platform
- u-boot build automation for qemu-system-aarch64:vexpress-a9:cortex-a9
- scripts to launch qemu-aarch64:vexpress-a15:coretex-a53 with u-boot bootloader

## Building
Before building, make sure the following dependencies are installed. The process has been tested on 64-bit Ubuntu 16.04 multiarch system.

First make sure you can run a 32-bit executable file on a 64-bit multi-architecture Ubuntu system.
- sudo dpkg --add-architecture i386
- sudo apt-get update
- sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
- sudo apt-get install multiarch-support

Next install GNU bc arbitrary precision calculator language
- sudo apt-get install bc

Next install companion tools for Das U-Boot bootloader 
- sudo apt-get install u-boot-tools

Now you can run the following make command for the building process

`- make prepare-a9`

## Running

For instant satisfaction

`RAWBOOT=1 make run-a9`

For U-Boot

`make run-a9`

Right now this will just dump you into the u-boot console. You will need to execute the following commands ftw.

```
setenv ker_addr_r 0x60008000
setenv ftd_addr_r 0x61008000
fatload mmc 0:1 ${ker_addr_r} uImage
fatload mmc 0:1 ${ftd_addr_r} vexpress-v2p-ca9.dtb
setenv bootargs "earlyprintk mem=1024M maxcpus=1 console=ttyAMA0 root=/dev/mmcblk0p2 rw rootwait panic=10"
bootm ${ker_addr_r} - ${ftd_addr_r}
```

## Terminating

In a different terminal (assuming you ahve no other `qemu-system-arm`s running)

`pkill -f qemu-system-arm`
