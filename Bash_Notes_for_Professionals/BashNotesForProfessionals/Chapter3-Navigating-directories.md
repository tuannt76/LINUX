
# Navigating directories – Điều hướng thư mục

## 1 Absolute vs relative directories
Absolute vs relative directories – Thư mục tuyệt đối và Thư mục tương đối. Để thay đổi thành một thư mục được chỉ định tuyệt đối, hãy sử dụng toàn bộ tên, bắt đầu bằng dấu gạch chéo /:

cd /home/username/dir/tuan

ví dụ:
```
[root@localhost tuannguyen]# pwd
/home/tuannguyen
[root@localhost tuannguyen]# cd project
[root@localhost project]# pwd
/home/tuannguyen/project
```

Nếu bạn muốn thay đổi một thư mục gần hiện tại của bạn, bạn có thể chỉ định một vị trí tương đối. Mà hiện tại bạn đang đứng tại Techonogy bạn sử dụng bí danh .. để thực hiện di chuyển về thư mục Picture thay vì phải sử dụng đường dẫn tuyệt đối, ví dụ:

```
[root@localhost project]# pwd
/home/tuannguyen/project
[root@localhost project]# cd ..
[root@localhost tuannguyen]# pwd
/home/tuannguyen
```



## 2 Thay đổi đến thư sử dụng cuối cùng

Đối với trình shell hiện tại, điều này sẽ đưa bạn đến thư mục trước đó mà bạn đã ở đó, bất kể nó ở đâu

[root@localhost tuannguyen]# cd -
/home/tuannguyen/project
[root@localhost project]#

## 3 Thay đổi đến thư mục chính

Thư mục mặc định làm việc là thường là thư mục /root/ đối với user root:

```
[root@localhost ~]# echo $HOME
/root
```

Thư mục /home/username/ đối với user hiện tại đang thực thi.

```
[tuannguyen@localhost ~]$ echo $HOME
/home/tuannguyen
```

## 4 Thay đổi thư mục của script
Có hai loại tệp bash:

System tool- Các công cụ hệ thống hoạt động từ thư mục làm việc hiện tại
Project tool công cụ dự án sửa đổi tệp liên quan đến vị trí của chúng trong hệ thống tệp.
Đối với Project tool sẽ hữu ích khi thay đổi thành thư mục nơi script được lưu trữ điều này có thể được thực hiện với lệnh sau:
```
cd "$(dirname "$(readlink -f "$0")")"
```
```
[root@localhost ~]# cd /etc
[root@localhost etc]# cd "$(dirname "$(readlink -f "/root/hello.sh")")"
[root@localhost ~]# pwd
/root
[root@localhost ~]# ls
anaconda-ks.cfg  hello.sh
```
