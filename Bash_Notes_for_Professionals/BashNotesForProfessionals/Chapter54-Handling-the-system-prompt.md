# Chapter 54: Handling the system prompt

|Escape|Mô tả|
|---|---|
\a|Một ký tự chuông.
\d|Ngày, ở định dạng "Ngày trong tuần, ngày trong tháng" (ví dụ: "Thứ ba ngày 26 tháng 5").
\D{FORMAT}|Định dạng được chuyển tới `strftime '(3) và kết quả được chèn vào chuỗi dấu nhắc; trống rỗngĐỊNH DẠNG dẫn đến biểu diễn thời gian theo ngôn ngữ cụ thể. Niềng răng là bắt buộc.
\e|Một nhân vật chạy trốn. Tất nhiên, \033 cũng hoạt động.
\h|Tên máy chủ, lên đến đầu tiên `. '. (tức là không có phần miền)
\H|Tên máy chủ cuối cùng với phần miền
\j|Số lượng công việc hiện được quản lý bởi shell.
\l|Tên cơ sở của tên thiết bị đầu cuối của shell.
\n|Một dòng mới.
\r|Dấu xuống dòng.
\s|Tên của trình bao, tên cơ sở của `$ 0 '(phần sau dấu gạch chéo cuối cùng).
\t|Thời gian, ở định dạng HH: MM: SS trong 24 giờ.
\T|Giờ, ở định dạng HH: MM: SS, 12 giờ.
@|Giờ, ở định dạng 12 giờ sáng / chiều.
\A|Giờ, ở định dạng HH: MM 24 giờ.
\u|Tên người dùng của người dùng hiện tại.
\v|Phiên bản của Bash (ví dụ: 2.00)
\V|Việc phát hành Bash, phiên bản + patchlevel (ví dụ: 2.00.0)
\w|Thư mục làm việc hiện tại, với $ HOME được viết tắt bằng dấu ngã (sử dụng $ PROMPT_DIRTRIM Biến đổi).
\W|Tên cơ sở của $ PWD, với $ HOME được viết tắt bằng dấu ngã.
!|Số lịch sử của lệnh này.
`#`|Số lệnh của lệnh này.
$|Nếu uid hiệu dụng là 0, # , nếu không thì $ .
\NNN|Ký tự có mã ASCII là giá trị bát phân NNN.
`\`|Dấu gạch chéo ngược.
`\[`|Bắt đầu một chuỗi các ký tự không in. Điều này có thể được sử dụng để nhúng một điều khiển đầu cuốitrình tự vào dấu nhắc.
`\]`|Kết thúc một chuỗi các ký tự không in được.

## 54.1: Sử dụng môi trường PROMPT_COMMAND Biến đổi - Using the PROMPT_COMMAND envrionment variable

Khi lệnh cuối cùng trong một cá thể bash tương tác được thực hiện, biến PS1 được đánh giá sẽ hiển thị. Trướcthực sự hiển thị bash PS1 xem PROMPT_COMMAND có được đặt hay không. Giá trị của var này phải là một giá trị có thể gọi đượcchương trình hoặc kịch bản. Nếu var này được đặt, chương trình / tập lệnh này được gọi là TRƯỚC KHI lời nhắc PS1 được hiển thị.

```
# chỉ là một hàm ngu ngốc, chúng tôi sẽ sử dụng để chứng minh
# chúng tôi kiểm tra ngày nếu Giờ là 12 và Phút thấp hơn 59
lunchbreak(){
    if (( $(date +%H) == 12 && $(date +%M) < 59 )); then
        # và in màu \ 033 [bắt đầu chuỗi thoát
        # 5; là thuộc tính nhấp nháy
        # 2; có nghĩa là đậm
        # 31 nói màu đỏ

        printf "\033[5;1;31mmind the lunch break\033[0m\n";
    else
        printf "\033[33mstill working...\033[0m\n";
    fi;
}
# kích hoạt nó
export PROMPT_COMMAND=lunchbreak
```

## 54.2: Sử dụng PS2 -  Using PS2

PS2 được hiển thị khi một lệnh kéo dài đến nhiều hơn một dòng và bash chờ nhiều lần nhấn phím hơn. Nó được hiển thịcũng vậy khi một lệnh ghép như **while ... do..done** và alike được nhập.

```
export PS2="would you please complete this command?\n"
# bây giờ nhập lệnh kéo dài đến ít nhất hai dòng để xem PS2
```

## 54.3: Sử dụng PS3 - Using PS3

Khi câu lệnh select được thực thi, nó sẽ hiển thị các mục đã cho có tiền tố là một số và sau đó hiển thị lời nhắc PS3:

```
export PS3=" To choose your language type the preceding number : "
select lang in EN CA FR DE; do
    # check input here until valid.
    break
done
```

## 54.4: Sử dụng PS4 - Using PS4
PS4 hiển thị khi bash ở chế độ gỡ lỗi.

```
#!/usr/bin/env bash

# bật gỡ lỗi
set -x

# định nghĩa một stupid_func

stupid_func(){
    echo I am line 1 of stupid_func
    echo I am line 2 of stupid_func
}

# thiết lập lời nhắc "DEBUG" PS4
export PS4='\nDEBUG level:$SHLVL subshell-level: $BASH_SUBSHELL \nsource-file:${BASH_SOURCE}
line#:${LINENO} function:${FUNCNAME[0]:+${FUNCNAME[0]}(): }\nstatement: '

# một câu lệnh bình thường
echo something

# lệnh gọi hàm
stupid_func

# một đường dẫn các lệnh chạy trong một vỏ con
( ls -l | grep 'x' )
```

## 54.5: Sử dụng PS1 - Using PS1

PS1 là dấu nhắc hệ thống bình thường chỉ ra rằng bash đợi các lệnh được nhập vào. Nó hiểu một sốtrình tự thoát và có thể thực thi các chức năng hoặc proxy. Vì bash phải đặt con trỏ sau màn hìnhnhắc, nó cần biết cách tính độ dài hiệu dụng của chuỗi dấu nhắc. Để chỉ ra không inchuỗi ký tự trong dấu ngoặc nhọn thoát biến PS1 được sử dụng: \ [ một chuỗi ký tự không in \ ] . Tất cả hiện hữunói đúng cho tất cả các PS * vars.

(Dấu mũ màu đen biểu thị con trỏ)

```
# mọi thứ không phải là một chuỗi thoát sẽ được in theo nghĩa đen

export PS1="literal sequence " # Lời nhắc bây giờ là:
literal sequence ▉

# \u == user \h == host \w == thư mục làm việc thực tế
# lưu ý các dấu ngoặc kép tránh diễn giải bằng shell

export PS1='\u@\h:\w > ' # \u == user, \h == host, \w dir làm việc thực tế
looser@host:/some/path > ▉

# thực thi một số lệnh trong PS1
# dòng sau sẽ đặt màu nền trước thành đỏ, nếu người dùng == root,
# else nó đặt lại các thuộc tính về mặc định
# $( (($ EUID == 0)) && tput setaf 1)
# sau, chúng tôi đặt lại các thuộc tính về mặc định với
# $ ( tput sgr0 )
# giả sử là root:
PS1="\[$( (($EUID == 0)) && tput setaf 1 \]\u\[$(tput sgr0)\]@\w:\w \$ "
looser@host:/some/path > ▉  # if not root else <red> root <default> 
```