#!/bin/bash

n=$1

res=1
for i in $(seq 1 $n) 
do
        #res=$(( $res * $i ))
        res=$(echo "${res}*${i}" | bc )
done

echo $res

