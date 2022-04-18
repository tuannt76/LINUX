# Chapter 17: Find

find là một lệnh để tìm kiếm đệ quy một thư mục cho các tệp (hoặc thư mục) phù hợp với một tiêu chí và sau đó thực hiệnmột số hành động trên các tệp đã chọn.

tìm hành động search_path selection_criteria


## 17.1:Searching for a file by name or extension - Tìm kiếm tệp theo tên hoặc phần mở rộng

Để tìm các tệp / thư mục có tên cụ thể, liên quan đến `pwd` :
```
$ find . -name "myFile.txt"
./myFile.txt
```

Để tìm các tệp / thư mục có phần mở rộng cụ thể, hãy sử dụng ký tự đại diện:

```
$ find . -name "*.txt"
./myFile.txt
./myFile2.txt
```

Để tìm các tệp / thư mục phù hợp với một trong nhiều phần mở rộng, hãy sử dụng hoặc gắn cờ:

```
$ find . -name "*.txt" -o -name "*.sh"
```

Để tìm các tệp / thư mục có tên bắt đầu bằng abc và kết thúc bằng một ký tự alpha sau một chữ số:

```
$ find . -name "abc[a-z][0-9]"
```

Để tìm tất cả các tệp / thư mục nằm trong một thư mục cụ thể

```
$ find /opt
```

Để chỉ tìm kiếm các tệp (không phải thư mục), hãy sử dụng -type f :

```
find /opt -type f
```

Để chỉ tìm kiếm các thư mục (không phải các tệp thông thường), hãy sử dụng -type d :

```
find /opt -type d
```

## 17.2:Executing commands against a found file - Thực thi các lệnh đối với một tệp được tìm thấy

Đôi khi chúng ta sẽ cần chạy các lệnh đối với rất nhiều tệp. Điều này có thể được thực hiện bằng cách sử dụng `xargs` .

```
find . -type d -print | xargs -r chmod 770
```

Lệnh trên sẽ tìm một cách đệ quy tất cả các thư mục ( -type d ) liên quan đến . (công việc hiện tại của bạn là gì thư mục) và thực thi `chmod` `770` trên chúng. Các `-r` tùy chọn quy định cụ thể để `xargs` để không chạy `chmod` nếu `find` không tìm thấy bất kỳ tệp nào.

Nếu tên tệp hoặc thư mục của bạn có ký tự khoảng trắng trong đó, lệnh này có thể bị nghẹt; một giải pháp là sử dụng tiếp theo

```
find . -type d -print0 | xargs -r -0 chmod 770
```

Trong ví dụ trên, `-print0` và -0 flags chỉ định rằng tên tệp sẽ được phân tách bằng cách sử dụng một byte rỗng , vàcho phép sử dụng các ký tự đặc biệt, như dấu cách, trong tên tệp. Đây là một tiện ích mở rộng GNU và có thể không hoạt động trongcác phiên bản khác của `find` và `xargs` .

Cách ưa thích để làm điều này là bỏ qua lệnh `xargs` và cho phép `find` gọi chính quy trình con:

```
find . -type d -exec chmod 770 {} \;
```

Ở đây, {} là một trình giữ chỗ cho biết rằng bạn muốn sử dụng tên tệp tại thời điểm đó. `find` sẽ thực thi `chmod` trêntừng tệp riêng lẻ.

Hoặc bạn có thể vượt qua tất cả các tên tập tin vào một đơn tiếng gọi của `chmod` , bằng cách sử dụng

```
find . -type d -exec chmod 770 {} +
```

Đây cũng là hành vi của các đoạn mã `xargs` ở trên . (Để gọi từng tệp riêng lẻ, bạn có thể sử dụng `xargs -n1` ).

Tùy chọn thứ ba là cho phép bash lặp qua danh sách các tên tệp để `find` kết quả đầu ra:

```
find . -type d | while read -r d; do chmod 770 "$d"; done
```

