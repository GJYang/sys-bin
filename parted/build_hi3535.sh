#!/bin/bash -e
. ../one_time_build_env_include
VERSION=3.1
pushd parted-${VERSION} 
./configure --host=${CROSS_HOST} -disable-device-mapper --without-readline \
LDFLAGS="-L/home/gjyang/$tmn/sys-bin/util-linux/usr/lib" \
CFLAGS="-I/home/gjyang/$tmn/sys-bin/util-linux/usr/include" \
--enable-static=parted

make CC=${CROSS_HOST}-gcc 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

make DESTDIR=${OUTDIR}/parted install 
popd 
# make uninstall

echo "parted-${VERSION}" >> ../sysbuild.log
