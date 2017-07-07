#!/bin/bash
. ../one_time_build_env_include
VERSION=4.2.8p3
rm -rf ntp-${VERSION}
tar xfz ntp-${VERSION}.tar.gz
pushd ntp-${VERSION} > /dev/null
./configure --host=${CROSS_HOST} --with-yielding-select \
--enable-clockctl \
--prefix=/usr CC=${CROSS_HOST}-gcc > /dev/null
make clean > /dev/null
make CC=${CROSS_HOST}-gcc > /dev/null
make DESTDIR=${OUTDIR}/ntp install  > /dev/null
popd > /dev/null

echo "ntp-${VERSION}" >> ../sysbuild.log

