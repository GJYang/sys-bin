#!/bin/bash -e

. ../one_time_build_env_include
SYS_BIN_NAME=$(basename `pwd`)
VERSION=1.4.3

pushd ${SYS_BIN_NAME}-${VERSION}  > /dev/null
echo ${OUTDIR}/ncurses/usr/lib
./configure --host=${CROSS_HOST} LDFLAGS="-L${OUTDIR}/ncurses/usr/lib -L${OUTDIR}/libpcap/usr/local/lib" \
CFLAGS="-I${OUTDIR}/libpcap/usr/local/include -I${OUTDIR}/ncurses/usr/include" \
CPPFLAGS="-I${OUTDIR}/libpcap/usr/local/include -I${OUTDIR}/ncurses/usr/include" \
CXXFLAGS="-I${OUTDIR}/libpcap/usr/local/include -I${OUTDIR}/ncurses/usr/include "

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

