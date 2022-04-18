# [Bash Shell] Viết chương trình gửi tin nhắn tới Telegram

## 1. Tạo bot Telegram

Bước 1: Login vào Telegram thông qua số điện thoại

Bước 2: Tìm BotFather
Tại ô search của Telegram tìm BotFather:


![](/LINUX/Bash_script/sendTelegram/Image/000.png)


Bước 3: Tạo Bot
Chat /newbot vào khung chat với BotFather để tạo:
- Đặt tên cho bot
- Đặt username cho bot

 ![](/LINUX/Bash_script/sendTelegram/Image/001.png)

- Nhận được mã token:
  
   ![](/LINUX/Bash_script/sendTelegram/Image/003.png)

## 2. Thêm Bot vào 1 Group
- Tạo group mới :

  ![](/LINUX/Bash_script/sendTelegram/Image/005.png)


- Khởi động bot bằng cách chat: /my_id @Alerts_Tuan_BOT

![](/LINUX/Bash_script/sendTelegram/Image/006.png)

## 3. Lấy Chat ID của group

Bước 3: Lấy ID Group Telegram của bạn. Ở đây là: **-746592079**( đây chính là ID group )

![](/LINUX/Bash_script/sendTelegram/Image/007.png)

## 4. Gửi thông báo tới Telegram
Để gửi thông báo tới Telegram bạn có thể sử dụng method GET
- Trên trình duyệt web:
```
https://api.telegram.org/bot<token>/sendMessage?chat_id=<chat_id>&text=<noi_dung>

- **token** : token là id của BOT ở phần tạo BOT
- **chat_id** : là id group muốn BOT gửi tin nhắn đến 
- **noi_dung** : noi dung cua ban

```
Hoặc sử dụng cURL (Trên Centos 7)

```
curl -d chat_id=<chat_id> -d text="noi_dung"  https://api.telegram.org/bot<token>/sendMessage
```
## 5. Tạo script gửi tin nhắn tới 1 Group

2. Các bước 

 - Bước 1: cd tới tệp mà bạn muốn lưu script

	ex:
 ```
[root@localhost ~]# cd /home
[root@localhost home]# touch sendtelegram.sh

```
- Bước 2: Sửa file cấu hình và paste dòng lệnh ở file Sendtelegram.sh 

```
#!/bin/bash

clear
printf "Gui tin toi group Telegram \n"
echo "nhap noi dung :"
read mes

token=5099434027:AAFetc-W1flprg_YbBc1kO4UIL_gpnaUWfg
id=-746592079
url=https://api.telegram.org/bot${token}/sendMessage

curl -d chat_id=$id -d text="$mes" $url

clear
printf "Gui $mes thanh cong\n"
```

ấn ``i`` để có thể sửa cấu hình file
ấn ``esc` để có thể thoát khỏi sửa file
ấn ``:wq`` để lưu và thoát

- Bước 3: phân quyền cho file để có thể chạy
  sử dụng lệnh

ex: 
```
chmod +x /scripts/createfileautu.sh
```
- Bước 4: chạy script bằng lệnh sau :

ex:

```
cd /home
bash sendtelegram.sh
```
