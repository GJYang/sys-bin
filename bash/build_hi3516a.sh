#!/bin/bash -e
. ../one_time_build_env_include
VERSION=4.3.30
pushd bash-${VERSION} 
make clean 
./configure --host=arm-hisiv400-linux \
--enable-readline \
--enable-select \
--enable-history \
--enable-directory-stack \
--enable-alias \
--prefix=/usr \

make CC=arm-hisiv400-linux-gcc 
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

make DESTDIR=${OUTDIR}/bash install 
popd 
# make uninstall

echo "bash-${VERSION}" >> ../sysbuild.log
