#!/bin/bash
. ../one_time_build_env_include
VERSION=4.2.8p3
rm -rf ntp-${VERSION}
tar xfz ntp-${VERSION}.tar.gz
pushd ntp-${VERSION} > /dev/null
./configure --host=mips-linux-gnu --with-yielding-select \
--enable-clockctl \
--prefix=/usr CC="mips-linux-gnu-gcc -EL" > /dev/null
make clean > /dev/null
make CC="mips-linux-gnu-gcc -EL" > /dev/null
make DESTDIR=${OUTDIR}/ntp install  > /dev/null
popd > /dev/null

echo "ntp-${VERSION}" >> ../sysbuild.log

