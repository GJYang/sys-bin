#!/bin/bash
. ../one_time_build_env_include
VERSION=6.0
pushd ncurses-${VERSION} > /dev/null
make distclean > /dev/null
./configure --host=${CROSS_HOST} --with-shared --without-manpages 
make -j5 > /dev/null
make install DESTDIR=${OUTDIR}/ncurses > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.test > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.menu > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.form > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.panel > /dev/null
make DESTDIR=${OUTDIR}/ncurses uninstall.progs > /dev/null
popd > /dev/null


echo "ncurses-${VERSION}" >> ../sysbuild.log
