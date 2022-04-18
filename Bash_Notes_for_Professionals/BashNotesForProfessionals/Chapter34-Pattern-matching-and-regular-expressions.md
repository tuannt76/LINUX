# Chapter 34: Pattern matching and regular expressions

## 34.1:Get captured groups from a regex match against a string - Nhận các nhóm bị bắt từ một trận đấu regexchống lại một chuỗi

```
a='I am a simple string with digits 1234'
pat='(.*) ([0-9]+)'
[[ "$a" =~ $pat ]]
echo "${BASH_REMATCH[0]}"
echo "${BASH_REMATCH[1]}"
echo "${BASH_REMATCH[2]}"
```

Output:

```
I am a simple string with digits 1234
I am a simple string with digits
1234
```

## 34.2:Behaviour when a glob does not match anything - Hành vi khi một hình cầu không khớp với bất kỳ điều gì

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -u globstar
```

Trong trường hợp hình cầu không khớp với bất kỳ điều gì, kết quả được xác định bởi các tùy chọn nullglob và failglob . Nếu không trong số chúng được thiết lập, Bash sẽ trả về chính khối cầu nếu không có gì phù hợp

```
$ echo no*match
no*match
```

Nếu nullglob được kích hoạt thì không có gì ( null ) được trả về:

```
$ shopt -s nullglob
$ echo no*match

$
```

Nếu failglob được kích hoạt thì thông báo lỗi sẽ được trả về:

```
$ shopt -s failglob
$ echo no*match
bash: no match: no*match
$
```

Lưu ý rằng tùy chọn failglob thay thế tùy chọn nullglob , tức là, nếu cả nullglob và failglob đều được đặt, thì -trong trường hợp không khớp - một lỗi được trả lại.

## 34.3:Check if a string matches a regular expression - Kiểm tra xem một chuỗi có khớp với một biểu thức chính quy hay không

Phiên bản ≥ 3.0

Kiểm tra xem một chuỗi có chính xác 8 chữ số hay không:

```
$ date=20150624
$ [[ $date =~ ^[0-9]{8}$ ]] && echo "yes" || echo "no"
yes
$ date=hello
$ [[ $date =~ ^[0-9]{8}$ ]] && echo "yes" || echo "no"
no
```

## 34.4: Regex matching - Đối sánh Regex

```
pat='[^0-9]+([0-9]+)'
s='I am a string with some digits 1024'
[[ $s =~ $pat ]] # $pat must be unquoted
echo "${BASH_REMATCH[0]}"
echo "${BASH_REMATCH[1]}"
```

Output:

```
I am a string with some digits 1024
1024
```

Thay vì gán regex cho một biến ( $pat ), chúng ta cũng có thể làm:

```
[[ $s =~ [^0-9]+([0-9]+) ]]
```

**Giải trình**

- Cấu trúc `[[ $s =~ $pat ]]` thực hiện so khớp regex

- Các nhóm được bắt tức là kết quả đối sánh có sẵn trong một mảng có tên BASH_REMATCH

- Chỉ số thứ 0 trong mảng BASH_REMATCH là tổng số trận đấu
- Các i'th index trong BASH_REMATCH mảng là i'th bắt nhóm, nơi i = 1, 2, 3 ...

## 34.5: The * glob

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -u globstar
```


Dấu hoa thị * có lẽ là dấu cầu được sử dụng phổ biến nhất. Nó chỉ đơn giản là khớp với bất kỳ chuỗi nào

```
$ echo *acy
macy stacy tracy
```

Một dấu * duy nhất sẽ không khớp với các tệp và thư mục nằm trong các thư mục con

```
$ echo *
emptyfolder folder macy stacy tracy
$ echo folder/*
folder/anotherfolder folder/subfolder
```

## 34.6: The ** glob

Phiên bản ≥ 4.0

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -s globstar
```

Bash có thể giải thích hai dấu hoa thị liền kề như một hình cầu duy nhất. Với globstar tùy chọn kích hoạt này có thể được sử dụng để khớp với các thư mục nằm sâu hơn trong cấu trúc thư mục

```
echo **
emptyfolder folder folder/anotherfolder folder/anotherfolder/content
folder/anotherfolder/content/deepfolder folder/anotherfolder/content/deepfolder/file
folder/subfolder folder/subfolder/content folder/subfolder/content/deepfolder
folder/subfolder/content/deepfolder/file macy stacy tracy
```

Các ** có thể được coi là một mở rộng con đường, không có vấn đề như thế nào sâu con đường là. Ví dụ này khớp với bất kỳ tệp nào hoặcthư mục bắt đầu bằng sâu , bất kể độ sâu của nó được lồng vào nhau như thế nào:

```
$ echo **/deep*
folder/anotherfolder/content/deepfolder folder/subfolder/content/deepfolder
```


## 34.7: The ? glob

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -u globstar
```

