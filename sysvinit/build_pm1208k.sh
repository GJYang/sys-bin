#!/bin/bash
#BASE_DIR=/home/fwbuilder/firmwares/rev-l/Ver-4.31
. ../one_time_build_env_include
BASE_DIR=${OUTDIR}/sysvinit
VERSION="2.88dsf"
sudo chown -R gjyang:gjyang ${BASE_DIR}/sysvinit

pushd sysvinit-${VERSION}/src >/dev/null
make ROOT=${BASE_DIR} CC="mips-linux-gnu-gcc -EL" clobber > /dev/null
make ROOT=${BASE_DIR} CC="mips-linux-gnu-gcc -EL" > /dev/null
make ROOT=${BASE_DIR} CC="mips-linux-gnu-gcc -EL" install > /dev/null
popd > /dev/null


echo "sysvinit-${VERSION}" >> ../sysbuild.log

