
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### Raspbian Image
###
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

raspbian_lite_latest.img:
	wget https://downloads.raspberrypi.org/raspbian_lite_latest
	unzip raspbian_lite_latest
	rm raspbian_lite_latest
	mv *-raspbian-stretch-lite.img raspbian_lite_latest.img

piq.img: | raspbian_lite_latest.img linux-stable/arch/arm/boot/uImage linux-stable/arch/arm/boot/dts/vexpress-v2p-ca9.dtb
	./prep-pi-image.sh

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### Compiler Toolchains
###
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Arm8 (64 bit) -------------------------------------------------------------

gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz: 
	wget https://releases.linaro.org/components/toolchain/binaries/latest/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz


gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu: | gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz
	unxz --keep gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz
	tar xf gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar

### Arm7 (32 bit) -------------------------------------------------------------

gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf.tar.xz: 
	wget https://releases.linaro.org/components/toolchain/binaries/latest/arm-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf.tar.xz

gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf: | gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf.tar.xz
	unxz --keep gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf.tar.xz
	tar xf gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf.tar

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### ARM Versatile Express Board for Cortex A9
###
### 	linux-kernel: 4.15.6 ~ vexpress_config
### 	device-tree: 	4.15.6 ~ vexpress-v2p-ca9.dtb
### 	u-boot: 			mainline ~ vexpress_ca9x4_config
###
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Linux Kernel --------------------------------------------------------------

linux-stable:
	git clone \
		--branch v4.15.6 \
		git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

linux-stable/arch/arm/boot/uImage linux-stable/arch/arm/boot/zImage linux-stable/arch/arm/boot/dts/vexpress-v2p-ca9.dtb: | linux-stable
	./make-kernel.sh


### U-Boot --------------------------------------------------------------------

u-boot:
	git clone git://git.denx.de/u-boot.git

uboot-a9: | u-boot gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf
	./build-uboot-a9.sh

.PHONY: prepare-a9
prepare-a9: uboot-a9 raspbian_lite_latest.img piq.img


.PHONY: run-a9
run-a9: prepare-a9
	./launch-a9.sh

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###
### ARM Versatile Express Board for Cortex A15 (using A53)
###
### 	linux-kernel: ?
### 	device-tree: 	?
### 	u-boot: 			?
###
###   TODO WORK IN PROGRESS XXX
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

uboot-a53: | u-boot gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu
	./build-uboot-a53.sh

.PHONY: prepare-a53
prepare-a53: uboot-a53 raspbian_lite_latest.img vexpress-v2p-ca15-tc1.dtb

.PHONY: run-a53
run-a53: prepare-a53
	./launch-a53.sh