Đây là cú pháp khó hiểu nhất, nhưng thuận tiện khi bạn muốn chạy nhiều lệnh trên mỗi tệp được tìm thấy.
Tuy nhiên, điều này là `không an toàn` khi đối mặt với các tên tệp có tên kỳ lạ.

```
find . -type f | while read -r d; do mv "$d" "${d// /_}"; done
```

sẽ thay thế tất cả các khoảng trắng trong tên tệp bằng dấu gạch dưới. (Ví dụ này cũng sẽ không hoạt động nếu có khoảng trắng trong tên *thư mục* hàng đầu .)

Vấn đề ở trên là mặc dù `read -r` mong đợi một mục nhập trên mỗi dòng, nhưng tên tệp có thể chứa các dòng mới(và ngoài ra, `read -r` sẽ mất bất kỳ khoảng trắng nào ở cuối). Bạn có thể sửa lỗi này bằng cách xoay chuyển tình thế:

```
find . -type d -exec bash -c 'for f; do mv "$f" "${f// /_}"; done' _ {} +
```

Bằng cách này, `-exec` nhận các tên tệp trong một biểu mẫu hoàn toàn chính xác và có thể di động; các `bash -c` nhậnchúng dưới dạng một số đối số, sẽ được tìm thấy trong $@, được trích dẫn chính xác, v.v. (Tập lệnh sẽ cần xử lýnhững cái tên này chính xác, tất nhiên; mọi biến chứa tên tệp cần được đặt trong dấu ngoặc kép.)

Bí ẩn là cần thiết vì đối số đầu tiên cho `bash -c` `'script'` được sử dụng để điền $0 .

## 17.3:Finding file by access / modification time - Tìm tệp theo thời gian truy cập/sửa đổi

Trên một ext hệ thống tập tin, mỗi tập tin có truy cập lưu trữ, Sửa đổi, và (Status) Thay đổi thời gian liên kết với nó - để xem thông tin này, bạn có thể sử dụng `stat` `myFile.txt` ; bằng cách sử dụng các cờ trong tìm kiếm , chúng tôi có thể tìm kiếm các tệp đã được sửa đổi trong một khoảng thời gian nhất định.

Để tìm các tệp đã được sửa đổi trong vòng 2 giờ qua:

```
$ find . -mmin -120
```

Để tìm các tệp chưa được sửa đổi trong vòng 2 giờ qua:

```
$ find . -mmin +120
```

Ví dụ trên đang tìm kiếm chỉ trên sửa đổi thời gian - để tìm kiếm trên một lần ccess, hoặc c treo cổ lần, sử dụng một , hoặcc cho phù hợp.

```
$ find . -amin -120
$ find . -cmin +120
```

Định dạng chung:

`-mmin n` : Tệp đã được sửa đổi n phút trước
`-mmin -n` : Tệp đã được sửa đổi chưa đầy n phút trước
`-mmin + n` : Tệp đã được sửa đổi hơn n phút trước

Tìm các tệp đã được sửa đổi trong vòng 2 ngày qua:

```
find . -mtime -2
```

Tìm các tệp chưa được sửa đổi trong vòng 2 ngày qua

```
find . -mtime +2
```

Sử dụng `-atime` và `-ctime` cho thời gian truy cập và thời gian thay đổi trạng thái tương ứng.

Định dạng chung:

`-mtime n` : Tệp đã được sửa đổi nx24 giờ trước
`-mtime -n` : Tệp đã được sửa đổi ít hơn nx24 giờ trước
`-mtime +n` : Tệp đã được sửa đổi hơn nx24 giờ trước

Tìm các tệp được sửa đổi trong một phạm vi ngày , từ 2007-06-07 đến 2007-06-08:

```
find . -type f -newermt 2007-06-07 ! -newermt 2007-06-08
```

Tìm tệp được truy cập trong một loạt dấu thời gian (sử dụng tệp làm dấu thời gian), từ 1 giờ trước đến 10 phút trước:

