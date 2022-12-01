#!/usr/bin/env bash

source ./libtask2.sh

while [ ! -e /home/maly/checkedfile ];
do
	echo "waiting for a checkedfile to exist"
	sleep 5
done
