#!/bin/bash
. ../one_time_build_env_include
VERSION=1.16
pushd popt-${VERSION} > /dev/null
./configure --host=mips-linux-gnu --prefix=/usr CC="mips-linux-gnu-gcc -EL" > /dev/null
make clean > /dev/null
make CC="mips-linux-gnu-gcc -EL" > /dev/null
make install DESTDIR=${OUTDIR}/popt > /dev/null

popd > /dev/null


echo "popt-${VERSION}" >> ../sysbuild.log
