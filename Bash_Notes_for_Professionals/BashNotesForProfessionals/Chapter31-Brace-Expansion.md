# Chapter 31: Brace Expansion

##  31.1: Modifying filename extension - Sửa đổi phần mở rộng tên tệp

```
$ mv filename.{jar,zip}
```

Điều này mở rộng thành mv filename.jar filename.zip .

## 31.2:Create directories to group files by month and year - Tạo thư mục để nhóm tệp theo tháng vànăm

```
$ mkdir 20{09..11}-{01..12}
```

Nhập lệnh ls sẽ cho thấy rằng các thư mục sau đã được tạo:

```
2009-01 2009-04 2009-07 2009-10 2010-01 2010-04 2010-07 2010-10 2011-01 2011-04 2011-07 2011-10
2009-02 2009-05 2009-08 2009-11 2010-02 2010-05 2010-08 2010-11 2011-02 2011-05 2011-08 2011-11
2009-03 2009-06 2009-09 2009-12 2010-03 2010-06 2010-09 2010-12 2011-03 2011-06 2011-09 2011-12
```

Đặt một số 0 trước số 9 trong ví dụ này đảm bảo các số được đệm bằng một số 0 duy nhất . Bạn cũng có thể đệm sốvới nhiều số không, ví dụ:

```
$ echo {001..10}
001 002 003 004 005 006 007 008 009 010
```

## 31.3:Create a backup of dotfiles - Tạo bản sao lưu các tệp dotfiles

```
$ cp .vimrc{,.bak}
```

Điều này mở rộng thành lệnh cp .vimrc .vimrc.bak .

## 31.4:Use increments - Sử dụng gia số

```
$ echo {0..10..2}
0 2 4 6 8 10
```

Tham số thứ ba để chỉ định giá trị gia tăng, tức là { start..end..increment }
Việc sử dụng số gia không bị hạn chế chỉ với các con số

```
$ for c in {a..z..5}; do echo -n $c; done
afkpuz
```

## 31.5:Using brace expansion to create lists - Sử dụng mở rộng dấu ngoặc nhọn để tạo danh sách

Bash có thể dễ dàng tạo danh sách từ các ký tự chữ và số.

```
# danh sách từ a đến z
$ echo {a..z}
a b c d e f g h i j k l m n o p q r s t u v w x y z

# đảo ngược từ z sang a
$ echo {z..a}
z y x w v u t s r q p o n m l k j i h g f e d c b a

# chữ số
$ echo {1..20}
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

# với các số 0 ở đầu
$ echo {01..20}
01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20

# chữ số đảo ngược
$ echo {20..1}
20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1

# được đảo ngược với các số 0 ở đầu
$ echo {20..01}
20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01

# kết hợp nhiều dấu ngoặc nhọn
$ echo {a..d}{1..3}
a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3
```

Mở rộng theo dấu ngoặc kép là mở rộng đầu tiên diễn ra, vì vậy nó không thể được kết hợp với bất kỳ mở rộng nào khác.

Chỉ có thể sử dụng các ký tự và chữ số.

Điều này sẽ không hoạt động: 
```
echo {$(date +$H)..24}
```

## 31.6:Make Multiple Directories with Sub-Directories - Tạo nhiều thư mục với các thư mục con

```
mkdir -p toplevel/sublevel_{01..09}/{child1,child2,child3}
```

Thao tác này sẽ tạo một thư mục cấp cao nhất có tên là toplevel , chín thư mục bên trong của toplevel có tên là sublevel_01 , sublevel_02 ,v.v ... Sau đó, bên trong các cấp độ lại đó:
```
toplevel/sublevel_01/child1
toplevel/sublevel_01/child2
toplevel/sublevel_01/child3
toplevel/sublevel_02/child1
```

và như thế. Tôi thấy điều này rất hữu ích để tạo nhiều thư mục và thư mục con cho các mục đích cụ thể của mình, với mộtlệnh bash. Các biến thay thế để giúp tự động hóa / phân tích cú pháp thông tin được cung cấp cho tập lệnh