# Using File Management Commands

### Naming and Listing Files

#### Displaying Filenames with the ls Command

ls là lệnh liệt kê thông tin các tệp và thư mục. Liệt kê các quyền,tên của user group sở hữu, ngày giờ sửa đổi của tệp/thư mục. Được sử dụng phổ biến và thường xuyên trong linux.

Cú pháp: 

`ls [Tùy chọn] [tập tin]`

**Các tùy chọn**

`-a, --all` :  liệt kê tất cả các file và thư mục 

```
[root@localhost ~]# ls -all
total 36
dr-xr-x---.  3 root root  235 Nov  7 21:19 .
dr-xr-xr-x. 17 root root  224 Nov  4 07:55 ..
-rw-------.  1 root root 1585 Nov  4 07:56 anaconda-ks.cfg
-rw-------.  1 root root  293 Nov  7 21:19 .bash_history
-rw-r--r--.  1 root root   18 Dec 29  2013 .bash_logout
-rw-r--r--.  1 root root  176 Dec 29  2013 .bash_profile
-rw-r--r--.  1 root root  176 Dec 29  2013 .bashrc
-rw-r--r--.  1 root root  100 Dec 29  2013 .cshrc
-rw-------.  1 root root    0 Nov  7 17:25 .mysql_history
drwxr-----.  3 root root   19 Nov  7 16:15 .pki
-rw-r--r--.  1 root root  129 Dec 29  2013 .tcshrc
-rw-r--r--.  1 root root   23 Nov  4 20:34 test1.txt
-rw-r--r--.  1 root root    0 Nov  4 20:34 test2.txt
-rw-r--r--.  1 root root    0 Nov  4 20:34 test3.txt
-rwxr-xr-x.  1 root root 3376 Nov  7 21:11 test.sh
```

`ls -x` : sắp xếp đầu ra tệp theo thứ tự bảng chữ cái

```
[root@localhost ~]# ls -x
anaconda-ks.cfg  test1.txt  test2.txt  test3.txt  test.sh
```

`ls -t` : sắp xếp tệp mới sửa đổi theo thời gian

```

[root@localhost ~]# ls -t
test.sh  test1.txt  test3.txt  test2.txt  anaconda-ks.cfg
```

`ls -l` : hiển thị các file và thư mục, các phân quyền, kich thước( file/forder), ngày sửa đổi, chủ sở hữu, tên file hoặc thư mục

```
[root@localhost ~]# ls -l
total 12
-rw-------. 1 root root 1585 Nov  4 07:56 anaconda-ks.cfg
-rw-r--r--. 1 root root   23 Nov  4 20:34 test1.txt
-rw-r--r--. 1 root root    0 Nov  4 20:34 test2.txt
-rw-r--r--. 1 root root    0 Nov  4 20:34 test3.txt
-rwxr-xr-x. 1 root root 3376 Nov  7 21:11 test.sh
```

`ls -F` : chỉ ra loại tệp:  

- `@` : là 1 symbol link     
- `(*)` : là 1 thực thi    
-  `|` : chỉ ra 1 đường ống được đặt tên    
-  `/` : là 1 thư mục        


```
adm/  cache/  crash/  db/  empty/  games/  gopher/  kerberos/  lib/  local/  lock@  log/  mail@  nis/  opt/  preserve/  run@  spool/  tmp/  www/  yp/
```

`ls --hide=*.rpm` : ẩn 1 loại tệp cụ thể ở đầu ra , cụ thể ở đây là mbr

```
[root@localhost ~]# ls
anaconda-ks.cfg  test1.txt  test2.txt  test3.txt  test.sh
[root@localhost ~]# ls --hide=*.prm
anaconda-ks.cfg  test1.txt  test2.txt  test3.txt  test.sh

```

`ls -l -author` : hiển thị tên tác giả mỗi tập tin

```
[root@localhost ~]# ls -l -author
total 36K
-rw-r--r--.  1 root  129 Dec 29  2013 .tcshrc
-rw-r--r--.  1 root  100 Dec 29  2013 .cshrc
-rw-r--r--.  1 root   18 Dec 29  2013 .bash_logout
-rw-------.  1 root 1.6K Nov  4 07:56 anaconda-ks.cfg
-rw-r--r--.  1 root    0 Nov  4 20:34 test2.txt
-rw-r--r--.  1 root    0 Nov  4 20:34 test3.txt
-rw-r--r--.  1 root   23 Nov  4 20:34 test1.txt
drwxr-----.  3 root   19 Nov  7 16:15 .pki
-rw-------.  1 root    0 Nov  7 17:25 .mysql_history
-rwxr-xr-x.  1 root 3.3K Nov  7 21:11 test.sh
dr-xr-xr-x. 17 root  224 Nov 18 05:54 ..
-rw-r--r--.  1 root  176 Nov 18 17:54 .bash_profile
-rw-r--r--.  1 root  176 Nov 18 17:54 .bashrc
-rw-------.  1 root  293 Nov 18 17:54 .bash_history
dr-xr-x---.  3 root  235 Nov 18 17:54 .
```

`ls -lt` : hiển thị các file và thư mục, các phân quyền, chủ sở hữu, kích thước(file/forder), sắp xếp theo thứ tự ngày giờ sửa đổi

```
[root@localhost ~]# ls -lt
total 12
-rwxr-xr-x. 1 root root 3376 Nov  7 21:11 test.sh
-rw-r--r--. 1 root root   23 Nov  4 20:34 test1.txt
-rw-r--r--. 1 root root    0 Nov  4 20:34 test3.txt
-rw-r--r--. 1 root root    0 Nov  4 20:34 test2.txt
-rw-------. 1 root root 1585 Nov  4 07:56 anaconda-ks.cfg
```

