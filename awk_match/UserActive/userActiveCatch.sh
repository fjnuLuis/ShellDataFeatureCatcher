#!/bin/bash

#Time=`head -n1 pd_danmu_27337.csv | cut -d ',' -f 3 |  awk '{aa=strftime("%Y %m %d 00 00 00",$0);print aa}' |
#	awk '{aa=mktime($0);print aa}'`
#Time=$(($Time+86400))
#echo $Time

Time=1483891200
endTime=1485360000


awk '
function init(){
	Time='''$Time''';
	endTime='''$endTime''';
	Time += 86400;
	count=1;

}

function train(value){
	# ID 等级 平台 弹幕 礼物 弹幕 礼物...
	split(value,value_tmp,",");
	if(value_tmp[3]>Time){
		Time += 86400;
		count++;
	}
	if(length(value_tmp[9])>20){
	#礼物
		DATA[value_tmp[7],1]=value_tmp[7];
		DATA[value_tmp[7],count*2+3]+=value_tmp[11];
		
	}
	else{
	#弹幕
		DATA[value_tmp[7],1]=value_tmp[7];
		DATA[value_tmp[7],2]=value_tmp[8];
		DATA[value_tmp[7],3]=value_tmp[9];
		DATA[value_tmp[7],count*2+2]++;
	}
			



}



BEGIN{
	init();
	cmd="cat pd* | sort -g -k3 -t',' > tmp";
	system(cmd);
	while(getline c<"./tmp" ){
		train(c);
	#	printf("%d ",count);
	}
	
}


END{
	for(item in DATA){
		split(item,idx,SUBSEP);
		for(i=1;i<count*2+3;i++)
			if(DATA[idx[1],i] == "")
				printf("0,");
			else
				printf("%s,",DATA[idx[1],i]);
		if(DATA[idx[1],i] == "")
			printf("0\n");
		else
			printf("%s\n",DATA[idx[1],i]);
	}		
}
' target | sort -g -t ' ' -u -k1 > result

