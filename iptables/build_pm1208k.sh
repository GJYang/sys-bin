#!/bin/bash -e
. ../one_time_build_env_include
VERSION=1.4.19
pushd iptables-${VERSION} 
./configure --host=mips-linux-gnu CC="mips-linux-gnu-gcc -EL" CFLAGS=-EL LDFLAGS=-EL CPPFLAGS=-EL \
--prefix=/usr/local/pmmips 
make clean 
make 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/iptables 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
popd 


#echo "ncurses-6.0" >> ../sysbuild.log
