# Chapter 57: Cut Command - Lệnh Cut

|Option|Mô tả|
|---|---|
-b LIST,--bytes=LIST|In các byte được liệt kê trong tham số LIST
-c LIST,--characters=LIST |In các ký tự ở các vị trí được chỉ định trong tham số LIST
-f LIST,--fields=LIST|In các trường hoặc cột
-d DELIMITER|Được sử dụng để tách các cột hoặc trường

Trong Bash, lệnh `cut` rất hữu ích để chia tệp thành nhiều phần nhỏ hơn.

## 57.1: Hiển thị cột đầu tiên của tệp - Show the first column of a file

Giả sử bạn có một tệp trông giống như thế này

```
John Smith 31
Robert Jones 27
...
```

Tệp này có 3 cột được phân tách bằng dấu cách. Để chỉ chọn cột đầu tiên, hãy làm như sau.

```
cut -d ' ' -f1 filename
```

Ở đây cờ -d , chỉ định dấu phân cách hoặc cái gì ngăn cách các bản ghi. Các -f cờ xác định lĩnh vực hoặc cộtsố. Điều này sẽ hiển thị đầu ra sau

```
John
Robert
...
```

## 57.2: Hiển thị các cột từ x đến y của tệp - Show columns x to y of a file

Đôi khi, rất hữu ích khi hiển thị một loạt các cột trong một tệp. Giả sử bạn có tệp này

```
Apple California 2017 1.00 47
Mango Oregon 2015 2.30 33
```

Để chọn 3 cột đầu tiên, hãy làm

```
cut -d ' ' -f1-3 filename
```

Điều này sẽ hiển thị đầu ra sau

```
Apple California 2017
Mango Oregon 2015
```