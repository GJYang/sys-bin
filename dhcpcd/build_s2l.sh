#!/bin/bash -e
. ../one_time_build_env_include
VERSION=6.9.3
pushd dhcpcd-${VERSION} > /dev/null
./configure --host=$CROSS_HOST
make clean 
make
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/dhcpd 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

${CROSS_HOST}-strip dhcpcd 

popd > /dev/null

echo "dhcpcd-${VERSION}" >> ../sysbuild.log
