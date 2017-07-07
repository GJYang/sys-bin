#!/bin/bash

. ../one_time_build_env_include
VERSION=1.0.29
pushd pure-ftpd-${VERSION} 
./configure --host=arm-hisiv100nptl-linux \
--with-minimal 
make clean 
make  
make install DESTDIR=${OUTDIR}/ftpd 
popd 

#echo "pure-ftpd" >> ../sysbuild.log
