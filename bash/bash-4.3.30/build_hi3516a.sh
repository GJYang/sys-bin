#!/bin/sh
./configure --host=arm-hisiv400-linux --enable-readline --enable-select --enable-history --enable-directory-stack --enable-alias
make
make DESTDIR=/home/gjyang/working/fwbuilder/HI3516A/firmwares/rev-k/Ver-4.31/ri_base install 
# make uninstall