Cái ? chỉ cần khớp chính xác một ký tự

```
$ echo ?acy
macy
$ echo ??acy
stacy tracy
```

## 34.8: The [ ] glob

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -u globstar
```

```
$ echo [m]acy
macy
$ echo [st][tr]acy
stacy tracy
```

Các [] glob, tuy nhiên, là linh hoạt hơn so với việc đó. Nó cũng cho phép đối sánh phủ định và thậm chí cả phạm vi đối sánhcủa các nhân vật và các lớp nhân vật. Một trận đấu tiêu cực đạt được bằng cách sử dụng ! hoặc ^ là ký tự đầu tiên sau [ .Chúng tôi có thể so khớp với stacy bằng

```
$ echo [!t][^r]acy
stacy
```

Ở đây chúng tôi đang nói với bash rằng chúng tôi chỉ muốn đối sánh các tệp không bắt đầu bằng chữ t và chữ cái thứ hai thì không.một r và tệp kết thúc bằng acy .

Các dải ô có thể được so khớp bằng cách phân tách một cặp ký tự bằng dấu gạch ngang ( - ). Bất kỳ ký tự nào nằm giữa những hai ký tự bao quanh - bao gồm - sẽ được đối sánh. Ví dụ: [ rt ] tương đương với [ rst ]

```
$ echo [r-t][r-t]acy
stacy tracy
```

Các lớp ký tự có thể được so khớp bởi [ : class: ] , ví dụ: để khớp với các tệp chứa khoảng trắng

```
$ echo *[[:blank:]]*
file with space
```

## 34.9: Matching hidden files - Khớp các tệp ẩn

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -u globstar
```

Tùy chọn dotglob tích hợp sẵn trong Bash cho phép khớp các tệp và thư mục ẩn, tức là các tệp và thư mục bắt đầu bằng a .

```
$ shopt -s dotglob
$ echo *
file with space folder .hiddenfile macy stacy tracy
```

## 34.10: Case insensitive matching - Đối sánh không phân biệt chữ hoa chữ thường

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -u globstar
```

Đặt tùy chọn nocaseglob sẽ khớp với hình cầu theo cách không phân biệt chữ hoa chữ thường

```
$ echo M*
M*
$ shopt -s nocaseglob
$ echo M*
macy
```

## 34.11: Extended globbing - Cầu vồng kéo dài

Phiên bản ≥ 2.02

**Sự chuẩn bị**

```
$ mkdir globbing
$ cd globbing
$ mkdir -p folder/{sub,another}folder/content/deepfolder/
touch macy stacy tracy "file with space" folder/{sub,another}folder/content/deepfolder/file
.hiddenfile
$ shopt -u nullglob
$ shopt -u failglob
$ shopt -u dotglob
$ shopt -u nocaseglob
$ shopt -u extglob
$ shopt -u globstar
```

Tùy chọn extglob tích hợp của Bash có thể mở rộng khả năng đối sánh của toàn cầu

```
shopt -s extglob
```

Các mẫu phụ sau đây bao gồm các hình cầu mở rộng hợp lệ:

- ? (pattern-list) - Đối sánh không hoặc một lần xuất hiện của các mẫu đã cho
- *(pattern-list) - Khớp với không hoặc nhiều lần xuất hiện của các mẫu đã cho
- +(pattern-list) - Khớp một hoặc nhiều lần xuất hiện của các mẫu đã cho
- @(pattern-list) - Khớp với một trong các mẫu đã cho
- !(pattern-list) - Khớp với bất kỳ thứ gì ngoại trừ một trong các mẫu đã cho

Các pattern-list là danh sách những đống phân cách bằng |.

```
$ echo *([r-t])acy
stacy tracy

$ echo *([r-t]|m)acy
macy stacy tracy

$ echo ?([a-z])acy
macy
```


Bản thân danh sách mẫu có thể là một toàn cầu mở rộng lồng nhau, được lồng vào nhau. Trong ví dụ trên, chúng ta đã thấy rằng chúng ta có thể đối sánh tracy và stacy với *( rt ) . Bản thân hình cầu mở rộng này có thể được sử dụng bên trong hình cầu mở rộng phủ định !(pattern-list) để khớp với macy

```
$ echo !(*([r-t]))acy
macy
```

Nó khớp với bất kỳ thứ gì không bắt đầu bằng không hoặc nhiều lần xuất hiện của các chữ cái r ,s và t ,chỉ để lại macy phù hợp nhất có thể.