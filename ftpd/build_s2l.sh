#!/bin/bash -e
. ../one_time_build_env_include
VERSION=1.0.29
pushd pure-ftpd-${VERSION} 
./configure --host=arm-linux-gnueabihf \
--with-minimal 
#--without-standalone \
make clean 
make  
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/ftpd 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
popd 

