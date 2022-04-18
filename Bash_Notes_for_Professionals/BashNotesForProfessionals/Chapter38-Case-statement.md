# Chapter 38: Case statement

##  38.1: Simple case statement - Câu lệnh trường hợp đơn giản

Ở dạng đơn giản nhất được hỗ trợ bởi tất cả các phiên bản của bash, câu lệnh case thực thi trường hợp khớp với mẫu.;; toán tử ngắt sau trận đấu đầu tiên, nếu có.

```
#!/bin/bash

var=1
case $var in
1)
    echo "Antartica"
    ;;
2)
    echo "Brazil"
    ;;
3)
    echo "Cat"
    ;;
esac
```

Kết quả đầu ra:
```
Antartica
```
##  38.2: Case statement with fall through - Tuyên bố tình huống với sự suy giảm

Phiên bản ≥ 4.0

Kể từ bash 4.0, một nhà điều hành mới ; & được giới thiệu trong đó cung cấp cơ chế rơi .

```
#!/bin/bash

var=1
case $var in
1)
    echo "Antartica"
    ;&
2)
    echo "Brazil"
    ;&
3)
    echo "Cat"
    ;&
esac
```

Kết quả đầu ra:
```
Antartica
Brazil
Cat
```

## 38.3: Fall through only if subsequent pattern(s) match - Chỉ giảm nếu (các) mẫu tiếp theo khớp

Phiên bản ≥ 4.0

Kể từ Bash 4.0, điều hành khác ;; & được giới thiệu mà còn cung cấp rơi qua chỉ khi các mẫu trong(các) câu lệnh trường hợp tiếp theo, nếu có, khớp.

```
#!/bin/bash
var=abc
case $var in
a*)
    echo "Antartica"
    ;;&
xyz)
    echo "Brazil"
    ;;&
*b*)
    echo "Cat"
    ;;&
esac
```

Kết quả đầu ra:

```
Antartica
Cat
```

Trong ví dụ dưới đây, abc khớp với cả trường hợp thứ nhất và thứ ba nhưng không khớp với trường hợp thứ hai. Vì vậy, trường hợp thứ hai khôngThực thi.