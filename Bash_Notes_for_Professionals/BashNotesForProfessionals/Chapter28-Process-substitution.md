# Chapter 28: Process substitution - Thay thế quy trình

## 28.1: Compare two files from the web - So sánh hai tệp từ web

Phần sau so sánh hai tệp có sự khác biệt bằng cách sử dụng thay thế quy trình thay vì tạo tệp tạm thời.

```
diff <(curl http://www.example.com/page1) <(curl http://www.example.com/page2)
```

## 28.2: Feed a while loop with the output of a command - Nạp một vòng lặp while với đầu ra của một lệnh

Đây feeds một khi vòng lặp với sản lượng của một `grep` lệnh:

```
while IFS=":" read -r user _
do
# "$user" holds the username in /etc/passwd
done < <(grep "hello" /etc/passwd)
```

## 28.3: Concatenating files - Nối các tệp

Nó cũng được biết rằng bạn không thể sử dụng cùng một tập tin cho đầu vào và đầu ra trong cùng một lệnh. Ví dụ,

```
$ cat header.txt body.txt >body.txt
```

không làm những gì bạn muốn. Vào thời điểm con mèo đọc body.txt , nó đã bị cắt bớt bởi chuyển hướng và nótrống. Kết quả cuối cùng sẽ là body.txt sẽ chỉ chứa nội dung của header.txt .

Người ta có thể nghĩ rằng để tránh điều này bằng cách thay thế quy trình, tức là lệnh

```
$ cat header.txt <(cat body.txt) > body.txt
```

sẽ buộc nội dung gốc của body.txt bằng cách nào đó được lưu vào bộ đệm nào đó ở đâu đó trước khi tệp bị cắt ngắn bởi sự chuyển hướng. Nó không hoạt động. Con mèo trong ngoặc đơn bắt đầu đọc tệp chỉ sau tất cả tệpbộ mô tả đã được thiết lập, giống như bộ mô tả bên ngoài. Không có ích gì khi cố gắng sử dụng thay thế quy trình trong việc này trường hợp.

Cách duy nhất để thêm một tệp vào một tệp khác là tạo một tệp trung gian:

```
$ cat header.txt body.txt >body.txt.new
$ mv body.txt.new body.txt
```

đó là những gì sed hoặc perl hoặc các chương trình tương tự thực hiện bên dưới thảm khi được gọi với tùy chọn chỉnh sửa tại chỗ (thường là-i ).

## 28.4: Stream a file through multiple programs at once - Truyền một tệp qua nhiều chương trình tại Một lần

Điều này đếm số dòng trong một tệp lớn bằng `wc -l` trong khi nén đồng thời bằng `gzip` . Cả hai đều chạy kiêm nhiệm.

```
tee >(wc -l >&2) < bigfile | gzip > bigfile.gz
```

Thông thường `tee` ghi đầu vào của nó vào một hoặc nhiều tệp (và stdout). Chúng ta có thể ghi vào các lệnh thay vì các tệp có `tee >(command)`.

Ở đây, lệnh `wc -l >&2` đếm các dòng được đọc từ `tee` (lần lượt được đọc từ bigfile ). (Dòngsố đếm được gửi đến stderr (>&2) để tránh trộn với đầu vào cho gzip .) Stdout của tee được đồng thời đưa vào gzip .

## 28.5: With paste command - Với lệnh dán

```
# Thay thế quy trình bằng lệnh dán là phổ biến
# Để so sánh nội dung của hai thư mục
paste <( ls /path/to/directory1 ) <( ls /path/to/directory2 )
```

## 28.6: To avoid usage of a sub-shell - Để tránh sử dụng trình bao phụ

Một khía cạnh chính của thay thế quy trình là nó cho phép chúng tôi tránh sử dụng trình bao con khi các lệnh đường ống từcái vỏ.

Điều này có thể được chứng minh bằng một ví dụ đơn giản dưới đây. Tôi có các tệp sau trong thư mục hiện tại của mình:

```
$ find . -maxdepth 1 -type f -print
foo bar zoo foobar foozoo barzoo
```

Nếu tôi ống để một vòng lặp write/read mà gia một bộ đếm như sau:

```
count=0
find . -maxdepth 1 -type f -print | while IFS= read -r _; do
    ((count++))
done
```

$count bây giờ không chứa 6 , vì nó đã được sửa đổi trong ngữ cảnh vỏ con. Bất kỳ lệnh nào được hiển thịbên dưới được chạy trong ngữ cảnh của trình bao con và phạm vi của các biến được sử dụng bên trong sẽ bị mất sau khi trình bao conchấm dứt.

```
command &
command | command
( command )
```

Thay thế quy trình sẽ giải quyết vấn đề bằng cách tránh sử dụng đường ống | nhà điều hành như trong

```
count=0
while IFS= read -r _; do
    ((count++))
done < <(find . -maxdepth 1 -type f -print)
```

Điều này sẽ giữ lại giá trị của biến đếm vì không có trình bao con nào được gọi.