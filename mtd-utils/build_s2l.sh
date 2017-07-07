#!/bin/bash 
. ../one_time_build_env_include
E2FSPROGS_VERSION=1.42.9
MTDUTILS_VERSION=1.5.2
MTDUTILS_SRCVER=aea3641

pushd e2fsprogs-${E2FSPROGS_VERSION} > /dev/null
./configure --host=arm-hisiv400-linux \
--enable-symlink-install \
CC=arm-hisiv400-linux 
make clean
make > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make DESTDIR=${OUTDIR}/e2fsprogs install > /dev/null
popd > /dev/null
echo "e2fsprogs-${E2FSPROGS_VERSION}" >> ../sysbuild.log



pushd mtd-utils-${MTDUTILS_SRCVER} > /dev/null
patch -p0 < ../common.mk.$tmn.patch > /dev/null
make clean > /dev/null
WITHOUT_XATTR=1 make CC="arm-hisiv400-linux-gcc" > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make DESTDIR=${OUTDIR}/mtd-utils install > /dev/null
popd > /dev/null

echo "mtd-utils-${MTDUTILS_VERSION}" >> ../sysbuild.log

