#! /bin/bash
echo "Nhap url trang web:"
read url

echo "Nhap so lan tai lai trang nay:"
read solan

for ((i=0;i<$solan;i++));do
	HTTP_CODE=$(curl --write-out "%{http_code}\n" $url --output output.txt --silent)
	echo "Lan $((i+1)) : $HTTP_CODE" 
done