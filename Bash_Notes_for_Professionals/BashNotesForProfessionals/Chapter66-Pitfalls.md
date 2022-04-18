# Chapter 66: Pitfalls

## 66.1: Khoảng trắng khi chỉ định biến

Khoảng trắng quan trọng khi gán các biến.

```
foo = 'bar' # không chính xác
foo= 'bar'  # không chính xác
foo='bar'   # Chính xác
```

Hai lỗi đầu tiên sẽ dẫn đến lỗi cú pháp (hoặc tệ hơn là thực hiện một lệnh không chính xác). Ví dụ cuối cùng sẽ chính xácđặt biến $foo thành văn bản "bar".

## 66.2: Các lệnh không thành công không ngừng thực thi tập lệnh

Trong hầu hết các ngôn ngữ kịch bản, nếu một lệnh gọi hàm không thành công, nó có thể đưa ra một ngoại lệ và ngừng thực thi chương trình.Các lệnh bash không có ngoại lệ, nhưng chúng có mã thoát. Tuy nhiên, một mã thoát khác 0 báo hiệu lỗi,một mã thoát khác 0 sẽ không ngừng thực hiện chương trình.

Điều này có thể dẫn đến các tình huống nguy hiểm (mặc dù phải thừa nhận là có) như vậy:

```
#!/bin/bash
cd ~/non/existent/directory
rm -rf *
```

Nếu cd -ing đến thư mục này không thành công, Bash sẽ bỏ qua lỗi và chuyển sang lệnh tiếp theo, xóa sạchthư mục từ nơi bạn chạy tập lệnh.

Cách tốt nhất để giải quyết vấn đề này là sử dụng lệnh set :

```
#!/bin/bash
set -e
cd ~/non/existent/directory
rm -rf *
```

`set -e` yêu cầu Bash thoát khỏi tập lệnh ngay lập tức nếu bất kỳ lệnh nào trả về trạng thái khác 0.

## 66.3: Thiếu dòng cuối cùng trong tệp

Tiêu chuẩn C nói rằng các tệp phải kết thúc bằng một dòng mới, vì vậy nếu EOF ở cuối dòng, dòng đó có thể khôngbị bỏ lỡ bởi một số lệnh. Như một ví dụ:

```
$ echo 'one\ntwo\nthree\c' > file.txt

$ cat file.txt
one
two
three

$ while read line ; do echo "line $line" ; done < file.txt
one
two
```

Để đảm bảo điều này hoạt động chính xác cho trong ví dụ trên, hãy thêm một bài kiểm tra để nó sẽ tiếp tục vòng lặp nếu dòng cuối cùngkhông có sản phẩm nào.

```
$ while read line || [ -n "$line" ] ; do echo "line $line" ; done < file.txt
one
two
three
```