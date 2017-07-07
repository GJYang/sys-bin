#!/bin/bash -e
ARG1=$1

USAGE="Usage: $0 TMN=FW_XXXXX <package dir, example: \"iperf/\">"
if [ "$ARG1" = "" ]; then 
	echo 
	echo $USAGE
	echo 
	exit 0
fi

function strncmp ()
{
	if [ -z "${3}" -o "${3}" -le "0" ]; then
		return 0
	fi

	if [ ${3} -ge ${#1} -a ${3} -ge ${#2} ]; then
		strcmp "$1" "$2"
		return $?
	else
		s1=${1:0:$3}
		s2=${2:0:$3}
		strcmp $s1 $s2
		return $?
	fi
}

if [ $(echo "$ARG1" | cut -c1-4) = "TMN=" ]; then 
	TMP=`echo $ARG1 | cut -c 8-`
	TMN=$TMP
else
	echo
	echo "Argument \$1 must start with \"TMN=\""
	echo "$USAGE"
	echo
	exit 0
fi

tmn=$(echo ${TMN,,})

if [ -f "sysbuild.log" ];then 
	rm sysbuild.log
fi
# Create a header file to share environment variables
# with each build scripts in source file
if [ -f one_time_build_env_include ]; then
	rm one_time_build_env_include
fi
touch ./one_time_build_env_include
# echo "# create \"one_time_build_env_include\" for $TMN"
echo "# one_time_build_env" > one_time_build_env_include
echo "# `date`" 	>> one_time_build_env_include
# echo
echo "TOPDIR=`pwd`" 	>> one_time_build_env_include
echo "$TOPDIR"
echo "TMN=$TMN"		>> one_time_build_env_include
echo "tmn=$tmn" 	>> one_time_build_env_include
echo "OUTDIR=`pwd`/out/${TMN}/sys-bin" >> one_time_build_env_include
if [ "$tmn" = "s2l" ]; then
	echo "CROSS_HOST=arm-linux-gnueabihf" 	>> one_time_build_env_include
fi
if [ "$tmn" = "hi3535" ]; then
	echo "CROSS_HOST=arm-hisiv100nptl-linux" 	>> one_time_build_env_include
fi
if [ "$tmn" = "hi3536" ]; then
	echo "CROSS_HOST=arm-hisiv400-linux" 	>> one_time_build_env_include
fi
if [ "$tmn" = "pm1208k" ]; then
	echo "CROSS_HOST=mips-linux-gnu" 	>> one_time_build_env_include
fi
echo "# create \"one_time_build_env_include\" for $TMN done"
. ./one_time_build_env_include
echo "`cat one_time_build_env_include`"
echo "#"
if [ "$2" != "" ]; then
	echo -n "# Do you want continue to build \"$2\" for $TMN? (Y/n)"
else
	echo -n "# Do you want continue to build system binary for $TMN? (Y/n)"
fi
	read ANS
if [ "$ANS" != "Y" -a "$ANS" != "y" ]; then
	exit 0
fi
clear

echo "#"
echo "# Now start to build linux utilities ..."
echo "#"

declare -a arr=(`cat util_build.list`)


if [ "$2" != "" ]; then
	pushd "$2" >/dev/null
		[ -f build_$tmn.sh ] && /bin/sh build_$tmn.sh
	popd > /dev/null
else
	## now loop through the above array
	for i in "${arr[@]}"
	do
		pushd $i > /dev/null
		if [ -f "`pwd`/build_$tmn.sh" ]; then 
			ANS=""
			while [ "$ANS" = " " -o "$ANS" = "" ]
			do
				echo -n "Do you want build $i for $tmn? [Y/n]: "
				read ANS
			done
			if [ "$ANS" == "Y" -o "$ANS" == "y" ]; then
				/bin/sh build_$tmn.sh
			fi
		fi
		popd > /dev/null
	done
fi
