#Using cat

## 1 Nối file

Đây là mục đích chính của cat là lấy thông tin từ file1, file2 và file3 rồi ghi vào file_all .

[root@localhost ~]# cat file1
test1
[root@localhost ~]# cat file2
test2
[root@localhost ~]# cat file3
test3
[root@localhost ~]# cat file1 file2 file3 > file_all
[root@localhost ~]# cat file_all
test1
test2
test3

``cat`` cũng có thể được sử dụng tương tự để nối các tệp như một phần của đường dẫn:

[root@localhost ~]# cat file1 file2 file3 | grep tuannguyen
tuannguyen

## 2 Hiển thị ra nội dung của một file

In ra nội dung của tệp
```
[root@localhost ~]# cat test1.txt
tuannguyen

```
Để chuyển nội dung của tệp làm input cho một lệnh. Câu lệnh sau đây có chức năng như lệnh ```cat```:

```

tr A-Z a-z <test1.txt
```

Trong trường hợp nội dung cần được liệt kê ngược so với phần cuối của nó, lệnh tac ngược lại với cat liệt kê từ dòng cuối cùng

```
tac test1.txt
```

Nếu bạn muốn hiển thị nội dung có in số dòng:

```
[root@localhost ~]# cat -n test1.txt
     1 tuannguyen
```

## 3.Ghi vào tệp

Nó sẽ cho phép bạn viết văn bản và sẽ được lưu trong một tệp có tên tệp.
```
[root@localhost ~]# cat > test1.txt
tuannguyen1

[root@localhost ~]# cat file1
tuannguyen1

```

[root@localhost ~]# cat >> test1.txt
tuannguyen2
[root@localhost ~]# cat file1
tuannguyen1
tuanguyen2

- ``>`` Bash sẽ xóa hết dữ liệu có trong file và viết dữ liệu mà bạn nhập vào file

- ``>>`` Bash sẽ ghi tiếp dữ liệu mà bạn nhập vào file

- Khi bạn muốn kết thúc thực hiện tổ hợp phím ``Ctrl + d``

## 5. Đọc từ đầu vào chuẩn

```
[root@localhost ~]# printf "first line\nSecond line\n" | cat -n
     1  first line
     2  Second line
```

Lệnh echo trước dấu (|) để xuất ra hai dòng. Lệnh cat sau dấu (|) hoạt động trên đầu ra để thêm số dòng.

## 6. Hiển thị số dòng với đầu ra

Sử dụng cờ ``--number`` để in số dòng trước mỗi dòng. Ngoài ra,`` -n`` cũng làm điều tương tự.

Để bỏ qua các dòng trống khi đếm dòng, hãy sử dụng ``--number-nonblank`` hoặc đơn giản là `` -b`` .
```
[root@localhost ~]# cat -b test2.txt
     1  nguyen
     2  tuan

     3  t
```

