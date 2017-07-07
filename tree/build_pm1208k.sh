#!/bin/bash
. ../one_time_build_env_include
VERSION=1.7.0
pushd tree-${VERSION} > /dev/null
make clean
make CC="mips-linux-gnu-gcc -EL"
mkdir -p ${OUTDIR}/tree
cp tree ${OUTDIR}/tree
popd > /dev/null


#echo "ncurses-6.0" >> ../sysbuild.log
