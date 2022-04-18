# Chapter 24: Bash history substitutions - Sự thay thế lịch sử Bash

## 24.1: Quick Reference - Tham khảo nhanh

**Tương tác với lịch sử**

```
# Liệt kê tất cả các lệnh trước đó
history

# Xóa lịch sử, hữu ích nếu bạn vô tình nhập mật khẩu
history -c
```

**Người chỉ định sự kiện**

```
# Mở rộng đến dòng n của lịch sử bash
!n

# Mở rộng đến lệnh cuối cùng
!!

# Mở rộng đến lệnh cuối cùng bắt đầu bằng "văn bản"
!text

# Mở rộng đến lệnh cuối cùng có chứa "văn bản"
!?text

# Mở rộng thành lệnh n dòng trước
!-n

# Mở rộng đến lệnh cuối cùng với sự xuất hiện đầu tiên của "foo" được thay thế bằng "bar"
^foo^bar^

# Mở rộng thành lệnh hiện tại
!#
```

**Người chỉ định từ**

Chúng được phân tách bằng : từ bộ chỉ định sự kiện mà chúng đề cập đến. Có thể bỏ qua dấu hai chấm nếu từ chỉ địnhkhông bắt đầu bằng số :!^ giống như !:^ .

```
# Mở rộng đến các đối số đầu tiên của lệnh gần đây nhất
!^

# Mở rộng đến đối số cuối cùng của lệnh gần đây nhất (viết tắt của !!: $)
!$

# Mở rộng đến đối số thứ ba của lệnh gần đây nhất
!:3

# Mở rộng đến các đối số x đến y (bao gồm) của lệnh cuối cùng
# x và y có thể là số hoặc ký tự neo ^ $
!:xy

# Mở rộng đến tất cả các từ của lệnh cuối cùng ngoại trừ lệnh 0
# Tương đương với: ^ - $
!*
```

**Modifiers**

Những điều này sửa đổi sự kiện trước đó hoặc bộ chỉ định từ.

```
# Thay thế trong phần mở rộng sử dụng cú pháp sed
# Cho phép gắn cờ trước dấu phân cách s và thay thế
:s/foo/bar/ #subsaries bar cho lần xuất hiện đầu tiên của foo
:gs|foo|bar| #substitutes thanh cho tất cả foo

# Xóa đường dẫn đầu khỏi đối số cuối cùng ("tail")
:t

# Xóa đường dẫn khỏi đối số cuối cùng ("head")
:h

# Xóa phần mở rộng tệp khỏi đối số cuối cùng
:r
```

Nếu biến Bash HISTCONTROL chứa một trong hai ignorespace hoặc ignoreboth (hoặc, cách khác, HISTIGNORE chứa mô hình [] * ), bạn có thể ngăn chặn các lệnh của bạn không bị lưu vào lịch sử Bash bởi prepending chúng với không gian:

```
# Lệnh này sẽ không được lưu trong lịch sử
foo

# Lệnh này sẽ được lưu
bar
```

## 24.2: Repeat previous command with sudo - Lặp lại lệnh trước với sudo

```
$ apt-get install r-base
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?
$ sudo !!
sudo apt-get install r-base
[sudo] password for <user>:
```

## 24.3: Search in the command history by pattern - Tìm kiếm trong lịch sử lệnh theo mẫu

Nhấn `control r` và nhập một mẫu.

Ví dụ: nếu gần đây bạn đã thực thi crontab man 5 , bạn có thể tìm thấy nó nhanh chóng bằng cách bắt đầu nhập "crontab". Cáclời nhắc sẽ thay đổi như thế này:

```
(reverse-i-search)`cr': man 5 crontab
```

Các 'cr' có chuỗi tôi gõ cho đến nay. Đây là một tìm kiếm gia tăng, vì vậy khi bạn tiếp tục nhập, kết quả tìm kiếm được cập nhật để khớp với lệnh gần đây nhất có chứa mẫu.

Nhấn các phím mũi tên trái hoặc phải để chỉnh sửa lệnh đã khớp trước khi chạy nó hoặc phím `enter` để chạy lệnh chỉ huy.

Theo mặc định, tìm kiếm sẽ tìm thấy lệnh được thực hiện gần đây nhất phù hợp với mẫu. Để đi xa hơn trở lại lịch sử nhấn `control r` một lần nữa. Bạn có thể nhấn liên tục cho đến khi tìm thấy lệnh mong muốn.

## 24.4: Switch to newly created directory with !#:N - Chuyển sang thư mục mới tạo bằng !#:N

```
$ mkdir backup_download_directory && cd !#:1
mkdir backup_download_directory && cd backup_download_directory
```

Điều này sẽ thay thế đối số thứ N của lệnh hiện tại. Trong ví dụ !#:1 được thay thế bằng số đầu tiên đối số, tức là backup_download_directory.

## 24.5: Using !$ - Sử dụng !$

Bạn có thể sử dụng !$ Để giảm sự lặp lại khi sử dụng dòng lệnh:

```
$ echo ping
ping
$ echo !$
ping
```

Bạn cũng có thể xây dựng dựa trên sự lặp lại

```
$ echo !$ pong
ping pong
$ echo !$, a great game
pong, a great game
```

Chú ý rằng trong ví dụ cuối cùng chúng tôi đã không nhận được ping pong, một trò chơi tuyệt vời bởi vì đối số cuối cùng được chuyển sang ngườilệnh trước đó là pong , chúng ta có thể tránh sự cố như thế này bằng cách thêm dấu ngoặc kép. Tiếp tục với ví dụ,đối số là trò chơi :

```
$ echo "it is !$ time"
it is game time
$ echo "hooray, !$!"
hooray, it is game time!
```

## 24.6: Repeat the previous command with a substitution - Lặp lại lệnh trước với mộtthay thế

```
$ mplayer Lecture_video_part1.mkv
$ ^1^2^
mplayer Lecture_video_part2.mkv
```

Lệnh này sẽ thay thế 1 bằng 2 trong lệnh đã thực hiện trước đó. Nó sẽ chỉ thay thế lần xuất hiện đầu tiên củachuỗi và tương đương với `!!:s/1/2/`.

Nếu bạn muốn thay thế tất cả các lần xuất hiện, bạn phải sử dụng `!!:gs/1/2/or!!:as/1/2`.