#!/bin/bash -e
. ../one_time_build_env_include
VERSION=2.06
pushd lzo-${VERSION} > /dev/null
./configure --host=arm-hisiv400-linux --prefix=/usr CC="arm-hisiv400-linux-gcc" --enable-shared 
make clean
make CC="arm-hisiv400-linux-gcc"
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/lzo
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

popd > /dev/null


echo "lzo-${VERSION} (liblzo)" >> ../sysbuild.log