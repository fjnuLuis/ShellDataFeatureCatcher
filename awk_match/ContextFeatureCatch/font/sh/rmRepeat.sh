#!/bin/bash
# Name: rmRepeat.sh
# Description: 
# Author: Lin
# Version: 0.0.1
# Datetime: 2017-01-09 11:25:13
# Usage: rmRepeat.sh

cat complex.txt | awk '
BEGIN{
	getline w<"./bak/simple.txt"
	num=split(w,tmp,"");
	for(i=1;i<=num;i++)
	{
		word_s[tmp[i]]=1;
	}
	print tmp[6];
}

{

#	if(word_s[$1] != 1){
#		print $0;

#	}




}


'



:<<!
echo 1 | awk '
BEGIN{
	i=1;
	while(getline w< "bak."){
		tmp[i]=w;
		i++;
		}
	print tmp[3];


}


{
#	num=split($0,tmp,"");
	num=i-1;
	count=1;
	for(i=1;i<=num;i++){	
		if(tmp[i] in a)
			continue;
		else{
			a[count]=tmp[i];
			count++;
		}

	}
	for(j=1;j<count;j++)
		print a[j];
		




}'> com.txt

!


