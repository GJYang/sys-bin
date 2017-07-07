#!/bin/bash -e
. ../one_time_build_env_include
VERSION=8.45.45-1
mkdir -p ${OUTDIR}/initscripts
mkdir -p ${OUTDIR}/initscripts/sbin
rm -rf initscripts-initscripts-${VERSION}
tar xfz initscripts-initscripts-${VERSION}.tar.gz

patch -p0 < hi3531-initsrc.patch
pushd initscripts-initscripts-${VERSION}/src 
make clean 
make 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
popd 


echo "initscripts-initscripts-${VERSION}" >> ../sysbuild.log

