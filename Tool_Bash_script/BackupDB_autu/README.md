# 1.Tính năng Script 

 Đoạn script sẽ thực hiện công việc tự động Backup Database (MariaDB) hàng ngày trên Linux Server sử dụng ``Crontab``

# 2. Các bước 


**Bước 1** : Cài đặt Crontab:

  Sử dụng lệnh:

```
yum install cronie
```

  Start crontab và tự động chạy mỗi khi khởi động:
```
systemctl start crond
systemctl enable crond
```

**Bước 2**:

  - Tạo hoặc chỉnh sửa file crontab
  ```
  crontab -e
  ```
  - Hiển thị file crontab
  ```
  crontab -l
  ```
  - xoá file crontab
  ```
  crontab -r
  ```
- Cấu hình crontab cho user:
  - Đăng nhập vào user cần tạo:
  - Nhập lệnh : `crontab -e`
    ```
    su user
    crontab -e
    ```

  - Lưu lại
  - Sau khi thiết lập file crontab cho user sẽ được tạo ra ở folder: `/var/spool/cron`


  **Bước 3** : cd tới tệp mà bạn muốn lưu script va touch 1 file script backup DB 

	ex:
 ```
[root@localhost ~]# cd /home
[root@localhost home]# touch backupscript.sh

```
**Bước 4** : Sửa file cấu hình và paste dòng lệnh ở file backupscript.sh 

```
[root@localhost home]# vi backupscript.sh

#! /bin/bash

thoigian=$(date +"%H%M%S-%d%m%Y")
DBname=test1
dbuser=root
pass=Welcome123+


cd /root/backup
mysqldump -u $dbuser -p$pass $DBname > $DBname-$thoigian.sql

```

ấn ``i`` để có thể sửa cấu hình file

ấn ``esc`` để có thể thoát khỏi sửa file

ấn ``:wq`` để lưu và thoát

``/backup`` là thư mục lưu trữ các bản backup


``$TIME`` là biến sử dụng để ghi thời gian tạo file backup

``$DBNAME`` là tên của Database

``$DBUSER`` là tên của User Mariadb Database

``$PASSWD`` là mật khẩu của $DBUSER

**Bước 5** : Phân quyền cho file để có thể chạy

  sử dụng lệnh

ex: 
```
chmod +x /scripts/backupscript.sh
```
**Bước 6**: chạy script bằng lệnh sau :


```
[root@tuannguyen ~]# crotab -e
```

 Nhập lệnh và thời gian thực thi
    ```
    00 03 * * * /Home/backupscript.sh
    ```



 **File backupscript.sh sẽ được tự động chạy vào lúc 3h sáng hàng ngày**
