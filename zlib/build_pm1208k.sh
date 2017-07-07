#!/bin/bash
. ../one_time_build_env_include
VERSION=1.2.8
pushd zlib-${VERSION} > /dev/null
CC="mips-linux-gnu-gcc -EL" AR=mips-linux-gnu-ar RANLIB=mips-linux-ranlib ./configure --shared --prefix=/usr > /dev/null
make clean > /dev/null
make CC="mips-linux-gnu-gcc -EL" > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/zlib > /dev/null

popd > /dev/null

echo "zlib-${VERSION} (libz)" >> ../sysbuild.log
