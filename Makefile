
raspbian_lite_latest.img:
	wget https://downloads.raspberrypi.org/raspbian_lite_latest
	unzip raspbian_lite_latest
	rm raspbian_lite_latest
	mv *-raspbian-stretch-lite.img raspbian_lite_latest.img

gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz: 
	wget https://releases.linaro.org/components/toolchain/binaries/latest/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz

gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu: | gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz
	unxz --keep gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar.xz
	tar xf gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu.tar

u-boot:
	git clone git://git.denx.de/u-boot.git

u-boot/u-boot: | u-boot gcc-linaro-7.2.1-2017.11-i686_aarch64-linux-gnu
	./build-uboot.sh

.PHONY: prepare
prepare: u-boot/u-boot raspbian_lite_latest.img

.PHONY: run
run: prepare
	./launch.sh

