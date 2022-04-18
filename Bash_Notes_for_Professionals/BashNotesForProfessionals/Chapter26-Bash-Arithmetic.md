# Chapter 26: Bash Arithmetic

Tham số|Thông tin chi tiết|
|---|---|
EXPRESSION| Biểu thức để đánh giá|

##  26.1: Simple arithmetic with (( )) - Số học đơn giản với (())

```
#!/bin/bash
echo $(( 1 + 2 ))
```

Đầu ra: 3

```
# Using variables
#!/bin/bash
var1=4
var2=5
((output=$var1 * $var2))
printf "%d\n" "$output"
```
Output: 20

##  26.2: Arithmetic command - Lệnh số học

- let

```
let num=1+2
let num="1+2"
let 'num= 1 + 2'
let num=1 num+=2
```

Bạn cần dấu ngoặc kép nếu có khoảng trắng hoặc ký tự nhấp nháy. Vì vậy, những người sẽ gặp lỗi:

```
let num = 1 + 2 #wrong
let 'num = 1 + 2' #right
let a[1] = 1 + 1 #wrong
let 'a[1] = 1 + 1' #right
```
- (( ))
```
((a=$a+1)) #add 1 to a
((a = a + 1)) #like above
((a += 1)) #like above
```
Chúng ta có thể sử dụng (( )) trong if . Một số ví dụ:

```
if (( a > 1 )); then echo "a is greater than 1"; fi
```

Đầu ra của (()) có thể được gán cho một biến:

```
result=$((a + 1))
```

Hoặc được sử dụng trực tiếp trong đầu ra:

```
echo "The result of a + 1 is $((a + 1))"
```

## 26.3: Simple arithmetic with expr - Số học đơn giản với expr

```
#!/bin/bash
expr 1 + 2
```
Output: 3