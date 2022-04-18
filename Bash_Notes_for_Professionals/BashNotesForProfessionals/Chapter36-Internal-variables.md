# Chapter 36: Internal variables

Tổng quan về các biến nội bộ của Bash, ở đâu, như thế nào và khi nào sử dụng chúng.

## 36.1: Bash internal variables at a glance - Tóm tắt các biến nội bộ

Biến đổi|Thông tin chi tiết
|---|---|
||Tham số vị trí của hàm / tập lệnh (đối số). Mở rộng như sau:
`$* / $@`|`$*` và `$@` giống như `$1` `$2` ... (lưu ý rằng nói chung không có ý nghĩa gì khi bỏ không được trích dẫn) "`$*`" giống với "`$1 $2 ...`" 1  "`$@`" giống với "`$1`" "`$2`" ...1. Các đối số được phân tách bằng ký tự đầu tiên của $IFS, ký tự này không nhất thiết phải là khoảng trắng.
$#|Số lượng tham số vị trí được truyền cho tập lệnh hoặc hàm
$!|ID quy trình của lệnh cuối cùng (gần nhất cho đường ống) trong công việc gần đây nhất được đưa vàonền (lưu ý rằng nó không nhất thiết phải giống với ID nhóm quy trình của công việc khi kiểm soát công việcđược kích hoạt)
$$|ID của quá trình đã thực thi bash
$?|Trạng thái thoát của lệnh cuối cùng
$n|Tham số vị trí, trong đó n = 1, 2, 3, ..., 9
${n}|Tham số vị trí (tương tự như trên), nhưng n có thể> 9
$0|Trong tập lệnh, đường dẫn mà tập lệnh được gọi; với bash -c 'printf "% s \ n" "$ 0"' tênargs ' : tên (đối số đầu tiên sau khi kịch bản nội tuyến), nếu không, argv [ 0 ] mà bash nhận.
$_|Trường cuối cùng của lệnh cuối cùng
$IFS|Dấu tách trường nội bộ
$PATH|Biến môi trường PATH được sử dụng để tra cứu các tệp thực thi
$OLDPWD|Thư mục làm việc trước đó
$PWD|Trình bày thư mục làm việc
$FUNCNAME|Mảng tên hàm trong ngăn xếp lệnh gọi thực thi
$BASH_SOURCE|Mảng chứa đường dẫn nguồn cho các phần tử trong mảng FUNCNAME . Có thể được sử dụng để lấy đường dẫn script.
$BASH_ALIASES| Mảng liên kết chứa tất cả các bí danh hiện được xác định
$BASH_REMATCH| Chuỗi kết quả phù hợp từ trận đấu regex gần đây nhất
$BASH_VERSION |Chuỗi phiên bản bash
$BASH_VERSINFO| Một mảng gồm 6 phần tử với thông tin phiên bản Bash
$BASH|Absolute đường dẫn đến hiện đang thực hiện Bash shell bản thân (heuristically xác định bởi bash dựatrên argv [ 0 ] và giá trị của $PATH ; có thể sai trong các trường hợp góc)
$BASH_SUBSHELL| Cấp độ gói phụ Bash
$UIDID| người dùng thực (không hiệu quả nếu khác) của quá trình chạy bash
$PS1|Dấu nhắc dòng lệnh chính; xem Sử dụng các biến PS *
$PS2|Lời nhắc dòng lệnh phụ (được sử dụng cho đầu vào bổ sung)
$PS3|Lời nhắc dòng lệnh cấp ba (được sử dụng trong vòng lặp chọn)
$PS4|Dấu nhắc dòng lệnh bậc bốn (được sử dụng để nối thông tin với đầu ra dài dòng)
$RANDOM|Một số nguyên ngẫu nhiên giả từ 0 đến 32767
$REPLY|Biến được sử dụng theo cách đọc theo mặc định khi không có biến nào được chỉ định. Cũng được sử dụng bởi SELECT để trả vềgiá trị do người dùng cung cấp
$PIPESTATUS|Biến mảng giữ các giá trị trạng thái thoát của mỗi lệnh trong lần thực thi gần đây nhấtđường ống dẫn trước.

