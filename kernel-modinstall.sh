cd linux-stable

export PATH=`pwd`/../gcc-linaro-7.2.1-2017.11-i686_arm-linux-gnueabihf/bin:$PATH

make \
  INSTALL_MOD_PATH=`pwd`/../img/p2/ \
  ARCH=arm \
  CROSS_COMPILE=arm-linux-gnueabihf- \
  LOADADDR=0x60008000 \
  modules_install
