#!/bin/bash
Room=$1
#echo $Room

#if [ -n $Room ]
#then
#exit 1
#fi

declare -i m_offset=0

	Date=`date`
	m_TimeCut=`echo $Date | cut -d ' ' -f 4`
	rm -f 	./$Room*
#	while [ $m_offset -lt 8 ]
#	do
		fileName="$Room?offset=$m_offset&limit=30"
		wget -c "http://api.douyutv.com/api/v1/live/$fileName" -O $Room.$m_offset &> /dev/null
#		let m_offset=$m_offset+1
#	done
	./deal.sh $Room $m_TimeCut
