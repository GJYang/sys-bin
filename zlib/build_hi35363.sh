#!/bin/bash
. ../one_time_build_env_include
VERSION=1.2.8
pushd zlib-${VERSION} > /dev/null
CC="arm-hisiv400-linux-gcc" AR=arm-hisiv400-linux-ar RANLIB=mips-linux-ranlib ./configure --shared --prefix=/usr 
make clean 
make CC="arm-hisiv400-linux-gcc" 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/zlib 

popd > /dev/null

echo "zlib-${VERSION} (libz)" >> ../sysbuild.log
