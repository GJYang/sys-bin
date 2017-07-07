#!/bin/bash

. ../one_time_build_env_include
KMOD_VERSION=21
pushd kmod-${KMOD_VERSION} > /dev/null
./configure --host=mips-linux-gnu CFLAGS=-EL LDFLAGS=-EL CPPFLAGS=-EL --enable-gtk-doc-html=no --disable-manpages --disable-test-modules > /dev/null
make clean > /dev/null
patch -p1<../kmod_pm1208k.patch
make CFLAGS=-EL LDFLAGS=-EL CPPFLAGS=-EL  CC="mips-linux-gnu-gcc -EL" > /dev/null
make DESTDIR=${OUTDIR}/kmod install > /dev/null
popd > /dev/null


UDEV_VERSION=164

pushd udev-${UDEV_VERSION} > /dev/null
./configure --prefix=/ --host=mips-linux-gnu CFLAGS=-EL LDFLAGS=-EL --disable-extras --disable-introspection > /dev/null
patch -p1<../udev-164_pm1208k.patch
make clean > /dev/null
make > /dev/null
make install DESTDIR=${OUTDIR}/udev > /dev/null
mkdir -p ${OUTDIR}/udev/etc/udev
#cp udev/udevd ${OUTDIR}/udev
#cp udev/udevadm ${OUTDIR}/udev
#cp udev.conf ${OUTDIR}/udev/etc/udev
popd > /dev/null

echo "udev-${UDEV_VERSION}" >> ../sysbuild.log
#
