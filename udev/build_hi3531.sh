#!/bin/bash

. ../one_time_build_env_include
KMOD_VERSION=21
pushd /home/gjyang/sys-bin/kmod/kmod-${KMOD_VERSION} > /dev/null
./configure --host=arm-hisiv200-linux
make CC=arm-hisiv200-linux-gcc 
make DESTDIR=${OUTDIR}/kmod install 
popd > /dev/null


UDEV_VERSION=164

pushd udev-${UDEV_VERSION} > /dev/null
export KMOD_LIBS=-L/home/gjyang/hi3531/sys-bin/kmod/usr/lib
export KMOD_CFLAGS=-I/home/gjyang/hi3531/sys-bin/kmod/usr/include
export BLKID_LIBS=-L/home/gjyang/hi3531/sys-bin/util-linux/usr/lib
export BLKID_CFLAGS=-I/home/gjyang/hi3531/sys-bin/util-linux/usr/include
./configure --prefix=/ \
--host=arm-hisiv200-linux \
--disable-extras \
--disable-introspection \
--disable-gudev \
--with-pci-ids-path=no \
--libexecdir=/lib/udev
make clean 
make 
make install DESTDIR=${OUTDIR}/udev
mkdir -p ${OUTDIR}/udev/etc/udev
#cp udev/udevd ${OUTDIR}/udev
#cp udev/udevadm ${OUTDIR}/udev
#cp udev.conf ${OUTDIR}/udev/etc/udev
popd > /dev/null

echo "udev-${UDEV_VERSION}" >> ../sysbuild.log
#
