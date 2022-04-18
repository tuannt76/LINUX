# Chapter 22: Conditional Expressions - Biểu thức có điều kiện

## 22.1: File type tests - Kiểm tra loại tệp

Các -e kiểm tra có điều kiện khai thác xem một tập tin tồn tại (bao gồm tất cả các loại tập tin: danh bạ, vv).

```
if [[ -e $filename ]]; then
echo "$filename exists"
fi
```

Cũng có các bài kiểm tra cho các loại tệp cụ thể.

```
if [[ -f $filename ]]; then
echo "$filename is a regular file"
elif [[ -d $filename ]]; then
echo "$filename is a directory"
elif [[ -p $filename ]]; then
echo "$filename is a named pipe"
elif [[ -S $filename ]]; then
echo "$filename is a named socket"
elif [[ -b $filename ]]; then
echo "$filename is a block device"
elif [[ -c $filename ]]; then
echo "$filename is a character device"
fi
if [[ -L $filename ]]; then
echo "$filename is a symbolic link (to any file type)"
fi
```

Đối với một liên kết tượng trưng, ​​ngoài L , những kiểm tra này áp dụng cho mục tiêu và trả về false cho một liên kết bị hỏng.

```
if [[ -L $filename || -e $filename ]]; then
echo "$filename exists (but may be a broken symbolic link)"
fi
if [[ -L $filename && ! -e $filename ]]; then
echo "$filename is a broken symbolic link"
fi
```


## 22.2: String comparison and matching - So sánh và đối sánh chuỗi

So sánh chuỗi sử dụng toán tử == giữa các chuỗi được trích dẫn . Các ! = Điều hành phủ nhận sự so sánh.

```
if [[ "$string1" == "$string2" ]]; then
echo "\$string1 and \$string2 are identical"
fi
if [[ "$string1" != "$string2" ]]; then
echo "\$string1 and \$string2 are not identical"
fi
```

Nếu phía bên phải không được trích dẫn thì đó là một mẫu ký tự đại diện mà $ string1 được so khớp với.

```
string='abc'
pattern1='a*'
pattern2='x*'
if [[ "$string" == $pattern1 ]]; then
    # the test is true
    echo "The string $string matches the pattern $pattern"
fi
if [[ "$string" != $pattern2 ]]; then
    # the test is false
    echo "The string $string does not match the pattern $pattern"
fi
```

Các toán tử < và > so sánh các chuỗi theo thứ tự từ vựng (không có nhỏ hơn hoặc bằng hoặc lớn hơn hoặc bằngtoán tử cho chuỗi).

Có các bài kiểm tra một lần cho chuỗi trống.

```
if [[ -n "$string" ]]; then
echo "$string is non-empty"
fi
if [[ -z "${string// }" ]]; then
echo "$string is empty or contains only spaces"
fi
if [[ -z "$string" ]]; then
echo "$string is empty"
fi
```

Ở trên, dấu kiểm -z có thể có nghĩa là $ string chưa được đặt hoặc nó được đặt thành một chuỗi trống. Để phân biệt giữa trống vàbỏ đặt, sử dụng:

```
if [[ -n "${string+x}" ]]; then
echo "$string is set, possibly to the empty string"
fi
if [[ -n "${string-x}" ]]; then
echo "$string is either unset or set to a non-empty string"
fi
if [[ -z "${string+x}" ]]; then
echo "$string is unset"
fi
if [[ -z "${string-x}" ]]; then
echo "$string is set to an empty string"
fi
```

trong đó x là tùy ý. Hoặc trongbảng biểu:


|$string is: | unset | empty | non-empty| 
|---|---|---|---|
| [[-z ${string}]] | true | true | false |
| [[-Z ${string + x}]] | true | false | false |
| [[-z ${string-x}]] | false | true | false |
| [[-n ${string}]] | false | false | true |
| [[-n ${string + x}]] | false | true | true |
| [[-n ${string-x}]] | true | false | true |

Ngoài ra, trạng thái có thể được kiểm tra trong một câu lệnh trường hợp:

```
case ${var+x$var} in
(x) echo empty;;
("") echo unset;;
(x*[![:blank:]]*) echo non-blank;;
(*) echo blank
esac
```

Trong đó [ : blank: ] là các ký tự giãn cách ngang cụ thể theo ngôn ngữ (tab, khoảng trắng, v.v.).

## 22.3: Test on exit status of a command - Kiểm tra trạng thái thoát lệnh

Trạng thái thoát 0: thành công
Trạng thái thoát khác 0: thất bại

Để kiểm tra trạng thái thoát của lệnh:

```
if command;then
    echo 'success'
else
    echo 'failure'
fi
```


