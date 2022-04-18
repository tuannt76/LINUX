# Chapter 16: Copying (cp)


Tuỳ chọn |Mô tả|
|---|---|
-a , -archive|Kết hợp các tùy chọn d , p và r
-b , -backup|Trước khi xóa, hãy tạo một bản sao lưu
-d , --no-deference| Bảo tồn các liên kết
-f , --force|Xóa các điểm đến hiện có mà không cần nhắc người dùng
-i , --interactive |Hiện nhắc trước khi ghi đè
-l , --link |Thay vì sao chép, hãy liên kết các tệp thay thế
-p , --preserve |Bảo tồn các thuộc tính tệp khi có thể
-R , --recursive |Sao chép đệ quy các thư mục

## 16.1:Copy a single file - Sao chép một tệp duy nhất

Copy `foo.txt` from `/path/to/source/` to `/path/to/target/folder/`
```
cp /path/to/source/foo.txt /path/to/target/folder/
```
Copy `foo.txt` from `/path/to/source/` to `/path/to/target/folder/` into a file called `bar.txt`
```
cp /path/to/source/foo.txt /path/to/target/folder/bar.txt
```

## 16.2:Copy folders - Sao chép thư mục

sao chép foo thư mục vào thanh thư mục
```
cp -r /path/to/foo /path/to/bar
```
nếu thanh thư mục tồn tại trước khi phát lệnh, thì foo và nội dung của nó sẽ được sao chép vào thanh thư mục .Tuy nhiên, nếu thanh không tồn tại trước khi ra lệnh, thì thanh thư mục sẽ được tạo và nội dung của foo sẽ được đặt vào bar