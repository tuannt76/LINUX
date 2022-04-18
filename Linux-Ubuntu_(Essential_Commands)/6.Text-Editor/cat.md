# cat 
### 1. Notes
```
cat file ...
```
Lệnh cat lấy một danh sách các tên tệp cho các đối số của nó.

Nó xuất nội dung của những tệp đó trực tiếp ra đầu ra tiêu chuẩn, theo mặc định, được dẫn đến màn hình.

### 2. Examples
* Viết nội dung của một tệp
```
[root@localhost ~]# cat tuannguyen.txt
tuan1
tuan2
tuannguyen
```
Bạn có thể sử dụng tùy chọn -n để in số dòng:
```
[root@localhost ~]# cat -n tuannguyen.txt
    1 tuan1
    2 tuan2
    3 tuannguyen
```
Viết nội dung của nhiều tệp
```
[root@localhost ~]# cat tuannguyen.txt file1
tuan1
tuan2
tuannguyen

ls: cannot access -: No such file or directory
```
Viết nội dung của nhiều tệp lần lượt ( enter EOF character ('^D') for each file)
```
[root@localhost ~]# cat tuannguyen.txt - file1
```
