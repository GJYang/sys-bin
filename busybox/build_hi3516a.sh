#!/bin/bash -e
. ../one_time_build_env_include
BUSYBOX_VERSION="1.23.2"
patch -p0 < Makefile_LSB.patch
#do mame menuconfig and check configuration
pushd busybox-${BUSYBOX_VERSION} 
make distclean 
cp ../${tmn}_config .config
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
mkdir -p ${OUTDIR}/busybox
cp -a _install/* ${OUTDIR}/busybox
popd 

echo "busybox-${BUSYBOX_VERSION}" >> ../sysbuild.log
