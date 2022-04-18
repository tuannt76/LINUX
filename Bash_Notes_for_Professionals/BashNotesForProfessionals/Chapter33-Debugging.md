# Chapter 33: Debugging

## 33.1: Checking the syntax of a script with "-n" - Kiểm tra cú pháp của tập lệnh với "-n"

Cờ -n cho phép bạn kiểm tra cú pháp của một tập lệnh mà không cần phải thực thi nó:

```
~> $ bash -n testscript.sh
testscript.sh: line 128: unexpected EOF while looking for matching `"'
testscript.sh: line 130: syntax error: unexpected end of file
```

## 33.2:33.2: Debugging using bashdb - Gỡ lỗi bằng bashdb

Bashdb là một tiện ích tương tự như gdb, ở chỗ bạn có thể thực hiện những việc như đặt các điểm ngắt tại một dòng hoặc tại một hàm, innội dung của các biến, bạn có thể khởi động lại quá trình thực thi tập lệnh và hơn thế nữa.

Thông thường, bạn có thể cài đặt nó thông qua trình quản lý gói của mình, chẳng hạn như trên Fedora:

```
sudo dnf install bashdb
```

Hoặc lấy nó từ trang chủ. Sau đó, bạn có thể chạy nó với tập lệnh của mình như một paramater:

```
bashdb <YOUR SCRIPT>
```

Dưới đây là một số lệnh để giúp bạn bắt đầu:
```
l - hiển thị các dòng cục bộ, nhấn l lần nữa để cuộn xuống
s - bước sang dòng tiếp theo
print $ VAR - lặp lại nội dung của biến
restart - chạy lại bashscript, nó tải lại trước khi thực thi.
eval - đánh giá một số lệnh tùy chỉnh, ví dụ: eval echo hi

b đặt điểm ngắt trên một số dòng
c - tiếp tục cho đến khi điểm dừng nào đó
i b - thông tin về điểm nghỉ
d - xóa điểm ngắt tại dòng #

shell - khởi chạy một sub-shell ở giữa quá trình thực thi, điều này rất tiện lợi cho việc thao tác với các biến
```
Để biết thêm thông tin, tôi khuyên bạn nên tham khảo sách hướng dẫn:
http://www.rodericksmith.plus.com/outlines/manuals/bashdbOutline.html

Xem thêm trang chủ:
http://bashdb.sourceforge.net/

## 33.3:Debugging a bash script with "-x" - Gỡ lỗi tập lệnh bash với "-x"

Sử dụng "-x" để kích hoạt đầu ra gỡ lỗi của các dòng được thực thi. Nó có thể được chạy trên toàn bộ phiên hoặc tập lệnh, hoặc được bậttheo chương trình trong một tập lệnh.

Chạy một tập lệnh với đầu ra gỡ lỗi được bật:

```
$ bash -x myscript.sh
```

Or

```
$ bash --debug myscript.sh
```

Bật gỡ lỗi trong tập lệnh bash. Nó có thể được bật lại theo tùy chọn, mặc dù đầu ra gỡ lỗi tự độngđặt lại khi tập lệnh thoát.
```
#!/bin/bash
set -x  # Bật gỡ lỗi
# một số mã ở đây
set + x # Tắt đầu ra gỡ lỗi.
```