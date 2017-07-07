#!/bin/bash

. ../one_time_build_env_include
KMOD_VERSION=21
pushd kmod-${KMOD_VERSION} > /dev/null
./configure --host=arm-hisiv400-linux --enable-gtk-doc-html=no --disable-manpages --disable-test-modules 
make clean 
make CC=arm-hisiv400-linux-gcc 
make DESTDIR=${OUTDIR}/kmod install 
popd > /dev/null


UDEV_VERSION=174

pushd udev-${UDEV_VERSION} > /dev/null
#./configure --prefix=/ --host=arm-hisiv400-linux --disable-extras --disable-introspection 
./configure --prefix=/ \
--host=arm-hisiv400-linux \
--disable-extras \
--disable-introspection \
--disable-gudev \
--with-pci-ids-path=no \
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
