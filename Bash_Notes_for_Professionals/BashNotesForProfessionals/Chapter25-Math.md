# Chapter 25: Math

## 25.1: Math using dc - Toán sử dụng dc

dc là một trong những chương trình lâu đời nhất trên Unix.

Nó sử dụng ký hiệu đánh bóng ngược , có nghĩa là trước tiên bạn xếp chồng các số, sau đó là các phép toán. Ví dụ 1 + 1 làđược viết dưới dạng 1 1+ .

Để in một phần tử từ đầu ngăn xếp, hãy sử dụng lệnh p

```
echo '2 3 + p' | dc
5

or

dc <<< '2 3 + p'
5
```

Bạn có thể in phần tử trên cùng nhiều lần

```
dc <<< '1 1 + p 2 + p'
2
4
```

Đối với số âm use _ prefix

```
dc <<< '_1 p'
-1
```

Bạn cũng có thể sử dụng các chữ cái viết hoa từ A đến F cho các số từ 10 đến 15 và . như một dấu thập phân

```
dc <<< 'A.4 p'
10.4
```

dc đang sử dụng độ chính xác dự phòng có nghĩa là độ chính xác chỉ bị giới hạn bởi bộ nhớ khả dụng. Theo mặc định,độ chính xác được đặt thành 0 số thập phân

```
dc <<< '4 3 / p'
1
```

Chúng ta có thể tăng độ chính xác bằng lệnh k . 2k sẽ sử dụng

```
dc <<< '2k 4 3 / p'
1.33

dc <<< '4k 4 3 / p'
1.3333
```

Bạn cũng có thể sử dụng nó trên nhiều dòng


```
dc << EOF
1 1 +
3 *
p
EOF
6
```

>bc là một bộ tiền xử lý cho dc .

## 25.2: Math using bash capabilities - Toán sử dụng khả năng bash

Tính toán số học cũng có thể được thực hiện mà không liên quan đến bất kỳ chương trình nào khác như sau:

Phép nhân:
```
echo $((5 * 2))
10
```

Chia:
```
echo $((5 / 2))
2
```

Modulo:
```
echo $((5 % 2))
1
```

Luỹ thừa:
```
echo $((5 ** 2))
25
```

## 25.3: Math using bc - Toán sử dụng bc

bc là một ngôn ngữ máy tính chính xác tùy ý. Nó có thể được sử dụng tương tác hoặc được thực thi từ dòng lệnh.

Ví dụ, nó có thể in ra kết quả của một biểu thức:

```
echo '2 + 3' | bc
5

echo '12 / 5' | bc
2
```

Đối với số học hậu động, bạn có thể nhập thư viện chuẩn bc -l :

```
echo '12 / 5' | bc -l
2.40000000000000000000
```

Nó có thể được sử dụng để so sánh các biểu thức:

```
echo '8 > 5' | bc
1

echo '10 == 11' | bc
0

echo '10 == 10 && 8 > 3' | bc
1
```

## 25.4: Math using expr - Toán sử dụng expr

`expr` hoặc Đánh giá biểu thức đánh giá một biểu thức và ghi kết quả vào đầu ra tiêu chuẩn

Số học cơ bản

```
expr 2 + 3
5
```

Khi nhân, bạn cần thoát khỏi dấu *

```
expr 2 \* 3
6
```

Bạn cũng có thể sử dụng các biến

```
a=2
expr $a + 3
5
```

Hãy nhớ rằng nó chỉ hỗ trợ số nguyên, vì vậy biểu thức như thế này

```
expr 3.0 / 2
```
**sẽ xuất hiện lỗi** expr: not a decimal number: '3.0' .

Nó hỗ trợ biểu thức chính quy để khớp với các mẫu

```
expr 'Hello World' : 'Hell\(.*\)rld'
o Wo
```

Hoặc tìm chỉ mục của ký tự đầu tiên trong chuỗi tìm kiếm

>Điều này sẽ gây ra lỗi cú pháp expr: trên Mac OS X , vì nó sử dụng BSD expr không cólệnh chỉ mục, trong khi expr trên Linux nói chung là GNU expr

```
expr index hello l
3

expr index 'hello' 'lo'
3
```