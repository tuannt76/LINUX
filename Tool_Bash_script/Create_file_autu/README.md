# 1.Tính năng Script 

 + Đoạn script sẽ tự động tạo tệp từ 1 đến 100 trên Centos7
 + Hiển thị thời gian tạo tệp đến mili giây
 + Số thứ tự

# 2. Các bước 

 - Bước 1: cd tới tệp mà bạn muốn lưu script

	ex:
 ```
[root@localhost ~]# cd /home
[root@localhost home]# touch createfile.sh

```
- Bước 2: Sửa file cấu hình và paste dòng lệnh ở file Createfileautu.sh 

```
[root@localhost home]# vi createfile.sh

#!/bin/bash

echo " Tao file tu 1 den 100 "

for ((n=100; n>0; n--))

do

touch "tuan$n.txt"

echo $n >"tuan$n.txt"

date +"%H:%M:%S:%3N" >> "tuan$n.txt"

done
```

ấn ``i`` để có thể sửa cấu hình file
ấn ``esc` để có thể thoát khỏi sửa file
ấn ``:wq`` để lưu và thoát

- Bước 3: phân quyền cho file để có thể chạy
  sử dụng lệnh

ex: 
```
chmod +x /scripts/createfileautu.sh
```
- Bước 4: chạy script bằng lệnh sau :

ex:

```
cd /home
bash ceratefileautu.sh
```
- Bước 5: kết quả

```
ls
```

