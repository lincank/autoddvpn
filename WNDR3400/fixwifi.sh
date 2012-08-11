#!/bin/sh
n=1 
while [ $n -le 58 ] 
do 
echo "Iteration #$n" `date` 
sh /jffs/wifi.sh 
sleep 1 
n=$(( n+1 )) # increments $n 
done 