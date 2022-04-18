# Chapter 32: getopts : smart positionalparameter parsing

Tham số|Chi tiết|
|---|---|
optstring|Các ký tự tùy chọn được nhận dạng
name|Sau đó đặt tên cho nơi lưu trữ tùy chọn đã phân tích cú pháp

## 32.1: pingnmap

```
#!/bin/bash
# Tên tập lệnh: pingnmap
# Tình huống: Quản trị viên hệ thống trong công ty X cảm thấy mệt mỏi với công việc đơn điệu# ping và nmapping, vì vậy anh ấy quyết định đơn giản hóa công việc bằng cách sử dụng script.
# Nhiệm vụ anh ấy muốn đạt được là
# 1. Ping - với số lượng tối đa là 5 - địa chỉ IP / miền đã cho. VÀ / HOẶC
# 2. Kiểm tra xem một cổng cụ thể có đang mở với một miền / địa chỉ IP nhất định hay không.
# Và getopts là để giải cứu cô ấy.
# Tổng quan ngắn gọn về các tùy chọn
# n: dành cho nmap
# t: có nghĩa là ping
# i: Tùy chọn để nhập địa chỉ IP
# p: Tùy chọn vào cổng
# v: Tùy chọn để tải phiên bản script

while getopts ':nti:p:v' opt
#putting: trong beginnnig loại bỏ các lỗi đối với các tùy chọn không hợp lệ
do
case "$opt" in
    'i')ip="${OPTARG}"
        ;;
    'p')port="${OPTARG}"
        ;;
    'n')nmap_yes=1;
        ;;
    't')ping_yes=1;
        ;;
    'v')echo "pingnmap version 1.0.0"
        ;;
    *) echo "Invalid option $opt"
        echo "Usage : "
        echo "pingmap -[n|t[i|p]|v]"
        ;;
esac
done
if [ ! -z "$nmap_yes" ] && [ "$nmap_yes" -eq "1" ]
then
    if [ ! -z "$ip" ] && [ ! -z "$port" ]
    then
        nmap -p "$port" "$ip"
    fi
fi

if [ ! -z "$ping_yes" ] && [ "$ping_yes" -eq "1" ]
then
    if [ ! -z "$ip" ]
    then
        ping -c 5 "$ip"
    fi
fi
shift $(( OPTIND - 1 )) # Xử lý các đối số bổ sung
if [ ! -z "$@" ]
then
    echo "Bogus arguments at the end : $@"
fi
```

Đầu ra

```
$ ./pingnmap -nt -i google.com -p 80

Starting Nmap 6.40 ( http://nmap.org ) at 2016-07-23 14:31 IST
Nmap scan report for google.com (216.58.197.78)
Host is up (0.034s latency).
rDNS record for 216.58.197.78: maa03s21-in-f14.1e100.net
PORT STATE SERVICE
80/tcp open http

Nmap done: 1 IP address (1 host up) scanned in 0.22 seconds
PING google.com (216.58.197.78) 56(84) bytes of data.
64 bytes from maa03s21-in-f14.1e100.net (216.58.197.78): icmp_seq=1 ttl=57 time=29.3 ms
64 bytes from maa03s21-in-f14.1e100.net (216.58.197.78): icmp_seq=2 ttl=57 time=30.9 ms
64 bytes from maa03s21-in-f14.1e100.net (216.58.197.78): icmp_seq=3 ttl=57 time=34.7 ms
64 bytes from maa03s21-in-f14.1e100.net (216.58.197.78): icmp_seq=4 ttl=57 time=39.6 ms
64 bytes from maa03s21-in-f14.1e100.net (216.58.197.78): icmp_seq=5 ttl=57 time=32.7 ms

--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4007ms
rtt min/avg/max/mdev = 29.342/33.481/39.631/3.576 ms
$ ./pingnmap -v
pingnmap version 1.0.0
$ ./pingnmap -h
Invalid option ?
Usage :
pingmap -[n|t[i|p]|v]
$ ./pingnmap -v
pingnmap version 1.0.0
$ ./pingnmap -h
Invalid option ?
Usage :
pingmap -[n|t[i|p]|v]
```