# Chapter 55: The cut command

|Tham số |Thông tin chi tiết|
|---|---|
-f, --fields|Lựa chọn dựa trên lĩnh vực
-d, --delimiter|Dấu phân cách để lựa chọn dựa trên trường
-c, --characters|Lựa chọn dựa trên ký tự, dấu phân cách bị bỏ qua hoặc lỗi
-s, --only-delimited |triệt tiêu không có ký tự phân tách (được in dưới dạng khác)
--complement|Đảo ngược lựa chọn (trích xuất tất cả ngoại trừ các trường / ký tự được chỉ định
--output-delimiter |Chỉ định khi nào nó phải khác với dấu phân cách đầu vào

Lệnh `cut` là một cách nhanh chóng để trích xuất các phần của dòng tệp văn bản. Nó thuộc về các lệnh Unix lâu đời nhất. Của nótriển khai phổ biến nhất là phiên bản GNU được tìm thấy trên Linux và phiên bản FreeBSD được tìm thấy trên MacOS, nhưngmỗi hương vị của Unix có riêng của nó. Xem bên dưới để biết sự khác biệt. Các dòng đầu vào được đọc từ stdin hoặc từ các tệpđược liệt kê dưới dạng các đối số trên dòng lệnh.

## 55.1: Chỉ một ký tự phân cách - Only one delimiter character

Bạn không thể có nhiều hơn một dấu phân tách: nếu bạn chỉ định một cái gì đó như -d ",;:" , một số triển khai sẽ sử dụngchỉ ký tự đầu tiên làm dấu phân cách (trong trường hợp này là dấu phẩy.) Các triển khai khác (ví dụ: GNU `cut` ) sẽ cung cấp cho bạnmột thông báo lỗi.

```
$ cut -d ",;:" -f2 <<<"J.Smith,1 Main Road,cell:1234567890;land:4081234567"
cut: the delimiter must be a single character
Try `cut --help' for more information.
```

## 55.2: Dấu phân cách lặp lại được hiểu là trống lĩnh vực - Repeated delimiters are interpreted as empty fields

```
$ cut -d, -f1,3 <<<"a,,b,c,d,e"
a,b
```

khá rõ ràng, nhưng với các chuỗi được phân cách bằng dấu cách, nó có thể ít rõ ràng hơn đối với một số

```
$ cut -d ' ' -f1,3 <<<"a b c d e"
a b
```

`cut` không thể được sử dụng để phân tích cú pháp các đối số như shell và các chương trình khác.

## 55.3: Không trích dẫn - No quoting

Không có cách nào để bảo vệ dấu phân cách. Bảng tính và phần mềm xử lý CSV tương tự thường có thể nhận raký tự trích dẫn văn bản giúp bạn có thể xác định các chuỗi có chứa dấu phân cách. Với cắt bạn không thể.

```
$ cut -d, -f3 <<<'John,Smith,"1, Main Street"'
"1
```

## 55.4: Trích xuất, không thao tác -  Extracting, not manipulating

Bạn chỉ có thể trích xuất các phần của dòng, không thể sắp xếp lại hoặc lặp lại các trường.

```
$ cut -d, -f2,1 <<<'John,Smith,USA' ## Just like -f1,2
John,Smith
$ cut -d, -f2,2 <<<'John,Smith,USA' ## Just like -f2
Smith
```