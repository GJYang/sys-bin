#!/bin/bash 
# VERSION="2.27-rc2"
VERSION="2.28-rc2"
. ../one_time_build_env_include

#
rm -r util-linux-2.28-rc2
tar xfz util-linux-2.28-rc2-hi3535.tar.gz
sync

pushd util-linux-${VERSION}
# patch -p0  < ../uclibc_patch.patch
# patch -p0  < ../initial_declarations.patch
# make clean > /dev/null
./configure \
--host=${CROSS_HOST} \
--enable-static=yes \
--enable-static-programs=sfdisk \
--without-python \
--without-tinfo \
--without-ncurses \
--enable-libfdisk \
--enable-libblkid \
--enable-libuuid \
--enable-libmount \
--enable-libsmartcols \
--disable-rpath \
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
NCURSESW_CFLAGS=-L${OUTDIR}/ncurses/usr/lib \
NCURSESW_LIBS="-lncurses " \
 > /dev/null


make CC="${CROSS_HOST}-gcc" > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

cp ../Makefile.patch ./
# patch -p0 < Makefile.patch
rm -r ${OUTDIR}/util-linux/*
make install DESTDIR=${OUTDIR}/util-linux > /dev/null

popd > /dev/null


echo "util-linux-${VERSION} (libblkid, libuuid, libfdisk, ...)" >> ../sysbuild.log
