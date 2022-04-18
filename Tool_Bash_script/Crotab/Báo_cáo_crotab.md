- [Giới thiệu Cron, crontab](#giới-thiệu-cron-crontab)
  - [1 khai niem](#1-khai-niem)
  - [2. Cấu trúc file crontab](#2-cấu-trúc-file-crontab)
  - [3. Ví dụ](#3-ví-dụ)
  - [4. Một số dạng tắt](#4-một-số-dạng-tắt)
  - [5. Cách sử dụng](#5-cách-sử-dụng)


# Giới thiệu Cron, crontab

## 1 khai niem
 - nó cho phép bạn chạy các tác vụ theo một lịch biểu (có thể một lần, lặp lại nhiều lần) theo phút, giờ, ngày, tuần, tháng. Thành phần đó trong Linux là crontab (viết tắt của chronograph table).
 
 -  Nó dựa vào đồng hồ hệ thống xác định thời điểm phù hợp thi hành các tác vụ được cấu hình chạy. 
 -  Thường sử dụng ``crontab`` để chạy các lệnh, các script nhẹ với mục đích bảo trì hệ thống, ví du như định kỳ hàng tuần xóa các file log cũ sinh ra bởi httpd, định kỳ cập nhật phần mềm ...

- Một chức năng giống như Microsoft Task Scheduler

- Kiểm tra trạng thái dịch vụ cron có đang chạy không

```
yum install cronie
```


- Để dừng, chạy, khởi động lại sử dụng các lệnh: 

```
systemctl stop|start|restart crond
```

- Kiểm tra các crontab
  
Các crontab (các tác vụ cần chạy theo lịch) được thiết lập chạy cho từng User, để liệt kê xem User hiện tại (đang login) có các crontab nào sử dụng lệnh sau :

```
crontab -l
```

Biên tập crontab

Mặc định thì lưu trữ tại `` /var/spool/cron/`` , bạn có thể dùng các trình soạn thảo ``text`` như ``vim``, ``nano`` vào biên tập - thêm bớt các tác vụ cần chạy theo lịch
- Var log: ``/var/log/cron ``
Hoặc vào ngay soạn thảo các crontab cho user hiện tại bằng lệnh:

``crontab -e``

Ở màn hình soạn thảo, bạn biên tập các dòng crontab theo cấu trúc trình bày phần dưới, sau đó lưu lại và thoát ra, nếu cú pháp khai báo không có lỗi gì thì các crontab được cài đặt và lên lịch thực hiện


## 2. Cấu trúc file crontab
```
*    *    *   *    *  Command_to_execute
|    |    |    |   |       
|    |    |    |    Day of the Week ( 0 - 6 ) ( Sunday = 0 )
|    |    |    |
|    |    |    Month ( 1 - 12 )
|    |    |
|    |    Day of Month ( 1 - 31 )
|    |
|    Hour ( 0 - 23 )
|
Min ( 0 - 59 )
```

Dấu "*" đại diện cho mỗi đơn vị thời gian .(Nếu như dấu * nằm ở vị trí là phút thì mỗi phút kích hoạt)
    - Cột 1: định nghĩa theo phút. có thể gán từ 0 -59
    - Cột 2: định nghĩa theo giờ. Có thể gán từ 0 - 23
    - Côt 3: định nghĩa theo ngày. có thể gán từ 0 -31
    - Cột 4: định nghĩa theo tháng. (1 - 12)
    - Cột 5: định nghĩa theo ngày trong tuần (Sun, Mon, Tue, ...)
    - Cột 6: user thực thi lệnh
    - Cột 7: Lệnh được thực thi



*[phút]  *[giờ]  *[ngày trong tháng]  *[tháng]  *[thứ]  [lệnh chạy (script hoặc lệnh linux)]
Vậy mỗi dòng thường có 6 cột dữ liệu, 5 cột đầu để xác định thời điểm chạy (thời gian). Cột thứ 6 là lệnh chạy (thường là một script).

Các cột thời gian, loại thời gian nào luôn xảy ra để dấu * (ví dụ mọi phút thì cột phút để dấu *, mọi giờ thì cột giờ để *, mọi ngày thì cột ngày để * ....) còn muốn xảy ra ở một thời điểm cụ thể thì điền thời điểm đó vào.
 
## 3. Ví dụ

Ví dụ: Cứ đến phút 30 hàng giờ thì chạy script tên là /script/abc.sh thì cấu trúc như sau:

Điền số 30 vào cột phút, các cột giờ, ngày, tháng, thứ điền * vì xảy ra mọi giờ, mọi ngày, mọi tháng. Vậy dòng crontab phù hợp như sau:

``
30 * * * *  /script/abc.sh
``

Tương tự như vậy xem một số ví dụ sau:

Chạy vào lúc 3 giờ hàng ngày:

0 3 * * *  /script/abc.sh

Chạy vào lúc 17h ngày chủ nhật hàng tuần:

0 17 * * sun /scripts/abc.sh

Cứ 8 tiếng là chạy:

0 */8 * * * /scripts/abc.sh

Cứ 30 phút chạy một lần:

*/30 * * * * /script/abc.sh

* Từ khóa contab đặc biệt

```
@reboot         Chạy một lần mỗi khi khởi động lại
@yearly          Chạy một lần mỗi năm    "0 0 1 1 *"
@annually     (Tương tự @yearly)
@monthly     Chạy  mỗi tháng một lần  "0 0 1 * *"
@weekly       Chạy mỗi tuần một lần  "0 0 * * 0"
@daily           Chạy một lần mỗi ngày    "0 0 * * *"
@midnight   (Tương tự @daily)
@hourly        Chạy một lần mỗi giờ    "0 * * * *"
```
## 4. Một số dạng tắt

Chạy hàng tháng

```
@monthly /scripts/abc.sh
```

Chạy hàng tuần
```
@weekly /bin/script.sh
```

Chạy hàng ngày

```
@daily /scripts/script.sh
```

Ví dụ về Crontab
Kiểm tra database và tự sửa chữa.
Mysql nhiều khi bị crash database và cần repair, tạo một script làm việc này và chạy vào 3h sáng hàng ngày.

## 5. Cách sử dụng

Làm như sau:

Tạo một script tên là ``backup.sh`` với nội dung như sau

```
#!/bin/bash
mysqlcheck -u{username}  -p{password} --auto-repair --check --all-databases
Trong đó {username} : điền tài khoản admin của mysql; {password} thay bàng password.
```

Sau đó gõ lệnh

```
crontab -e
```

Thêm vào một dòng với nội dung

```

30    *    *    *    *    /backup.sh
```

Lưu lại là xong.

Cứ 30 phút là chạy một script trong backup.sh
