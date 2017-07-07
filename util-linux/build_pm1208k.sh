#!/bin/bash 
VERSION="2.27-rc2"
. ../one_time_build_env_include
#OUTDIR="`pwd`/_install"
#rm -rf _install/*
pushd util-linux-${VERSION}
make clean > /dev/null
./configure \
--host=mips-linux-gnu \
--enable-sfdisk \
--enable-static=yes \
--enable-static-programs=sfdisk \
--without-python \
--without-tinfo \
--without-ncurses \
--enable-libfdisk \
--enable-libblkid \
--enable-libuuid \
--enable-libsmartcols \
--disable-rpath \
--disable-mount \
--disable-losetup \
--disable-zramctl \
--disable-fsck \
--disable-fallocate \
--disable-unshare \
--disable-nsenter \
--disable-setpriv \
--disable-eject \
--disable-agetty \
--disable-cramfs \
--disable-bfs \
--disable-minix \
--disable-fdformat \
--disable-hwclock \
--disable-wdctl \
--disable-cal \
--disable-switch_root \
--disable-pivot_root \
--disable-kill \
--disable-last \
--disable-utmpdump \
--disable-mesg \
--disable-raw \
--disable-rename \
--disable-login \
--disable-nologin \
--disable-sulogin \
--disable-su \
--disable-runuser \
--disable-ul \
--disable-more \
--disable-pg \
--disable-setterm \
--disable-schedutils \
--disable-wall \
CC="mips-linux-gnu-gcc -EL" CFLAGS=-EL LDFLAGS=-EL CPPFLAGS=-EL > /dev/null


make CC="mips-linux-gnu-gcc -EL" > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

cp ../Makefile.patch ./
patch -p0 < Makefile.patch
make install DESTDIR=${OUTDIR}/util-linux > /dev/null

popd > /dev/null


echo "util-linux-${VERSION} (libblkid, libuuid, libfdisk, ...)" >> ../sysbuild.log
