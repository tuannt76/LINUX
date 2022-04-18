# Chapter 60: Select keyword - Chọn từ khoá

Từ khóa Select có thể được sử dụng để lấy đối số đầu vào ở định dạng menu.

## 60.1: Chọn từ khóa có thể được sử dụng để lấy đầu vàođối số trong một định dạng menu - Select keyword can be used for getting input argument in a menu format

Giả sử bạn muốn sử dụng để **SELECT** từ khóa từ một menu, chúng ta có thể tạo ra một kịch bản tương tự như

```
#!/usr/bin/env bash

select os in "linux" "windows" "mac"
do
    echo "${os}"
    break
done
```

Giải thích: Ở đây từ khóa **SELECT** được sử dụng để lặp qua danh sách các mục sẽ được trình bày tại lệnhnhắc người dùng chọn từ. Lưu ý từ khóa **break** để thoát ra khỏi vòng lặp khi người dùng thực hiện sự lựa chọn. Nếu không, vòng lặp sẽ là vô tận!

Kết quả: Khi chạy tập lệnh này, một menu gồm các mục này sẽ được hiển thị và người dùng sẽ được nhắc vềsự lựa chọn. Sau khi chọn, giá trị sẽ được hiển thị, quay trở lại dấu nhắc lệnh.

```
>bash select_menu.sh
1) linux
2) windows
3) mac
#? 3
mac
>
```