## 22.4: One liner test - Kiểm tra một lớp lót

Bạn có thể làm những việc như sau:

```
[[ $s = 'something' ]] && echo 'matched' || echo "didn't match"
[[ $s == 'something' ]] && echo 'matched' || echo "didn't match"
[[ $s != 'something' ]] && echo "didn't match" || echo "matched"
[[ $s -eq 10 ]] && echo 'equal' || echo "not equal"
(( $s == 10 )) && echo 'equal' || echo 'not equal'
```

Kiểm tra một lớp lót cho trạng thái thoát:

```
command && echo 'exited with 0' || echo 'non 0 exit'
cmd && cmd1 && echo 'previous cmds were successful' || echo 'one of them failed'
cmd || cmd1 #If cmd fails try cmd1
```

## 22.5: File comparison - So sánh tệp

```
if [[ $file1 -ef $file2 ]]; then
    echo "$file1 and $file2 are the same file"
fi
```

“Tệp giống nhau” có nghĩa là việc sửa đổi một trong các tệp tại chỗ sẽ ảnh hưởng đến tệp còn lại. Hai tệp có thể giống nhau ngay cả khi chúngcó các tên khác nhau, chẳng hạn nếu chúng là các liên kết cứng hoặc nếu chúng là các liên kết tượng trưng với cùng một mục tiêu hoặc nếu mộtlà một liên kết tượng trưng trỏ đến cái kia.

Nếu hai tệp có cùng nội dung, nhưng chúng là các tệp riêng biệt (để việc sửa đổi một tệp không ảnh hưởng đến tệp kia), thì-ef báo cáo chúng là khác nhau. Nếu bạn muốn so sánh hai tệp từng byte, hãy sử dụng tiện ích cmp.

```
if cmp -s -- "$file1" "$file2"; then
    echo "$file1 and $file2 have identical contents"
else
    echo "$file1 and $file2 differ"
fi
```

Để tạo ra một danh sách có thể đọc được của con người về sự khác biệt giữa các tệp văn bản, hãy sử dụng tiện ích khác biệt .

```
if diff -u "$file1" "$file2"; then
    echo "$file1 và $file2 có nội dung giống hệt nhau"
else
    : # sự khác biệt giữa các tệp đã được liệt kê
fi
```

## 22.6: File access tests - Kiểm tra quyền truy cập tệp

```
if [[ -r $filename ]]; then
echo "$filename là một tệp có thể đọc được"
fi
if [[ -w $filename ]]; then
echo "$filename là một tệp có thể ghi"
fi
if [[ -x $filename ]]; then
echo "$filename là một tệp có thể thực thi"
fi
```

Các bài kiểm tra này có tính đến quyền và quyền sở hữu để xác định xem tập lệnh (hoặc các chương trình đã khởi chạytừ script) có thể truy cập tệp.

Coi chưng điều kiện cuộc đua (TOCTOU) : chỉ vì thử nghiệm thành công bây giờ không có nghĩa là nó vẫn hợp lệ trênhàng tiếp theo. Thông thường, tốt hơn là cố gắng truy cập vào một tệp và xử lý lỗi, thay vì kiểm tra trước và sau đó phảivẫn xử lý lỗi trong trường hợp tệp đã thay đổi trong thời gian chờ đợi.

## 22.7: Numerical comparisons - So sánh số

So sánh số sử dụng toán tử -eq và bạn

```
if [[ $num1 -eq $num2 ]]; then
    echo "$num1 == $num2"
fi
if [[ $num1 -le $num2 ]]; then
    echo "$num1 <= $num2"
fi
```

Có sáu toán tử số:

- `-eq` bằng
- `-ne` không bằng
- `-le` ít hơn hoặc bằng
- `-lt` ít hơn
- `-ge` lớn hơn hoặc bằng
- `-gt` lớn hơn

Lưu ý rằng các toán tử < và > bên trong `[[ … ]]` so sánh các chuỗi, không phải số.

```
if [[ 9 -lt 10 ]]; then
    echo "9 đứng trước 10 theo thứ tự số"
fi
if [[ 9 > 10 ]]; then
    echo "9 là sau 10 theo thứ tự lexicographic"
fi
```

Hai bên phải là số được viết dưới dạng thập phân (hoặc ở dạng bát phân với số 0 ở đầu). Ngoài ra, hãy sử dụng (( … )) cú pháp biểu thức số học, thực hiện các phép tính số nguyên trong cú pháp giống C / Java /….

```
x=2
if ((2*x == 4)); then
    echo "2 times 2 is 4"
fi
((x += 1))
echo "2 plus 1 is $x"
```