#### Creating and Naming Files

Lệnh touch cho phép tạo các file trống 1 cách nhanh chóng. 

```
[root@localhost ~]# touch test1.txt
[root@localhost ~]# ls
anaconda-ks.cfg  test1.txt  test2.txt  test3.txt  test.sh
```

Để tạo cùng lúc nhiều file trống:

```
[root@localhost ~]# touch test 2 test3 test4
[root@localhost ~]# ls
2                test       test2.txt  test3.txt  test.sh
anaconda-ks.cfg  test1.txt  test3      test4
```

- Sử dụng lệnh file để xác định loại tệp tin

```
[root@localhost ~]# file anaconda-ks.cfg
anaconda-ks.cfg: ASCII text
[root@localhost ~]# file aliases.db
aliases.db: Berkeley DB (Hash, version 9, native byte-order)
[root@localhost ~]# file cron.deny
cron.deny: empty
```

### Exploring Wildcard Expansion Rules

Có thể sử dụng ls kèm với các ký tự mở rộng như sau: 

```
[root@localhost ~]# ls
2                test       test2.txt  test3.txt  test.sh
anaconda-ks.cfg  test1.txt  test3      test4
```

```
[root@localhost ~]# ls t*
test  test1.txt  test2.txt  test3  test3.txt  test4  test.sh  tuan

```

### Understanding the File Commands

#### Creating Directories

Để tạo các thư mục sử dụng mkdir

```
[root@localhost ~]# mkdir tuannguyen
```

#### Copying Files and Directories

`cp` command dùng để sao chép tệp tin và thư mục, khi sao chép cp đồng thời cũng có thể tạo tệp mới.

Để sao chép 1 thư mục đồng thời tạo thư mục cần sao chép :

```
[root@localhost ~]# cat tuan1
[root@localhost ~]# cp tuan tuan1
cp: overwrite ‘tuan1’? yes
[root@localhost ~]# cat tuan1
nguyen ngoc tuan
kma
mi2
```

Nếu copy vào 1 file đã có dữ liệu, hệ thống sẽ đưa ra câu hỏi có muốn ghi đè dữ liệu hay không.

```
[root@localhost ~]# cp tuan tuan1
cp: overwrite ‘tuan1’? no
```

Để sao chép 1 thư mục, ta sử dụng tùy chọn -R.

```
[root@localhost ~]# cp -R /root/tuannguyen/tuan1/test1.txt /root/tuannguyen/tuan2
[root@localhost ~]# ls /root/tuannguyen/tuan2
test1.txt

```
```
[root@localhost ~]# pwd
/root
[root@localhost ~]# ls
2  anaconda-ks.cfg  test.sh  tuannguyen
```

### Moving/Renaming Files and Directories

- Sử dụng mv để đổi tên

```

[root@localhost ~]# mv /root/tuannguyen/tuan tuanRV
```

- Sử dụng để di chuyển file hoặc thư mục đến 1 vị trí khác:

```
mv [file_hoặc_thư_mục_cần_di_chuyển] [Thư_mục_đích]
```


### Deleting Files and Directories

Để xóa 1 file hoặc thư mục ta sử dụng lệnh `rm`.

Sử dụng tùy chọn -f để xóa không cần hỏi lại.

```
[root@localhost ~]# rm -f tuan1.txt
```

Xóa file hoặc thư mục bất kể lý do

```
[root@localhost ~]# rm -rf /root/tuannguyen/tuan/tuan1.txt
```

Xóa cùng lúc nhiều file hoặc thư mục 

```
[root@localhost ~]# rm -rf filetime tuan/
```

### Compressing File Commands

Có nhiều công cụ để nén và giải nén file như:

**gzip**

Tạo 1 file nén đuôi `gz`:

```
gzip tuan.txt
```

Giải nén 1 file đuôi `gz`:

```
gzip -d tuan1.txt.gz
```

**tar**

Nén 1 thư mục:

```
tar -zcf folder.tar.gz folder
```
Giải nén thư mục: 
```
tar -zxvf file.tar.gz
```

**zip**

Nén thư mục: 

```
zip -r folder.zip folder
```

Giải nén thư mục: 

```
unzip file.zip
```

### Duplicating with dd

Sử dụng `dd` command để sao lưu gần như toàn bộ đĩa cứng với đĩa cứng khác. 

để sao lưu toàn bộ đĩa cứng: 

```
dd if = /dev/sda of = /dev/sdb
```

hoặc có thể sử dụng lệnh dd để tạo file iso:

```
dd if = /dev/cdrom of = tgsservice.iso bs = 2048
```

### Managing Links

Để tạo các liên kết trong linux ta sử dụng lệnh `ln`:

#### Liên kết mềm (Liên kết tượng trưng): 

Bạn có thể tạo liên kết đến tệp và thư mục và bạn có thể tạo liên kết (phím tắt) trên phân vùng khác nhau và với số inode khác với bản gốc.

Nếu thư mục gốc bị xóa, liên kết sẽ mất. nếu thư mục liên kết bị xóa, thư mục gốc vẫn tồn tại. 

```
ln -s test test-file
```

#### Liên kết cứng 

Liên kết tắt cứng sẽ tạo ra 1 file vật lí cùng trỏ đến mục nhập inode của file vật lí gốc. 2 fle này hoàn toàn đồng đẳng với nhau. Nếu xóa file gốc thì dữ liệu hoàn toàn không bị mất, nó chỉ mất khi ko còn liên kết nào đến inode nữa.

```
ln file_test1 file_test2
```












