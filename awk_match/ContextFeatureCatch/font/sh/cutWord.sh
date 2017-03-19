#!/bin/bash
# Name: cutWord.sh
# Description: 
# Author: Lin
# Version: 0.0.1
# Datetime: 2017-01-11 10:58:01
# Usage: cutWord.sh

cat zkhj.txt | awk '
BEGIN{
#	count=1;



}



{
	num=split($0,tmp,"");
	for(i=1;i<=num;i++)
	{
		if(tmp[i] in word)
			continue;
		else{
			word[tmp[i]]=tmp[i];
	#		count++;
		}

	}

}

END{
	for(I in word)
		print I;



}
'
