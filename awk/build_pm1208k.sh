#!/bin/bash -e
. ../one_time_build_env_include
pushd gawk-4.1.3 
make clean
./configure --host=${CROSS_HOST} CC="${CROSS_HOST}-gcc -EL"
make CC="${CROSS_HOST}-gcc -EL"
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make DESTDIR=${OUTDIR}/gawk install 
popd 
# make uninstall

echo "gawk-4.1.3" >> ../sysbuild.log
