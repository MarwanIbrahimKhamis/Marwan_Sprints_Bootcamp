#!/usr/bin/env bash


creating_dated_files()
{
	for m in {1..12}
	do
		y=$(date +%Y)
		if [ -e ~/Reports/$y/$m ]
		then
			echo "Directory ~/Reports/$y/$m already exsts"
		else	
			mkdir -p ~/Reports/$y/$m
		fi
		DAYS=$(cal $m $y | awk 'NF {days = $NF}; END {print days}')
		for (( d=1; d<=$DAYS; d++ ))
		do
			if [ -e ~/Reports/$y/$m/$d.xls ]
			then
				echo "file ~/Reports/$y/$m/$d.xls already exists "
			else
				touch ~/Reports/$y/$m/$d.xls
			fi

		done
	done
}

if [ -e ~/Reports ]
then
	echo "Reports dirctory already exists"
	creating_dated_files
else
	mkdir ~/Reports
	creating_dated_files
fi

mkdir ~/Backups

runtime=$(date +%H)

if [ $runtime -ge 00 ] && [ $runtime -le 04 ]
then
	rsync -av ~/Reports ~/Backups
fi
