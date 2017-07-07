#!/bin/bash -e

pushd kexec-tools-2.0.9 > /dev/null
./configure --host=mips-linux-gnu CC="mips-linux-gnu-gcc -EL"
make clean
make CC="mips-linux-gnu-gcc -EL"
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=/home/gjyang/pm1208k/ri_base
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

popd > /dev/null


echo "kexec-tools-2.0.9" >> ../sysbuild.log
