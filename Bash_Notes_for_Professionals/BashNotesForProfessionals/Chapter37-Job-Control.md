# Chapter 37: Job Control

## 37.1: List background processes - Liệt kê các quy trình nền
```
$ jobs
[1] Running         sleep 500 &     (wd: ~)
[2]- Running        sleep 600 &     (wd: ~)
[3]+ Running        ./Fritzing &
```

Trường đầu tiên hiển thị id công việc. Dấu + và - theo sau id công việc cho hai công việc biểu thị công việc mặc định và công việc tiếp theoứng viên mặc định công việc khi công việc mặc định hiện tại kết thúc tương ứng. Công việc mặc định được sử dụng khi fg hoặc bgcác lệnh được sử dụng mà không có bất kỳ đối số nào.

Trường thứ hai cung cấp trạng thái của công việc. Trường thứ ba là lệnh được sử dụng để bắt đầu quá trình.

Trường cuối cùng (wd: ~) cho biết rằng các lệnh ngủ được bắt đầu từ thư mục làm việc ~ (Home).

## 37.2: Bring a background process to the foreground - Đưa quy trình nền lên nền trước

```
$ fg %2
sleep 600
```

%2 chỉ định công việc không. 2. Nếu fg được sử dụng mà không có bất kỳ đối số nào nếu quy trình cuối cùng được đặt trong nềnvấn đề xung quanh.

```
$ fg %?sle
sleep 500
```

?sle đề cập đến lệnh quy trình baground có chứa "sle". Nếu nhiều lệnh nền chứa chuỗi, nó sẽ tạo ra một lỗi.

## 37.3: Restart stopped background process - Khởi động lại quá trình nền đã dừng

```
$ bg
[8]+ sleep 600 &
```

## 37.4: Run command in background - Chạy lệnh trong nền

```
$ sleep 500 &
[1] 7582
```

Đặt lệnh ngủ trong nền. 7582 là id tiến trình của tiến trình nền.

## 37.5: Stop a foreground process - Dừng quá trình nền trước

Nhấn `Ctrl + Z` để dừng quá trình nền trước và đặt nó ở chế độ nền

```
$ sleep 600
^Z
[8]+ Stopped        sleep 600
```