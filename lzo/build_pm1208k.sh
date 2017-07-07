#!/bin/bash -e
. ../one_time_build_env_include
VERSION=2.06
pushd lzo-${VERSION} > /dev/null
./configure --host=mips-linux-gnu --prefix=/usr CC="mips-linux-gnu-gcc -EL" --enable-shared > /dev/null
make clean  > /dev/null
make CC="mips-linux-gnu-gcc -EL"  > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/lzo  > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

popd > /dev/null


echo "lzo-${VERSION} (liblzo)" >> ../sysbuild.log
