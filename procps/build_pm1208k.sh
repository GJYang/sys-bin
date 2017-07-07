#!/bin/bash
. ../one_time_build_env_include
VERSION=3.3.10
pushd procps-ng-${VERSION} > /dev/null
./configure \
--host=mips-linux-gnu \
--enable-static=no \
ac_cv_func_malloc_0_nonnull=yes \
ac_cv_func_realloc_0_nonnull=yes \
LDFLAGS=-L${OUTDIR}/ncurses/usr/lib \
CFLAGS=-I${OUTDIR}/ncurses/usr/include \
CC="mips-linux-gnu-gcc -EL" > /dev/null

make clean > /dev/null
make CC="mips-linux-gnu-gcc -EL" > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi
make install DESTDIR=${OUTDIR}/procps > /dev/null
if [ $? -ne 0 ]; then
    echo "Fail(make):$? [`pwd`]"
    exit 1
fi

popd > /dev/null

echo "procps-ng-${VERSION}" >> ../sysbuild.log
