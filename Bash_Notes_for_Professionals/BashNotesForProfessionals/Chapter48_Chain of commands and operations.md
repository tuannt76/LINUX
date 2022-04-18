# Chapter 48: Chain of commands and operations(Chuỗi lệnh và hoạt động)

Có một số phương tiện để xâu chuỗi các lệnh lại với nhau. Những cái đơn giản như chỉ a; hoặc những cái phức tạp hơn như lôgic chuỗi chạy tùy thuộc vào một số điều kiện. Cái thứ ba là các lệnh đường ống, giúp chuyển giao một cách hiệu quả dữ liệu đầu ra cho lệnh tiếp theo trong chuỗi.

## 48.1: Đếm tỷ lệ xuất hiện của một mẫu văn bản - Counting a text pattern ocurrence

Sử dụng một đường ống làm cho đầu ra của một lệnh trở thành đầu vào của lệnh tiếp theo.

```
ls -1 | grep -c ".conf"
```

Trong trường hợp này, đầu ra của lệnh ls được sử dụng làm đầu vào của lệnh grep. Kết quả sẽ là sốtrong số các tệp có ".conf" trong tên của chúng.

Điều này có thể được sử dụng để cấu trúc chuỗi các lệnh tiếp theo miễn là cần thiết:

```
ls -1 | grep ".conf" | grep -c .
```

## 48.2: chuyển đầu ra cmd gốc sang tệp người dùng - transfer root cmd output to user file

Thường thì một người muốn hiển thị kết quả của một lệnh được thực thi bởi root cho những người dùng khác. Lệnh phát bóng cho phép dễ dàngđể ghi tệp với quyền của người dùng từ lệnh chạy dưới quyền root:

```
su -c ifconfig | tee ~/results-of-ifconfig.txt
```

Chỉ ifconfig chạy dưới dạng root.

## 48.3: Chuỗi logic các lệnh với && và || - logical chaining of commands with && and ||

&& xâu chuỗi hai lệnh. Cái thứ hai chỉ chạy nếu cái đầu tiên thoát thành công. || chuỗi hai lệnh.Nhưng chiếc thứ hai chỉ chạy nếu chiếc đầu tiên thoát ra ngoài với thất bại.

```
[ a = b ] && echo "yes" || echo "no"
# nếu bạn muốn chạy nhiều lệnh hơn trong một chuỗi logic, hãy sử dụng dấu ngoặc nhọn# chỉ định một khối lệnh
# Họ cần một; trước khi đóng dấu ngoặc để bash có thể phân biệt với các mục đích sử dụng khác
# trong số các dấu ngoặc nhọn
[ a = b ] && { echo "let me see."
        echo "hmmm, yes, i think it is true" ; } \
    || { echo "as i am in the negation i think "
        echo "this is false. a is a not b." ; }
# lưu ý việc sử dụng dấu nối tiếp dòng \
# chỉ cần để chuỗi có khối với || ....
```

## 48.4: Chuỗi nối tiếp các lệnh bằng dấu chấm phẩy - serial chaining of commands with semicolon

Dấu chấm phẩy chỉ phân tách hai lệnh.

```
echo "i am first" ; echo "i am second" ; echo " i am third"
```

## 48.5: Chuỗi lệnh với | - chaining commands with |

Các | lấy đầu ra của lệnh bên trái và chuyển nó dưới dạng đầu vào của lệnh bên phải. Xin lưu ý rằng điều này được thực hiện trong mộtvỏ con. Do đó, bạn không thể đặt giá trị của các vars của quá trình gọi trong một đường ống.

```
find . -type f -a -iname '*.mp3' | \
    while read filename; do
        mute --noise "$filename"
    done
```