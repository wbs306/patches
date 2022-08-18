#!/bin/bash

set -e

PD=$PWD/patches

DEVICE="XAGA"

apply_patch() {
patches="$(readlink -f -- $1)"
tree="$2"

for project in $(cd $patches/patches/$tree; echo *);do
	p="$(tr _ / <<<$project |sed -e 's;platform/;;g')"
	pushd $p
	for patch in $patches/patches/$tree/$project/*.patch;do
		git am $patch || exit
	done
	popd
done
}

if [ $1 = kscope ];then
echo ""
echo "Adapt KaleidoscopeOS to ${DEVICE}"
echo "Executing in 5 seconds - CTRL-C to exit"
echo ""
fi

if [ $1 = pe ];then
echo ""
echo "Adapt Pixel-Experience to ${DEVICE}"
echo "Executing in 5 seconds - CTRL-C to exit"
echo ""
fi

sleep 5

echo "Applying patches"
apply_patch $PD $1
