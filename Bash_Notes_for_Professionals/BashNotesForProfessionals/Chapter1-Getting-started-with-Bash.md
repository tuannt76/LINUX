# Section 1.1: Hello World

*Interactive Shell*


Bash shell thường được sử dụng tương tác: Nó cho phép bạn nhập và chỉnh sửa các lệnh, sau đó thực thi chúng khi
bạn nhấn phím `Return` .
 Nhiều hệ điều hành dựa trên Unix và giống Unix sử dụng Bash làm trình mặc định của chúng (đặc biệt là Linux và macOS). 
 
 Thiết bị đầu cuối tự động nhập một quy trình Bash shell tương tác khi khởi động.

Nhập Hello World bằng cách gõ như sau:
echo "Xin chào thế giới"
#> Hello World # Ví dụ đầu ra

Ghi chú:

- Bạn có thể thay đổi trình bao bằng cách nhập tên của trình bao trong thiết bị đầu cuối. Ví dụ: sh, bash, v.v.
- echo là một lệnh nội trang Bash ghi các đối số mà nó nhận được vào đầu ra chuẩn. Nó nối một dòng mới đến đầu ra, theo mặc định.
  
*Non-Interactive Shell*

Bash shell cũng có thể chạy không tương tác từ một script, làm shell không cần sự tương tác từ con người. Hành vi tương tác và hành vi theo tập lệnh phải giống nhau- một cân nhắc phải thiết kế quan trọng của Unix V7 Bourne shele và tạm dịch là bash. Do đó bất cứ điều gì có thể thực hiển được ở dòng lệnh đều có thể được đưa vào script để sử dụng lại.

Làm theo các bước để tạo một script Hello world:

- Tạo file mới có tên hello.sh: ``` touch hello.sh ```

- Thêm quyền thực thi đối với file: ``` chmod +x hello.sh ```

- Thêm code vào file hello.sh su dung lenh ` Vi ` thêm các dòng sau vao file :

  - #!/bin/bash

  - echo "Hello World"

Dòng 1 của tập lệnh phải bắt đầu bằng chuỗi ký tự #! được gọi là shebang1. Shebang hướng dẫn hệ điều hành chạy

Dòng 2 sử dụng echo để ghi Hello World vào đầu ra tiêu chuẩn


Thực thi tập lệnh hello.sh từ dòng lệnh bằng cách sử dụng một trong những cách sau

Cách mà được sử dụng phổ biến nhất
-  ./hello.sh
- /bin/bash hello.sh
- bash hello.sh
- sh hello.sh
  
Tất cả đều được kết quả cuối cùng là `Hello World`


Các lỗi thường gặp bao gồm:

- Không áp dụng quyền thực thi trên tệp, ``` chmod +x script.sh ``` 


- khi thực thi sẽ xuất hiện -bash: ./script.sh: Permission denied
Chỉnh sửa tệp lệnh trên Window, tạo ra các ký tự kết thúc dòng không chính xác mà bash không thể xử lý.

- Sử dụng sh ./hello.sh, không nhận ra rằng bash và sh là các shell riêng biệt(mặc dù bash tương thích ngược). Dù sao chỉ cần dựa vào các dòng shebang của script là rất thích hợp để viết rõ rằng bash hoặc sh(hoặc python ,perl, awk hoặc ruby) trước tên tệp của mỗi script. Một dòng shebang phổ biết được sử dụng để làm cho tập lệnh của bạn dễ di chuyển hơn là sử dụng #!/usr/bin/env bash thay vì mã hóa cứng đường dẫn đến bash. Theo cách đó, /usr/bin/env phải tồn tại nhưng ngoài thời điểm đó, chỉ cần bash có ở trên PATH của bạn. Trên nhiều hệ thống, /bin/bash không tồn tại và bạ nên sử dụng /usr/local/bin/bash hoặc một số đường dẫn tuyệt đối khác

# Section 1.2: Hello World Using Variables

Tạo một file hello.sh với nội dung và cấp quyền thực thi

#!/usr/bin/env bash
echo "Ten ban la gi?"
read name
echo "Ten toi la, $name."

Lệnh `read` ở đây đọc một dòng dữ liệu từ đầu vào chuẩn vào tên biến. Sau đó tham chiếu bằng cách sử dụng `$name` và in ra  bằng cách sử dụng echo.

[root@localhost ~]# ./hello.sh
Ten ban la gi?
tuannguyen
Ten toi la ,tuannguyen


Đoạn mã sau châp nhận một đối số $1 , là đối số dòng lệnh đầu tiên và xuất nó ra một chuỗi định dạng. Nôi dung tệp lệnh như sau:

#!/usr/bin/env bash
printf "Hello, %s\n" "$1"

Thực hiện lệnh với đối số là ký tự theo sao câu lệnh:

[root@hdv ~]# ./hello.sh 
Hello, 
[root@hdv ~]# ./hello.sh Tuannguyen
Hello, Tuannguyen
[root@hdv ~]# ./hello.sh Tuan Nguyen
Hello, Tuan
[root@hdv ~]# ./hello.sh  "Tuan Nguyen"
Hello, Tuan Nguyen

- Câu lệnh đầu tiên là không có đối số.
- Câu lệnh thứ 2, đối số bằng với một chuỗi
- Câu lệnh thứ 3, đối với chuỗi có phân cách nhau bằng dấu cách, đối số $1 chỉ được ứng với 1 chuỗi đầu tiền sau câu lệnh.
Để xử lý câu lệnh thứ 3 không hiện thị được chuỗi thì ta cần thêm dấu ngoặc kép cho câu lệnh.

# Section 1.4: Importance of Quoting in Strings

Phần sau sẽ nhắc người dùng nhập dữ liệu sau đó lưu thông tin văn bản dưới dạng string (text) trong một biến. Biến sau đó được sử dụng để in thông điệp cho người dùng:

sửa file hello.sh :

```
#!/usr/bin/env bash

echo "Tên của bạn là gì?"
read name
echo "Hello, $name."
```

Lệnh `read` ở đây đọc dữ liệu từ đầu vào tiêu chuẩn vào tên biến. Sau đó sử dụng $name và in ra bằng echo


Kiểm tra bằng cách gõ lệnh ```./hello.sh```

```
[root@localhost ~]# ./hello.sh
Tên cua bạn là gì?
tuanguyen
Hello, tuanguyen.
```




Nếu bạn muốn nối một cái gì đó vào giá trị biến trong khi in nó, hãy sử dụng dấu ngoặc nhọn quanh biến tên như được hiển thị trong ví dụ sau

```
#!/usr/bin/env bash
echo "Bạn đang làm gì?"
read action
echo "Bạn đang ${action} trong phong."
```

Kiểm tra bằng cách gõ lệnh ```./hello.sh```

```
[root@localhost ~]# ./hello.sh
Bạn đang làm gì?
xem phim
Bạn đang xem phim trong phong .
```

# Section 1.6: Hello World in "Debug" mode

ở chế độ này cho chúng ta phát hiện lỗi 
```
cat hello.sh
bash -x hello.sh
```

```
[root@localhost ~]# cat hello.sh
#!/usr/bin/env bash
echo "Bạn đang làm gì?"
read action
echo "Bạn đang ${action} trong phong ."
[root@localhost ~]# bash -x hello.sh
+ echo 'Bạn đang làm gì?'
Bạn đang làm gì?
+ read action

+ echo 'Bạn đang  trong phong .'
Bạn đang  trong phong .
```