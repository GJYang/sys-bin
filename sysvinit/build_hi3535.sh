#!/bin/bash
#BASE_DIR=/home/fwbuilder/firmwares/rev-l/Ver-4.31

. ../one_time_build_env_include

BASE_DIR=${OUTDIR}/sysvinit
VERSION=2.88dsf
sudo chown -R gjyang:gjyang ${BASE_DIR}/sysvinit

pushd sysvinit-${VERSION}/src >/dev/null
make ROOT=${BASE_DIR} CC=arm-hisiv100nptl-linux-gcc clobber
make ROOT=${BASE_DIR} CC=arm-hisiv100nptl-linux-gcc
make ROOT=${BASE_DIR} CC=arm-hisiv100nptl-linux-gcc install
popd > /dev/null


#sudo chown -R root:root ${BASE_DIR}/sysvinit

echo "sysvinit-${VERSION}" >> ../sysbuild.log

