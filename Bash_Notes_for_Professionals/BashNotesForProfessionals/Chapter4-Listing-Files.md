# Listing Files

## 1 Liệt kê file ở định dạng danh sách dài

Tùy chọn -l của lệnh ls hiển thị nội dung của thư mục cụ thể ở định dạng danh sách dài. Nếu không có đối số của thư mục chỉ định chỉ nó sẽ hiển thị nội dung của thư mục hiện tại.

```
[root@localhost ~]# ls -l /root
[root@localhost ~]# ls -l /var
total 8
drwxr-xr-x.  2 root root    6 Apr 11  2018 adm
drwxr-xr-x.  5 root root   44 Oct  7 11:51 cache
drwxr-xr-x.  2 root root    6 Jun  9 23:09 crash
```
Dòng đầu tiên total cho biết tông kích tuhuoncwscuar tất cả các tệp trong thư mục được liệu kê. Sau đó hiển thị 8 cột thông tin:

|Số cột|Ví dụ|Miêu tả|
|---|---|---|
|1.1|d|Loại của tệp|
|1.2|rwxr-xr-x|Chuỗi biểu thị quyền hạn cho user group own(permission)|
|2|1 & 2|Các liên kết (hiểu nôm na với window là có shortcut được ở đâu đó)|
|3|username(huydv,root)|Owner name|
|4|username(huydv,root)|Owner group|
|5|21 (dir Customer)|Kích cỡ của tệp đơn vị bytes|
|6|Jun 7 10:07|Thời gian sửa đổi cuối cùng|
|7|info.txt or Customer|File name|

Ở phần 1 loại của tệp: có thể là một trong bất kỳ ký tự nào sau đây:

|Character|File type|
|---|---|
|-|Tệp thông thường|
|b|Chặn các tệp đặc biệt|
|c|Tệp ký tự đặc biệt|
|C|Tệp hiệu xuất cao|
|d|Thư mục|
|D|Door(tệp đặc biệt chỉ có trong Solaris 2.5+)|
|l|Liên kết tượng trưng- Symbolic link|
|M|Off-line (đã được chuyển đi)|
|n|Tệp đặc biệt của mạng(HP-UX)|
|p|FIFO(name pipe)|
|P|	port (tệp đặc biệt chỉ có trong Solaris 10+)|
|s|	Socket|
|?|Một số loại tệp khác|


 liệt kê tối đa mười tệp được sửa đổi gần đây nhất trong thư mục hiện tại, sử dụng định dạng danh sách dài (-l) và được sắp xếp theo thời gian (-t).

## 2 Liệt kê mười tệp được sửa đổi gần đây nhất)

```
ls -lt | head
```

Output

```
[root@localhost etc]# ls -lt | head
total 1028
-rw-r--r--.  1 root root     74 Oct  8 15:03 resolv.conf
----------.  1 root root    686 Oct  7 20:36 shadow
-rw-r--r--.  1 root root     18 Oct  7 20:36 subgid
-rw-r--r--.  1 root root     18 Oct  7 20:36 subuid
----------.  1 root root    354 Oct  7 20:36 gshadow
-rw-r--r--.  1 root root    448 Oct  7 20:36 group
-rw-r--r--.  1 root root    837 Oct  7 20:36 passwd
-rw-r--r--.  1 root root  18629 Oct  7 12:23 ld.so.cache
drwxr-xr-x.  3 root root     54 Oct  7 12:23 udev
```

# 3.Liệt kê tất cả các tệp bao gồm các tệp chấm

Dotfile là một tệp có tên bắt đầu bằng dấu chấm (.). Chúng thường được ẩn bởi ls và không được liệt kê trừ khi được yêu cầu.

[root@localhost ~]# ls
anaconda-ks.cfg  hello.sh
Tùy chọn -a hoặc --all sẽ liệt kê tất cả các tệp, bao gồm các tệp dotfiles

[root@localhost ~]# ls -a
.  ..  anaconda-ks.cfg  .bash_history  .bash_logout  .bash_profile  .bashrc  .cshrc  hello.sh  .tcshrc
Tùy chọn -A hoặc –almost-all sẽ liệt kê tất cả các loại tệp, bao gồm các tệp Dotfiles, nhưng không liệt kê implied (.) và (..).

[root@localhost ~]# ls -A
anaconda-ks.cfg  .bash_history  .bash_logout  .bash_profile  .bashrc  .cshrc  hello.sh  .tcshrc

# 4.Liệt kê các tệp tin mà không cần sử dụng ``ls``

hiển thị các tệp và thư mục có trong thư mục hiện tại

```
[root@localhost ~]# printf "%s\n" *
anaconda-ks.cfg
tuannguyen
hello.sh
```

chỉ hiển thị các thư mục trong thư mục hiện tại

```
[root@localhost ~]# printf "%s\n" */
Tuannguyen/
```

Liệt kê file có đuôi txt

```
[root@localhost ~]# printf "%s\n" *.txt
test1.txt
```

Liệt kê các file có đuôi txt,md,conf, nếu không có file thì dấu * sẽ được hiển

```
[root@localhost ~]# printf "%s\n" *.{txt,md,conf}
test1.txt
*.md
*.conf
```

