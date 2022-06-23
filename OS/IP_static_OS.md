# Cài OS 


## 1.THIẾT LẬP ĐỊA CHỈ IP TĨNH TRÊN CENTOS 7 64BITS 
### 1. Cấu hình IP tĩnh bằng NMCLI
nmcli là viết tắt của Network Manager Command Line Interface.
Đó là một phần của NetworkManager quản lý các network subsystem.nmcli là một cách thức để tương tác với NetworkManager thông qua các dòng lệnh.


 Hiển thị các thiết bị mạng sẵn có

Câu lệnh:

```
nmcli device
```

Kết quả:
![Imgur](https://i.imgur.com/mopMfUN.png)

Kiểm tra mạng cần cài đặt :
![Imgur](https://i.imgur.com/hCHtBe3.png)

Thông số cần cài đặt ip tĩnh :

```
IP address 192.168.76.134
Subnet mask 255.255.255.0
Gateway 192.168.76.2
DNS 8.8.8.8
```
Câu lệnh cấu hình sử dụng nmcli:

```
nmcli con mod ens33 ipv4.addresses 192.168.76.134/24
nmcli con mod ens33 ipv4.gateway 192.168.76.2
nmcli con mod ens33 ipv4.method manual
nmcli con mod ens33 ipv4.dns “8.8.8.8”
```
- Cấu hình:
- 
![Imgur](https://i.imgur.com/diUTu0j.png)

reboot lại máy, kiểm tra lại địa chỉ IP:
![Imgur](https://i.imgur.com/ycZ75oE.png)


### 2. Cấu hình IP tĩnh bằng sửa file 

Show network hiện tại  :

![Imgur](https://i.imgur.com/6PQlagh.png)


Thực hiện lệnh sau để vào và sửa file cấu hình :
```
vi /etc/sysconfig/network-scripts/ifcfg-ens37
```

![Imgur](https://i.imgur.com/5NiyIEJ.png)

Ấn i và tiến hành sửa file cấu hình :

![Imgur](https://i.imgur.com/FFIClbK.png)
Thông số cần cài đặt ip tĩnh :

```
IP address 192.168.76.200
Subnet mask 255.255.255.0
Gateway 192.168.76.2
DNS 8.8.8.8
```

Thêm và sửa vào file cấu hình như sau :
[Imgur](https://i.imgur.com/CpkEc2k.png)

lưu và thoát ``:wq``

Reset lại network và kiểm tra :

```
systemctl restart network
ip a
```

![Imgur](https://i.imgur.com/of3qO3z.png)


### 3. Cấu hình IP tĩnh bằng nmtui

Gõ lệnh nmtui :
```
Nmtui
```
![Imgur](https://i.imgur.com/FL7IIjG.png)

Sửa file theo ý muốn và lưu 
![Imgur](https://i.imgur.com/HXZPHr0.png)

![Imgur](https://i.imgur.com/vEOevhu.png)

![Imgur](https://i.imgur.com/2UBkXBA.png)


## 2.Cấu hình IP tĩnh cho ubuntu server 18.04
Bước 1: Ktra IP hiện tại của máy
```
networkctl status
```
![Imgur](https://i.imgur.com/wFkBT7Q.png)
ta thấy card ens33 đang được sử dụng
Bước 2: Truy cập và sửa file

```
sudo vi /etc/netplan/00-installer-config.yaml
```
![Imgur](https://i.imgur.com/6N3BBxR.png)


Ta sẽ chỉ sửa file như sau
Ấn i để bắt đầu chỉnh sửa :
![Imgur](https://i.imgur.com/j5OIjOU.png)

Ấn Esc để thoát chế độ Insert

:wq! lưu và thoát file

Bước 3: cập nhập IP đã được cài đặt

```
sudo netplan apply
```

Bước 4: Kiểm tra IP xem đã được nhận hay chưa

```
networkctl status
```

![Imgur](https://i.imgur.com/vINDgXi.png)

