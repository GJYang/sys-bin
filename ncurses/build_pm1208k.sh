#!/bin/bash
. ../one_time_build_env_include
VERSION=6.0
pushd ncurses-${VERSION} > /dev/null
./configure --host=mips-linux-gnu --with-shared --without-manpages CFLAGS=-EL LDFLAGS=-EL CPPFLAGS=-EL
#make clean > /dev/null
make CC="mips-linux-gnu-gcc -EL" CFLAGS=-EL LDFLAGS=-EL> /dev/null
make install DESTDIR=${OUTDIR}/ncurses > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.test > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.menu > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.form > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.panel > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.progs > /dev/null
popd > /dev/null


echo "ncurses-${VERSION}" >> ../sysbuild.log
