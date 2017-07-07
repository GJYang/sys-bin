#!/bin/bash
. ../one_time_build_env_include
VERSION=1.16
pushd popt-${VERSION} > /dev/null
./configure --host=arm-hisiv200-linux --prefix=/usr
make clean
make CC=arm-hisiv200-linux-gcc
make install DESTDIR=${OUTDIR}/popt

popd > /dev/null


echo "popt-${VERSION}" >> ../sysbuild.log
