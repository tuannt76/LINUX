# Chapter 21: Quoting - Trích dẫn



## 21.1: Double quotes for variable and command substitution - Dấu ngoặc kép cho biến và lệnh thay thế


Các phép thay thế biến chỉ nên được sử dụng bên trong dấu ngoặc kép.

```
calculation='2 * 3'
echo "$calculation" # prints 2 * 3
echo $calculation # prints 2, the list of files in the current directory, and 3
echo "$(($calculation))" # prints 6
```

Bên ngoài dấu ngoặc kép, `$var` nhận giá trị của var , chia nó thành các phần được phân cách bằng khoảng trắng và diễn giải từngmột phần dưới dạng mẫu hình cầu (ký tự đại diện). Trừ khi bạn muốn hành vi này, hãy luôn đặt `$var` bên trong dấu ngoặc kép: " $ var " .

Điều tương tự cũng áp dụng cho các thay thế lệnh: `$(mycommand)` là đầu ra của mycommand , `$(mycommand)` là kết quả của phép chia + cầu trên đầu ra.

```
echo "$var" # good
echo "$(mycommand)" # good
another=$var # also works, assignment is implicitly double-quoted
make -D THING=$var # BAD! This is not a bash assignment.
make -D THING="$var" # good
make -D "THING=$var" # also good
```

Các lệnh thay thế có ngữ cảnh trích dẫn của riêng chúng. Viết các thay thế lồng nhau tùy ý rất dễ dàng vì trình phân tích cú pháp sẽ theo dõi độ sâu lồng nhau thay vì tham lam tìm kiếm ký tự đầu tiên `"` . StackOverflow Tuy nhiên, công cụ đánh dấu cú pháp phân tích cú pháp sai. Ví dụ:

```
echo "formatted text: $(printf "a + b = %04d" "${c}")" # “formatted text: a + b = 0000”
```

Các đối số biến cho một lệnh thay thế cũng phải được đặt trong dấu ngoặc kép bên trong các phần mở rộng:

```
echo "$(mycommand "$arg1" "$arg2")"
```

## 21.2: Difference between double quote and single quote - Sự khác biệt giữa dấu ngoặc kép và dấu ngoặc đơntrích dẫn

Dấu ngoặc kép |Trích dẫn duy nhất
|---|---|
Cho phép mở rộng biến| Ngăn chặn sự mở rộng có thể thay đổi
Cho phép mở rộng lịch sử nếu được bật|Ngăn chặn mở rộng lịch sử
Cho phép thay thế lệnh|Ngăn chặn việc thay thế lệnh
`*` và @ có thể có ý nghĩa đặc biệt|* và @ luôn là chữ
Có thể chứa cả trích dẫn đơn hoặc trích dẫn kép|Trích dẫn đơn không được phép bên trong báo giá đơn
$ , ` , " , \ có thể được thoát bằng \ để ngăn ý nghĩa đặc biệt của chúng |Tất cả chúng đều là chữ|

**Thuộc tính chung cho cả hai:**

- Ngăn chặn sự nhấp nháy
- Ngăn tách từ

Ex:

```
$ echo "!cat"
echo "cat file"
cat file
$ echo '!cat'
!cat
echo "\"'\""
"'"
$ a='var'
$ echo '$a'
$a
$ echo "$a"
var
```

## 21.3: Newlines and control characters - Dòng mới và ký tự điều khiển

Một dòng mới có thể được bao gồm trong một chuỗi được trích dẫn đơn hoặc chuỗi được trích dẫn kép. Lưu ý rằng dấu gạch chéo ngược-dòng mới khôngdẫn đến một dòng mới, ngắt dòng bị bỏ qua.

```
newline1='
'
newline2="
"
newline3=$'\n'
empty=\

echo "Line${newline1}break"
echo "Line${newline2}break"
echo "Line${newline3}break"
echo "No line break${empty} here"
```

Bên trong chuỗi ký tự đô la, có thể sử dụng ký tự gạch chéo ngược hoặc dấu gạch chéo ngược-bát phân để chèn các ký tự điều khiển, giống như trong nhiều các ngôn ngữ lập trình khác.

```
echo $'Tab: [\t]'
echo $'Tab again: [\009]'
echo $'Form feed: [\f]'
echo $'Line\nbreak'
```

## 21.4: Quoting literal text - Trích dẫn văn bản theo nghĩa đen

Tất cả các ví dụ trong đoạn này in dòng

```
!"#$&'()*;<=>? @[\]^`{|}~
```

Dấu gạch chéo ngược trích dẫn ký tự tiếp theo, tức là ký tự tiếp theo được hiểu theo nghĩa đen. Một ngoại lệ là một dòng mới:dấu gạch chéo ngược-dòng mới mở rộng thành chuỗi trống.

```
echo \!\"\#\$\&\'\(\)\*\;\<\=\>\?\ \ \@\[\\\]\^\`\{\|\}\~
```

Tất cả văn bản giữa các dấu nháy đơn (dấu ngoặc kép ' , còn được gọi là dấu nháy đơn) được in theo nghĩa đen. Dấu gạch chéo ngược chẵn là viết tắt của chính nó, và không thể bao gồm một trích dẫn duy nhất; thay vào đó, bạn có thể dừng chuỗi ký tự, bao gồm một ký tựmột câu trích dẫn có dấu gạch chéo ngược và bắt đầu lại chuỗi ký tự. Do đó, dãy 4 ký tự '\' ' cho phép một cách hiệu quảđể bao gồm một trích dẫn duy nhất trong một chuỗi ký tự.

```
echo '!"#$&'\''()*;<=>? @[\]^`{|}~'
#       ^^^^
```

Dollar-single-quote bắt đầu một chuỗi ký tự $'…' giống như nhiều ngôn ngữ lập trình khác, trong đó dấu ngoặc képký tự tiếp theo.

```
echo $'!"#$&\'()*;<=>? @[\\]^`{|}~'
#       ^^      ^^
```

Dấu ngoặc kép " phân tách các chuỗi bán chữ trong đó chỉ các ký tự " \ $ và ` giữ lại ý nghĩa đặc biệt của chúng. Các ký tự này cần có một dấu gạch chéo ngược trước chúng (lưu ý rằng nếu dấu gạch chéo ngược được theo sau bởi một số ký tự khác, thìdấu gạch chéo ngược vẫn còn). Dấu ngoặc kép chủ yếu hữu ích khi bao gồm một biến hoặc một lệnh thay thế.

```
echo "!\"#\$&'()*;<=>? @[\\]^\`{|}~"
#       ^^          ^^  ^^
echo "!\"#\$&'()*;<=>? @[\]^\`{|}~"
#       ^^          ^   ^^ \[ prints \[
```
    
Tương tác, hãy cẩn thận ! kích hoạt mở rộng lịch sử bên trong dấu ngoặc kép: "! oops" tìm kiếm lệnh cũ hơnchứa oops ; "\! oops" không mở rộng lịch sử nhưng giữ dấu gạch chéo ngược. Điều này không xảy ra trong các tập lệnh.