>Phép gán biến không được có khoảng trắng trước và sau. a = 123 không phải a = 123 . Cái sau (một dấu bằngđược bao quanh bởi dấu cách) trong sự cô lập có nghĩa là chạy lệnh a với các đối số = và 123 , mặc dù nó làcũng được thấy trong toán tử so sánh chuỗi (về mặt cú pháp là một đối số cho [ hoặc [[ hoặc bất kỳ cái nàothử nghiệm bạn đang sử dụng).

## 36.2: $ @

"`$@`" mở rộng thành tất cả các đối số dòng lệnh dưới dạng các từ riêng biệt. Nó khác với "$ *" , mở rộng thànhtất cả các đối số dưới dạng một từ duy nhất.

"`$@`" đặc biệt hữu ích để lặp qua các đối số và xử lý các đối số có dấu cách.

Hãy xem xét chúng ta đang ở trong một tập lệnh mà chúng ta gọi ra với hai đối số, như sau:

```
$ ./script.sh "␣1␣2␣" "␣3␣␣4␣"
```

Các biến `$*` hoặc `$@` sẽ mở rộng thành `$1␣$2` , lần lượt mở rộng thành `1␣2␣3␣4`, vì vậy vòng lặp bên dưới:

```
for var in $*; do # tương tự cho var trong $@; do
    echo \\<"$var"\\>
done
```
sẽ in cho cả hai

```
<1>
<2>
<3>
<4>
```

Trong khi "`$*`" sẽ được mở rộng thành `"$1␣ $2"` , lần lượt sẽ mở rộng thành "␣1␣2␣␣␣3␣␣4␣" và do đó, vòng lặp:

```
for var in "$*"; do
    echo \\<"$var"\\>
done
```

sẽ chỉ gọi echo một lần và sẽ in

```
<␣1␣2␣␣␣3␣␣4␣>
```

Và cuối cùng `"$@"` sẽ mở rộng thành `"$1"` `"$2"` , sẽ mở rộng thành `"␣1␣2␣"` `"␣3␣␣4␣"` và vòng lặp

```
for var in "$@"; do
    echo \\<"$var"\\>
done
```

do đó bảo tồn cả khoảng cách bên trong trong các đối số và sự phân tách các đối số. 
Lưu ý rằng xây dựng `for var in `"$@"` ; do ...` rất phổ biến và thành ngữ đến mức nó là mặc định cho vòng lặp for và có thể là rút gọn thành `for var; do ...` .

## 36.3: $#

Để nhận số lượng đối số dòng lệnh hoặc tham số vị trí - hãy nhập:

```
#!/bin/bash
echo "$#"
```

Khi chạy với ba đối số, ví dụ trên sẽ cho kết quả là:

```
~> $ ./testscript.sh firstarg secondarg thirdarg
3
```

## 36.4: $HISTSIZE

Số lệnh được nhớ tối đa:
```
~> $ echo $HISTSIZE
1000
```

## 36.5: $FUNCNAME

Để lấy tên của hàm hiện tại - gõ:

```
my_function()
{
    echo "This function is $FUNCNAME" # Điều này sẽ xuất ra "Chức năng này là chức năng của tôi"
}
```
Hướng dẫn này sẽ không trả về gì nếu bạn nhập nó bên ngoài hàm:

```
my_function

echo "This function is $FUNCNAME" # This will output "This function is"
```

## 36.6: $HOME

Thư mục chính của người dùng

```
~> $ echo $HOME
/home/user
```
##  36.7: $IFS

Chứa chuỗi Dấu phân tách trường nội bộ mà bash sử dụng để chia chuỗi khi lặp lại, v.v. Giá trị mặc định là màu trắngký tự khoảng trắng: \ n (dòng mới), \ t (tab) và dấu cách. Thay đổi điều này thành một thứ khác cho phép bạn chia các chuỗi bằng cách sử dụngcác ký tự khác nhau:

```
IFS=","
INPUTSTR="a,b,c,d"
for field in ${INPUTSTR}; do
    echo $field
done
```
Kết quả của phần trên là:

```
a
b
c
d
```

Ghi chú:
- Điều này là nguyên nhân của hiện tượng được gọi là tách từ.

## 36.8: $OLDPWD

**OLDPWD** (**OLDP**rint**W**orking**D**irectory) chứa thư mục trước lệnh cd cuối cùng :

```
~> $ cd directory
directory> $ echo $OLDPWD
/home/user
```

##  36.9: $PWD
**PWD** (**P**rint**W**orking**D**irectory) Thư mục làm việc hiện tại mà bạn đang ở tại thời điểm này:

```
~> $ echo $PWD
/home/user
~> $ cd directory
directory> $ echo $PWD
/home/user/directory
```

##  36.10: $1 $2 $3 etc..

Các tham số vị trí được truyền tới tập lệnh từ dòng lệnh hoặc một hàm:
```
#!/bin/bash
# $n là tham số vị trí thứ n
echo "$1"
echo "$2"
echo "$3"
```
Kết quả của phần trên là:
```
~> $ ./testscript.sh firstarg secondarg thirdarg
firstarg
secondarg
thirdarg
```

Nếu số lượng đối số vị trí lớn hơn chín, thì phải sử dụng dấu ngoặc nhọn.
```
# "set -" đặt các tham số vị trí
set -- 1 2 3 4 5 6 7 8 nine ten eleven twelve
# dòng sau sẽ xuất ra 10 chứ không phải 1 là giá trị của $1 chữ số 1
# sẽ được nối với số 0 sau
echo $10 # outputs 1
echo ${10} # outputs ten

# để hiển thị rõ ràng điều này:
set -- arg{1..12}
echo $10
echo ${10}
```

## 36.11: $*

Sẽ trả về tất cả các tham số vị trí trong một chuỗi duy nhất.

**testscript.sh:**

```
#!/bin/bash
echo "$*"
```

Chạy tập lệnh với một số đối số:
```
./testscript.sh firstarg secondarg thirdarg
```

Đầu ra:
```
firstarg secondarg thirdarg
```

## 36.12: $!

ID quy trình (pid) của công việc cuối cùng chạy trong nền:

```
~> $ ls &
testfile1 testfile2
[1]+ Done               ls
~> $ echo $!
21715
```

## 36.13: $?
Trạng thái thoát của hàm hoặc lệnh được thực thi gần đây nhất. Thông thường 0 sẽ có nghĩa là OK, bất kỳ điều gì khác sẽ cho biết thất bại:

```
~> $ ls *.blah;echo $?
ls: cannot access *.blah: No such file or directory
2~
> $ ls;echo $?
testfile1 testfile2
0
```

## 36.14: $$

ID quy trình (pid) của quy trình hiện tại:
```
~> $ echo $$
13246
```

## 36.15: $RANDOM

Mỗi khi tham số này được tham chiếu, một số nguyên ngẫu nhiên từ 0 đến 32767 sẽ được tạo ra. Gán giá trị cho

biến này tạo hạt giống cho trình tạo số ngẫu nhiên ( nguồn)

```
~> $ echo $RANDOM
27119
~> $ echo $RANDOM
1349
```

## 36.16: $BASHPID

ID quy trình (pid) của phiên bản Bash hiện tại. Điều này không giống với biến $$ , nhưng nó thường cung cấp cùng mộtkết quả. Tính năng này mới trong Bash 4 và không hoạt động trong Bash 3.

```
~> $ echo "\$\$ pid = $$ BASHPID = $BASHPID"
$$ pid = 9265 BASHPID = 9265
```

## 36.17: $BASH_ENV
Một biến môi trường trỏ đến tệp khởi động Bash được đọc khi một tập lệnh được gọi.

## 36.18: $BASH_VERSINFO

Một mảng chứa thông tin phiên bản đầy đủ được chia thành các phần tử, thuận tiện hơn nhiều so với $ BASH_VERSION nếubạn chỉ đang tìm kiếm phiên bản chính:

```
~> $ for ((i=0; i<=5; i++)); do echo "BASH_VERSINFO[$i] = ${BASH_VERSINFO[$i]}"; done
BASH_VERSINFO[0] = 3
BASH_VERSINFO[1] = 2
BASH_VERSINFO[2] = 25
BASH_VERSINFO[3] = 1
BASH_VERSINFO[4] = release
BASH_VERSINFO[5] = x86_64-redhat-linux-gnu
```

## 36.19: $BASH_VERSION

Hiển thị phiên bản bash đang chạy, điều này cho phép bạn quyết định xem bạn có thể sử dụng bất kỳ tính năng nâng cao nào hay không:
```
~> $ echo $BASH_VERSION
4.1.2(1)-release
```

##  36.20: $EDITOR

Trình chỉnh sửa mặc định sẽ được yêu cầu bởi bất kỳ tập lệnh hoặc chương trình nào, thường là vi hoặc emac.

```
~> $ echo $EDITOR
vi
```

## 36.21: $HOSTNAME

Tên máy chủ được gán cho hệ thống trong quá trình khởi động.

```
~> $ echo $HOSTNAME
mybox.mydomain.com
```

## 36.22: $HOSTTYPE

Biến này xác định phần cứng, nó có thể hữu ích trong việc xác định mã nhị phân nào sẽ thực thi:

```
~> $ echo $HOSTTYPE
x86_64
```

## 36.23: $MACHTYPE

Tương tự như $ HOSTTYPE ở trên, phần này cũng bao gồm thông tin về hệ điều hành cũng như phần cứng

```
~> $ echo $MACHTYPE
x86_64-redhat-linux-gnu
```

## 36.24: $OSTYPE

Trả về thông tin về loại hệ điều hành đang chạy trên máy, ví dụ:

```
~> $ echo $OSTYPE
linux-gnu
```

## 36.25: $PATH

Đường dẫn tìm kiếm để tìm mã nhị phân cho các lệnh. Các ví dụ phổ biến bao gồm /usr/bin và /usr/local/bin .

Khi người dùng hoặc tập lệnh cố gắng chạy một lệnh, các đường dẫn trong $PATH sẽ được tìm kiếm để tìm tệp phù hợpvới quyền thực thi.

Các thư mục trong $PATH được phân tách bằng ký tự :.

```
~> $ echo "$PATH"
/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin
```

Vì vậy, ví dụ, với $PATH ở trên , nếu bạn nhập lss tại dấu nhắc, trình bao sẽ tìm kiếm /usr/kerberos/bin/lss , sau đó /usr/local/bin/lss , sau đó /bin/lss , sau đó /usr/bin/lss , theo thứ tự này, trước kết luận rằng không có lệnh như vậy.

## 36.26: $PPID

ID quy trình (pid) của cha mẹ của tập lệnh hoặc trình bao, có nghĩa là tiến trình được gọi ra tập lệnh hoặc trình bao hiện tại.

```
~> $ echo $$
13016
~> $ echo $PPID
13015
```

##  36.27: $SECONDS

Số giây mà một tập lệnh đã được chạy. Điều này có thể trở nên khá lớn nếu được hiển thị trong shell:

```
~> $ echo $SECONDS
98834
```

## 36.28: $SHELLOPTS

Một danh sách chỉ đọc các tùy chọn cơ bản được cung cấp khi khởi động để kiểm soát hành vi của nó:

```
~> $ echo $SHELLOPTS
braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
```

## 36.29: $_

Xuất ra trường cuối cùng từ lệnh cuối cùng được thực thi, hữu ích để chuyển thứ gì đó trở đi cho thứ khácyêu cầu:

```
~> $ ls *.sh;echo $_
testscript1.sh testscript2.sh
testscript2.sh
```

Nó cung cấp đường dẫn tập lệnh nếu được sử dụng trước bất kỳ lệnh nào khác:

**test.sh:**
```
#!/bin/bash
echo "$_"
```

Đầu ra:

```
~> $ ./test.sh # running test.sh
./test.sh
```

Lưu ý: Đây không phải là cách dễ hiểu để lấy đường dẫn tập lệnh

## 36.30: $GROUPS

Một mảng chứa số lượng nhóm mà người dùng đang ở:

```
#!/usr/bin/env bash
echo You are assigned to the following groups:
for group in ${GROUPS[@]}; do
    IFS=: read -r name dummy number members < <(getent group $group )
    printf "name: %-10s number: %-15s members: %s\n" "$name" "$number" "$members"
done
```

## 36.31: $LINENO

Xuất ra số dòng trong tập lệnh hiện tại. Hầu hết hữu ích khi gỡ lỗi tập lệnh.

```
#!/bin/bash
# this is line 2
echo something # this is line 3
echo $LINENO # Will output 4
```

##  36.32: $SHLVL

Khi lệnh bash được thực hiện, một trình bao mới sẽ được mở. Biến môi trường $ SHLVL chứa sốcấp shell mà shell hiện tại đang chạy trên đó.

Trong một cửa sổ đầu cuối mới , việc thực hiện lệnh sau sẽ tạo ra các kết quả khác nhau dựa trên Linuxphân phối đang sử dụng.

```
echo $SHLVL
```

Sử dụng Fedora 25 , đầu ra là "3". Điều này chỉ ra rằng khi mở một trình bao mới, một lệnh bash ban đầu sẽ thực thivà thực hiện một nhiệm vụ. Lệnh bash ban đầu thực hiện một tiến trình con (một lệnh bash khác), đến lượt nó,thực hiện một lệnh bash cuối cùng để mở trình bao mới. Khi trình bao mới mở ra, nó đang chạy như một quy trình con của2 quy trình shell khác, do đó đầu ra là "3".

Trong ví dụ sau (với người dùng đang chạy Fedora 25), đầu ra của $ SHLVL trong một trình bao mới sẽ được đặt thành "3".Khi mỗi lệnh bash được thực thi, $ SHLVL sẽ tăng lên một.

```
~> $ echo $SHLVL
3~
> $ bash
~> $ echo $SHLVL
4~
> $ bash
~> $ echo $SHLVL
5
```

Người ta có thể thấy rằng việc thực thi lệnh 'bash' (hoặc thực thi một tập lệnh bash) sẽ mở ra một trình bao mới. Trong khi so sánh,tìm nguồn cung cấp một tập lệnh chạy mã trong trình bao hiện tại.

**test1.sh**
```
#!/usr/bin/env bash
echo "Hello from test1.sh. My shell level is $SHLVL"
source "test2.sh"
```

**test2.sh**

```
#!/usr/bin/env bash
echo "Hello from test2.sh. My shell level is $SHLVL"
```

**run.sh**

```
#!/usr/bin/env bash
echo "Hello from run.sh. My shell level is $SHLVL"
./test1.sh
```

**Execute:**
```
chmod +x test1.sh && chmod +x run.sh
./run.sh
```

Đầu ra:
```
Hello from run.sh. My shell level is 4
Hello from test1.sh. My shell level is 5
Hello from test2.sh. My shell level is 5
```

## 36.33: $UID

Biến chỉ đọc lưu trữ số ID của người dùng:

```
~> $ echo $UID
12345
```