#!/bin/bash
. ../one_time_build_env_include
VERSION=1.2.8
pushd zlib-${VERSION} > /dev/null
CC="arm-none-linux-gnueabi-gcc" AR=arm-none-linux-gnueabi-ar RANLIB=arm-none-linux-gnueabi-ranlib ./configure --shared --prefix=/usr > /dev/null
make clean > /dev/null
make CC=arm-none-linux-gnueabi-gcc > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/zlib > /dev/null

popd > /dev/null

echo "[$0] zlib-${VERSION} (libz)" >> ../sysbuild.log
