! /bin/bash

thoigian=$(date +"%H%M%S-%d%m%Y")

DBname=test1

dbuser=root

pass=Welcome123+

cd /root/backup

mysqldump -u $dbuser -p$pass $DBname > $DBname-$thoigian.sql



