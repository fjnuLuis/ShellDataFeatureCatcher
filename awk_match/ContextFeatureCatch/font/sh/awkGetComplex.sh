#!/bin/bash
# Name: awkGetComplex.sh
# Description: 
# Author: Lin
# Version: 0.0.1
# Datetime: 2017-01-08 23:34:55
# Usage: awkGetComplex.sh

cat c_sim.txt | awk '
BEGIN{
	getline w< "bak.complex";
	all_num=split(w,all_tmp,"");
#	printf("%d_%s\n",all_num,all_tmp[1]);
	for(j=1;j<=all_num;j++){
		word[all_tmp[j]]=1;
#		printf("%d",word[all_tmp[j]]);
	}

}


{
	num=split($0,tmp,"");
#	print num
	k=0;
	for(i=3;i<num;i++){
		cmd="[ \""tmp[i]"\" == \""all_tmp[i-1]"\" ]";
		res=system(cmd);
		if(res == 1){
#			print tmp[i];
			printf("%s",tmp[i]);
			k++;
		}

#		printf("\t%s_%s",all_tmp[i-1],tmp[i]);
#		if(word[tmp[i]] != 1)
#			print tmp[i];

		
	}

#	printf("%d_%d_%s_%s\n",word[tmp[1]],word[all_tmp[1]],tmp[1],all_tmp[1]);

}
END{ 
# printf("\n");
}' > complex.txt
