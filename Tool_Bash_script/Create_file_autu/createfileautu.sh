#!/bin/bash

echo " Tao file tu 1 den 100 "

for ((n=100; n>0; n--))

do

touch "tuan$n.txt"

echo $n >"tuan$n.txt"

date +"%H:%M:%S:%3N" >> "tuan$n.txt"

done
