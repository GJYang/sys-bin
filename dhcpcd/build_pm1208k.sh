#!/bin/bash -e
. ../one_time_build_env_include
VERSION=6.9.3
pushd dhcpcd-${VERSION} 
./configure --host=mips-linux-gnu 
make clean 
make CFLAGS=-EL LDFLAGS=-EL 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make CFLAGS=-EL LDFLAGS=-EL install DESTDIR=${OUTDIR}/dhcpd 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

mips-linux-gnu-strip dhcpcd 

popd 

echo "dhcpcd-${VERSION}" >> ../sysbuild.log
