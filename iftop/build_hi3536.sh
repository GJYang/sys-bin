#!/bin/bash -e

. ../one_time_build_env_include
SYS_BIN_NAME=$(basename `pwd`)
VERSION=0.17

# Build libpcap

pushd libpcap-1.8.1
./configure --host=${CROSS_HOST} --with-pcap=linux
make clean
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/libpcap
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
popd > /dev/null

pushd ${SYS_BIN_NAME}-${VERSION}  > /dev/null
./configure --host=${CROSS_HOST} --with-libpcap=${OUTDIR}/libpcap/usr/local LDFLAGS=-L${OUTDIR}/ncurses/usr/lib CFLAGS=-I${OUTDIR}/ncurses/usr/include
make clean 
make  
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/${SYS_BIN_NAME} 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
popd > /dev/null

