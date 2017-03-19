#!/bin/bash
# Name: inter.sh
# Description: 
# Author: Lin
# Version: 0.0.1
# Datetime: 2017-02-01 15:10:55
# Usage: inter.sh
case $1 in 
1)
	danmu=data/douyudb/dy_danmu_${2}.csv
	gift=data/douyudb/dy_gift_${2}.csv
	;;
2)
	danmu=data/pandasdb/pd_danmu_${2}.csv
	gift=data/pandasdb/pd_gift_${2}.csv
	;;
*)
	echo "Usage:./inter.sh NUM(1-2,1 is douyu,2 is panda) ROOMID."
	exit 1
	;;
esac
if [ -f "$danmu"  -a -f "$gift" ]
then
cat $danmu $gift > tmp && sort -k 3 -t , tmp > tmp.txt
m_time=`head tmp.txt -n1 | cut -d ',' -f 3 `
cat tmp.txt | awk -F, '
function getOnline()
{
	m_sum += $4;
	m_num ++;
}

function rmRepeatD()
{
	m_numD++;
	if(userDanmu[$7] != 1 ){
		m_countD ++;
		userDanmu[$7]=1;
	}


}
function rmRepeatG()
{
	m_numG++;
	if(userGift[$7] != 1 ){
		m_countG ++;
		userGift[$7]=1;
	}


}

function outPut()
{
	if(m_num !=0) printf("%s %d %d %d %d %d\n",strftime("%H:%M:%S",m_time+(flag+0.5)*mid),m_sum/m_num,m_countD,m_countG,m_numD,m_numG);
	else printf("%s %d %d %d %d %d\n",strftime("%H:%M:%S",m_time+(flag+0.5)*mid),0,0,0,0,0);

}

function getCase()
{
	result=0;
	choice='''$1''';
	if(choice==1){
		if($14 == ""){
			result=1;
		}
	}
	else if(choice==2){
	#	printf(" (%s) ",length($9));
		if(length($9)>30){
			result=1;
		}
	}

}

function init()
{	m_sum=0;
	m_num=0;
	m_countD=0;
	m_numD=0;
	m_numG=0;
	m_countG=0;
	delete userGift;
	delete userDanmu;

}
BEGIN{
	m_time='''$m_time''';
	flag=0;
	mid=300;
	printf("时段	平均人数	评论人数	打赏人数	评论人次	打赏人次\n");
}	


{
#	if(m_time+(flag+0.5)*mid<$3){
	while(m_time+(flag+0.5)*mid<$3){
		outPut();
		init();
		flag++;
	}
	getOnline();
	getCase();
	if(result == 1)
		rmRepeatG();
	else
		rmRepeatD();
}

END{

}'
else
	echo "No such file or data."
fi
