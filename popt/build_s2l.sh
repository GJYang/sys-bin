#!/bin/bash
. ../one_time_build_env_include
VERSION=1.16
CROSS=arm-linux-gnueabihf
pushd popt-${VERSION} > /dev/null
./configure --host=${CROSS} --prefix=/usr
make clean
make CC=${CROSS}-gcc
make install DESTDIR=${OUTDIR}/popt

popd > /dev/null


echo "popt-${VERSION}" >> ../sysbuild.log
