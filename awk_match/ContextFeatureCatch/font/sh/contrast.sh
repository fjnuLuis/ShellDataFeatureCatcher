#!/bin/bash
# Name: contrast.sh
# Description: 
# Author: Lin
# Version: 0.0.1
# Datetime: 2017-01-11 19:26:50
# Usage: contrast.sh

cat c.txt | awk '
BEGIN{
	while(getline w<"s.txt")
	{
		word[w]=1;
	}
}

{
	if(word[$1] != 1)
		tmp[$1]=$1;
	


}

END{
	for(I in tmp)
		print I;
#	print;
}
'
