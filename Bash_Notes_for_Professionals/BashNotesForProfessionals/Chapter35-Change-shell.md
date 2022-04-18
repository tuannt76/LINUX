# Chapter 35: Change shell

## 35.1: Find the current shell - Tìm shell hiện tại

Có một số cách để xác định shell hiện tại

```
echo $0
ps -p $$
echo $SHELL
```

## 35.2: List available shells - Liệt kê các trình bao có sẵn

Để liệt kê các shell đăng nhập có sẵn:

```
cat /etc/shells
```

Thí dụ:

```
$ cat /etc/shells
# /etc/shells: valid login shells
/bin/sh
/bin/dash
/bin/bash
/bin/rbash
```

## 35.3: Change the shell - Thay đổi trình shell
Để thay đổi bash hiện tại, hãy chạy các lệnh này

```
export SHELL=/bin/bash
exec /bin/bash
```

để thay đổi bash mở khi khởi động, hãy chỉnh sửa .profile và thêm những dòng đó