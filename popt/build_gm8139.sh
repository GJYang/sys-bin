#!/bin/bash
. ../one_time_build_env_include
VERSION=1.16
pushd popt-${VERSION} > /dev/null
./configure --host=/opt/arm-none-linux-gnueabi-4.4.0_linux-3.3/bin/arm-none-linux-gnueabi --prefix=/usr
make clean
make CC="mips-linux-gnu-gcc -EL"
make install DESTDIR=${OUTDIR}/popt

popd > /dev/null


echo "popt-${VERSION}" >> ../sysbuild.log
