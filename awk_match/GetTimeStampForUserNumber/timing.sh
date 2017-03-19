#!/bin/bash
B=1
until [ $B -eq 0 ] 
do 
A=`date "+%M"`
let B=$A%5 &> /dev/null
done


while [ 1 -eq 1 ]
do
./getHtml.sh lol &
./getHtml.sh yz &
sleep 5m
done
