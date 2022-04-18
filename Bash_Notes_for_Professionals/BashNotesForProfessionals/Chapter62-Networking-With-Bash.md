# Chapter 62: Networking With Bash - Kết nối mạng với  Bash

Bash thường được sử dụng phổ biến trong việc quản lý và bảo trì các máy chủ và cụm máy chủ. Thông tin liên quanđến các lệnh điển hình được sử dụng bởi các hoạt động mạng, khi nào thì sử dụng lệnh nào cho mục đích nào vàcác ví dụ / mẫu về các ứng dụng độc đáo và / hoặc thú vị của nó nên được bao gồm

## 62.1: Các lệnh kết nối mạng

```
ifconfig
```

Lệnh trên sẽ hiển thị tất cả giao diện đang hoạt động của máy đồng thời cung cấp thông tin về

1. Địa chỉ IP được gán cho giao diện
2. Địa chỉ MAC của giao diện
3. Địa chỉ phát sóng
4. Truyền và nhận byte

Một số ví dụ

```
ifconfig -a
```

Lệnh trên cũng hiển thị giao diện vô hiệu hóa

```
ifconfig eth0
```

Lệnh trên sẽ chỉ hiển thị giao diện eth0

```
ifconfig eth0 192.168.1.100 netmask 255.255.255.0
```

Lệnh trên sẽ gán IP tĩnh cho giao diện eth0

```
ifup eth0
```

Lệnh trên sẽ kích hoạt giao diện eth0

```
ifdown eth0
```

Lệnh dưới đây sẽ vô hiệu hóa giao diện eth0

```
ping
```

Lệnh trên (Packet Internet Grouper) là để kiểm tra kết nối giữa hai nút

```
ping -c2 8.8.8.8
```
Lệnh trên sẽ ping hoặc kiểm tra khả năng kết nối với máy chủ google trong 2 giây.

```
traceroute
```

Lệnh trên được sử dụng để khắc phục sự cố để tìm ra số bước nhảy đã thực hiện để đến đích.

```
netstat
```

Lệnh trên (Thống kê mạng) cung cấp thông tin kết nối và trạng thái của chúng

```
dig www.google.com
```

Lệnh trên (trình thu thập thông tin miền) truy vấn thông tin liên quan đến DNS

```
nslookup www.google.com
```

Lệnh trên truy vấn DNS và tìm ra địa chỉ IP của tên trang web tương ứng.

```
route
```

Lệnh trên được sử dụng để kiểm tra thông tin tuyến đường Netwrok. Về cơ bản, nó hiển thị cho bạn bảng định tuyến

```
router add default gw 192.168.1.1 eth0
```

Lệnh trên sẽ thêm tuyến mặc định của mạng của Giao diện eth0 thành 192.168.1.1 trong bảng định tuyến.

```
route del default
```

Lệnh trên sẽ xóa tuyến đường mặc định khỏi bảng định tuyến