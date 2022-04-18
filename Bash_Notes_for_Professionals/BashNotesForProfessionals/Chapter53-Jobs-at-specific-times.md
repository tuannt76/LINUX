# Chapter 53: Jobs at specific times

## 53.1: Thực hiện công việc một lần tại một thời điểm cụ thể -  Execute job once at specific time

Lưu ý: `at` không được cài đặt theo mặc định trên hầu hết các bản phân phối hiện đại.

Để thực hiện công việc một lần vào một thời điểm nào đó khác bây giờ, trong ví dụ này là 5 giờ chiều, bạn có thể sử dụng

```
echo "somecommand &" | at 5pm
```

Nếu bạn muốn bắt đầu ra, bạn có thể làm điều đó theo cách thông thường:

```
echo "somecommand > out.txt 2>err.txt &" | at 5pm
```

tại hiểu nhiều định dạng thời gian, vì vậy bạn cũng có thể nói

```
echo "somecommand &" | at now + 2 minutes
echo "somecommand &" | at 17:00
echo "somecommand &" | at 17:00 Jul 7
echo "somecommand &" | at 4pm 12.03.17
```

Nếu không có năm hoặc ngày nào được đưa ra, nó sẽ giả định thời gian tiếp theo mà bạn đã chỉ định sẽ xảy ra. Vì vậy, nếu bạn cho một giờ rằngngày hôm nay đã trôi qua, nó sẽ giả định vào ngày mai, và nếu bạn đưa ra một tháng đã trôi qua trong năm nay, nó sẽ cho rằng năm sau.

Điều này cũng hoạt động cùng với nohup như bạn mong đợi.

```
echo "nohup somecommand > out.txt 2>err.txt &" | at 5pm
```

Có một số lệnh khác để kiểm soát các công việc được hẹn giờ:

- **atq** liệt kê tất cả các công việc được hẹn giờ (**atq**ueue)
- **atrm** loại bỏ công việc đã hẹn giờ (**atr**e**m**ove)
- **batch** về cơ bản giống như tại, nhưng chỉ chạy công việc khi tải hệ thống thấp hơn 0,8

Tất cả các lệnh áp dụng cho các công việc của người dùng đã đăng nhập. Nếu đăng nhập bằng quyền root, tất nhiên là các công việc trên toàn hệ thống sẽ được xử lý.

## 53.2: Thực hiện các công việc vào những thời điểm cụ thể, sử dụng lặp đi lặp lạisystemd.timer - Doing jobs at specified times repeatedly using systemd.timer

**systemd** cung cấp một triển khai hiện đại của **cron**. Để thực thi một tập lệnh định kỳ, một dịch vụ và một tập tin hẹn giờ làcần thiết. Các tệp dịch vụ và bộ hẹn giờ phải được đặt trong /etc/systemd/{system,user}. Tệp dịch vụ:

```
[Unit]
Description=my script or programm does the very best and this is the description

[Service]
# loại là quan trọng!

Type=simple

# chương trình | script để gọi. Luôn sử dụng các bước vỗ nhẹ tuyệt đối
# và chuyển hướng STDIN và STDERR vì không có thiết bị đầu cuối khi đang được thực thi

ExecStart=/absolute/path/to/someCommand >>/path/to/output 2>/path/to/STDERRoutput

# KHÔNG phần cài đặt !!!! Được xử lý bởi chính các tiện ích của bộ đếm thời gian.
#[Cài đặt]

# WantedBy = multi-user.target
```

Tiếp theo tệp hẹn giờ:
```
[Unit]
Description=my very first systemd timer
[Timer]
# Cú pháp cho thông số ngày / giờ là Ymd H: M: S
# a * có nghĩa là "từng" và danh sách các mục được phân tách bằng dấu phẩy cũng có thể được cung cấp
# * - * - * *, 15,30,45: 00 cho biết hàng năm, hàng tháng, hàng ngày, hàng giờ,
# ở phút 15,30,45 và 0 giây

OnCalendar=*-*-* *:01:00

# cái này chạy mỗi giờ ở một phút 0 giây, ví dụ: 13:01:00
```