```
touch -t $(date -d '1 HOUR AGO' +%Y%m%d%H%M.%S) start_date
touch -t $(date -d '10 MINUTE AGO' +%Y%m%d%H%M.%S) end_date
timeout 10 find "$LOCAL_FOLDER" -newerat "start_date" ! -newerat "end_date" -print
```

Định dạng chung:

`-newerXY` tham chiếu : So sánh dấu thời gian của tệp hiện tại với tham chiếu. XY có thể có một trong những các giá trị sau: at (thời gian truy cập), mt (thời gian sửa đổi), ct (thời gian thay đổi) và hơn thế nữa. tham chiếu là tên của một tập tin khi muốn so sánh dấu thời gian được chỉ định (truy cập, sửa đổi, thay đổi) hoặc một chuỗi mô tả một giá trị tuyệt đối thời gian.

## 17.4:Finding files according to size - Tìm tệp theo kích thước

*Tìm tệp lớn hơn 15MB:*
```
find -type f -size +15M
```
*Tìm tệp nhỏ hơn 12KB:*

```
find -type f -size -12k
```

Tìm tệp chính xác có kích thước 12KB:

```
find -type f -size 12k
```

Hoặc

```
find -type f -size 12288c
```

Hoặc

```
find -type f -size 24b
```

Hoặc

```
find -type f -size 24
```

**Định dạng chung:**

```
find [options] -size n[cwbkMG]
```

>Tìm tệp có kích thước n-block, trong đó + n có nghĩa là nhiều hơn n-block, -n có nghĩa là nhỏ hơn n-block và n (không cóbất kỳ dấu hiệu nào) có nghĩa chính xác là khối n

*Kích thước khối:*

1. c : byte
2. w : 2 byte
3. b : 512 byte (mặc định)
4. k : 1 KB
5. M : 1 MB
6. G : 1 GB


## 17.5:Filter the path - Lọc đường dẫn

Các `-path` tham số cho phép chỉ định một mô hình để phù hợp với con đường của kết quả. Mẫu cũng có thể phù hợp với tên của chính nó.

Để chỉ tìm các tệp chứa nhật ký ở bất kỳ đâu trong đường dẫn của chúng (thư mục hoặc tên):

```
find . -type f -path '*log*'
```

Để chỉ tìm các tệp trong thư mục được gọi là nhật ký (ở mọi cấp độ):

```
find . -type f -path '*/log/*'
```

Để chỉ tìm các tệp trong một thư mục được gọi là nhật ký hoặc dữ liệu :

```
find . -type f -path '*/log/*' -o -path '*/data/*'
```

Để tìm tất cả các tệp ngoại trừ những tệp được chứa trong một thư mục có tên là bin :

```
find . -type f -not -path '*/bin/*'
```

Để tìm tất cả các tệp, tất cả các tệp ngoại trừ những tệp được chứa trong một thư mục được gọi là tệp bin hoặc tệp nhật ký:

```
find . -type f -not -path '*log' -not -path '*/bin/*'
```

## 17.6:Finding files by type - Tìm tệp theo loại

Để tìm tệp, hãy sử dụng cờ `-type f`
```
$ find . -type f
```
Để tìm các thư mục, hãy sử dụng cờ `-type d`

```
$ find . -type d
```

Để tìm các thiết bị khối, hãy sử dụng cờ `-type b`

```
$ find /dev -type b
```

Để tìm các liên kết tượng trưng, ​​hãy sử dụng cờ `-type l`

```
$ find . -type l
```

## 17.7:Finding files by specific extension - Tìm tệp theo phần mở rộng cụ thể

Để tìm tất cả các tệp của một tiện ích mở rộng nhất định trong đường dẫn hiện tại, bạn có thể sử dụng cú pháp `find` sau đây . Nó hoạt động bởi cách sử dụng `bash's` built-in cấu trúc hình cầu để khớp với tất cả các tên có .extension .

```
find /directory/to/search -maxdepth 1 -type f -name "*.extension"
```

Để tìm tất cả các tệp loại .txt chỉ từ thư mục hiện tại, hãy làm
```
find . -maxdepth 1 -type f -name "*.txt"
```