#!/bin/bash -e

. ../one_time_build_env_include
SYS_BIN_NAME=$(basename `pwd`)
VERSION=3.1.3

pushd ${SYS_BIN_NAME}-${VERSION} 
./configure --host=${CROSS_HOST} 
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
popd 

