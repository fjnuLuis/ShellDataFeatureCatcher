#!/bin/bash

Room=$1
Date=$2
declare -i Count=0
Item=""
declare -i Sum=0
declare -i Avg=0
declare -i m_offset=0
#while [ $m_offset -lt 8 ]
#do
	sed -i 's/{/\n{/g' ./$Room.$m_offset
	Item=$Item`awk  'BEGIN{FS="\""} {print $57}' ./$Room.$m_offset | cut -d : -f 2 | cut -d , -f 1`
#	let m_offset=$m_offset+1
#done

#echo $Item

for I in $Item
do
	let Sum=$Sum+$I
	let Count=$Count+1
done
#echo $Sum  $Count
let Avg=$Sum/$Count
echo $Date $Avg $Sum >> AVG.DATA.$Room
