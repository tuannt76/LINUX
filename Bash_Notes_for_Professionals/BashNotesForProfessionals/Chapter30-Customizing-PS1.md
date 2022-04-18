# Chapter 30: Customizing PS1

## 30.1: Colorize and customize terminal prompt - Tô màu và tùy chỉnh lời nhắc đầu cuối

Đây là cách tác giả đặt biến PS1 cá nhân của họ :

```
gitPS1(){
    gitps1=$(git branch 2>/dev/null | grep '*')
    gitps1="${gitps1:+ (${gitps1/#\* /})}"
    echo "$gitps1"
}
# Vui lòng sử dụng chức năng dưới đây nếu bạn là người dùng mac
gitPS1ForMac(){
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
timeNow(){
    echo "$(date +%r)"
}
if [ "$color_prompt" = yes ]; then
    if [ x$EUID = x0 ]; then
        PS1='\[\033[1;38m\][$(timeNow)]\[\033[00m\]
\[\033[1;31m\]\u\[\033[00m\]\[\033[1;37m\]@\[\033[00m\]\[\033[1;33m\]\h\[\033[00m\]
\[\033[1;34m\]\w\[\033[00m\]\[\033[1;36m\]$(gitPS1)\[\033[00m\] \[\033[1;31m\]:/#\[\033[00m\] '
    else
        PS1='\[\033[1;38m\][$(timeNow)]\[\033[00m\]
\[\033[1;32m\]\u\[\033[00m\]\[\033[1;37m\]@\[\033[00m\]\[\033[1;33m\]\h\[\033[00m\]
\[\033[1;34m\]\w\[\033[00m\]\[\033[1;36m\]$(gitPS1)\[\033[00m\] \[\033[1;32m\]:/$\[\033[00m\] '
    fi
else
    PS1='[$(timeNow)] \u@\h \w$(gitPS1) :/$ '
fi
```

Và đây là cách lời nhắc của tôi trông như thế nào:Màu tham khảo:
```
# Màu sắc
txtblk = '\ e [0; 30m' # Đen - Thường
txtred = '\ e [0; 31m' # Đỏ
txtgrn = '\ e [0; 32m' # Xanh lục
txtylw = '\ e [0; 33m' # Màu vàng
txtblu = '\ e [0; 34m' # Xanh lam
txtpur = '\ e [0; 35ph' # Tím
txtcyn = '\ e [0; 36m' # Lục lam
txtwht = '\ e [0; 37m' # Trắng
bldblk = '\ e [1; 30m' # Đen - Đậm
bldred = '\ e [1; 31m' # Đỏ
bldgrn = '\ e [1; 32m' # Xanh lục
bldylw = '\ e [1; 33m' # Màu vàng
bldblu = '\ e [1; 34m' # Xanh lam
bldpur = '\ e [1; 35m' # Tím
bldcyn = '\ e [1; 36m' # Lục lam
bldwht = '\ e [1; 37m' # Trắng
unablk = '\ e [4; 30m' # Đen - Gạch chân
undred = '\ e [4; 31m' # Đỏ
undgrn = '\ e [4; 32m' # Xanh lục
undylw = '\ e [4; 33m' # Màu vàng
undblu = '\ e [4; 34m' # Xanh lam
undpur = '\ e [4; 35m' # Tím
undcyn = '\ e [4; 36m' # Lục lam
undwht = '\ e [4; 37m' # Trắng
bakblk = '\ e [40 phút'# Phông nền màu đen
bakred = '\ e [41 phút'# Màu đỏ
badgrn = '\ e [42 phút'# Màu xanh lá
bakylw = '\ e [43 phút'# Màu vàng
bakblu = '\ e [44 phút'# Màu xanh lam
bakpur = '\ e [45 phút'# Màu tía
bakcyn = '\ e [46 phút'# Lục lam
bakwht = '\ e [47 phút'# Trắng
txtrst = '\ e [0ph'# Đặt lại văn bản
```

Ghi chú:
- Thực hiện các thay đổi trong ~ / .bashrc hoặc / etc / bashrc hoặc ~ / .bash_profile hoặc ~. / tệp hồ sơ (tùy thuộc vàoOS) và lưu nó.
- Đối với thư mục gốc bạn cũng có thể cần phải chỉnh sửa các / vv / bash.bashrc hoặc / gốc / .bashrc tập tin
- Chạy mã nguồn ~ / .bashrc (bản phân phối cụ thể) sau khi lưu tệp.

**Lưu ý:** nếu bạn đã lưu các thay đổi trong ~ / .bashrc , thì hãy nhớ thêm nguồn ~ / .bashrc vào~ / .bash_profile để thay đổi này trong PS1 sẽ được ghi lại mỗi khi ứng dụng Terminal khởi động.


## 30.2:Show git branch name in terminal prompt - Hiển thị tên chi nhánh git trong dấu nhắc đầu cuối

Bạn có thể có các hàm trong biến PS1, chỉ cần đảm bảo trích dẫn duy nhất nó hoặc sử dụng thoát cho các ký tự đặc biệt:

```
gitPS1(){
    gitps1=$(git branch 2>/dev/null | grep '*')
    gitps1="${gitps1:+ (${gitps1/#\* /})}"
    echo "$gitps1"
}
PS1='\u@\h:\w$(gitPS1)$ '
```
Nó sẽ cung cấp cho bạn một lời nhắc như sau:

```
user@Host:/path (master)$
```

Ghi chú:
- Thực hiện các thay đổi trong ~ / .bashrc hoặc / etc / bashrc hoặc ~ / .bash_profile hoặc ~. / tệp hồ sơ (tùy thuộc vàoOS) và lưu nó.
- Chạy mã nguồn ~ / .bashrc (bản phân phối cụ thể) sau khi lưu tệp.

## 30.3:Show time in terminal prompt - Hiển thị thời gian trong lời nhắc đầu cuối

```
timeNow(){
    echo "$(date +%r)"
}
PS1='[$(timeNow)] \u@\h:\w$ '
```

Nó sẽ cung cấp cho bạn một lời nhắc như sau:

```
[05:34:37 PM] user@Host:/path$
```

Ghi chú:

- Thực hiện các thay đổi trong ~ / .bashrc hoặc / etc / bashrc hoặc ~ / .bash_profile hoặc ~. / tệp hồ sơ (tùy thuộc vàoOS) và lưu nó.

- Chạy mã nguồn ~ / .bashrc (bản phân phối cụ thể) sau khi lưu tệp.

## 30.4: Show a git branch using PROMPT_COMMAND - Hiển thị một nhánh git bằng PROMPT_COMMAND

Nếu bạn đang ở trong một thư mục của kho lưu trữ git, có thể rất tuyệt khi hiển thị nhánh hiện tại mà bạn đang sử dụng. Trong ~ / .bashrc hoặc/ etc / bashrc thêm phần sau (cần có git để cái này hoạt động):

```
function prompt_command {
    # Kiểm tra xem chúng ta có đang ở trong kho lưu trữ git không
    if git status > /dev/null 2>&1; then
        # Chỉ lấy tên của chi nhánh
        export GIT_STATUS=$(git status | grep 'On branch' | cut -b 10-)
    else
        export GIT_STATUS=""
    fi
}
# Hàm này được gọi mỗi khi PS1 được hiển thị
PROMPT_COMMAND=prompt_command

PS1="\$GIT_STATUS \u@\h:\w\$ "
```

Nếu chúng ta đang ở trong một thư mục bên trong kho lưu trữ git, điều này sẽ xuất ra:

>branch user@machine:~$

Và nếu chúng ta đang ở trong một thư mục bình thường:

>user@machine:~$

## 30.5:Change PS1 prompt - Thay đổi lời nhắc PS1

Để thay đổi PS1, bạn chỉ cần thay đổi giá trị của biến shell PS1. Giá trị có thể được đặt trong ~ / .bashrc hoặc/ etc / bashrc tệp, tùy thuộc vào bản phân phối. PS1 có thể được thay đổi thành bất kỳ văn bản thuần túy nào như:

```
PS1="hello "
```

Bên cạnh văn bản thuần túy, một số ký tự đặc biệt thoát ra sau dấu gạch chéo ngược được hỗ trợ:

Định dạng|Hoạt động|
|---|---|
\a |một ký tự chuông ASCII (07)
\d|ngày ở định dạng “Ngày trong tuần, ngày trong tháng” (ví dụ: “Thứ ba ngày 26 tháng 5”)
\D{format}|định dạng được chuyển tới strftime (3) và kết quả được chèn vào chuỗi dấu nhắc; một định dạng trốngdẫn đến biểu diễn thời gian theo ngôn ngữ cụ thể. Niềng răng là bắt buộc
\e|một ký tự thoát ASCII (033)
\h|tên máy chủ cho đến đầu tiên '.'
\H|tên máy chủ
\j|số lượng công việc hiện được quản lý bởi shell
\l|tên cơ sở của tên thiết bị đầu cuối của shell
\n|dòng mới
\r|vận chuyển trở lại
\s|tên của trình bao, tên cơ sở của $ 0 (phần sau dấu gạch chéo cuối cùng)
\t|thời gian hiện tại ở định dạng HH: MM: SS 24 giờ
\T|thời gian hiện tại ở định dạng HH: MM: SS 12 giờ
\@|thời gian hiện tại ở định dạng 12 giờ sáng / chiều
\A|thời gian hiện tại ở định dạng HH: MM 24 giờ
\u|tên người dùng của người dùng hiện tại
\v|phiên bản của bash (ví dụ: 2,00)
\V|phát hành bash, phiên bản + cấp bản vá (ví dụ: 2.00.0)
\w|thư mục làm việc hiện tại, với $ HOME được viết tắt bằng dấu ngã
\W|tên cơ sở của thư mục làm việc hiện tại, với $ HOME được viết tắt bằng dấu ngã
\ !|số lịch sử của lệnh này
\ #|số lệnh của lệnh này|
|\ \$|nếu UID hiệu dụng là 0 thì a #, nếu không thì là $
\nnn*|ký tự tương ứng với số bát phân nnn|
\ |dấu gạch chéo ngược
\ [|bắt đầu một chuỗi các ký tự không in, có thể được sử dụng để nhúng điều khiển đầu cuốitrình tự vào lời nhắc
\ ]|kết thúc một chuỗi các ký tự không in được

Vì vậy, ví dụ, chúng ta có thể đặt PS1 thành:

```
PS1="\u@\h:\w\$ "
```

Và nó sẽ xuất ra:

>user@machine:~$

## 30.6:Show previous command return status and time - Hiển thị trạng thái và thời gian trả lại lệnh trước đó

Đôi khi chúng ta cần một gợi ý trực quan để chỉ ra trạng thái trả về của lệnh trước đó. Đoạn mã sau tạođặt nó ở đầu của PS1.

Lưu ý rằng hàm __stat () nên được gọi mỗi khi một PS1 mới được tạo, nếu không nó sẽ dính vàotrả về trạng thái của lệnh cuối cùng của .bashrc hoặc .bash_profile của bạn.

```
# -ANSI-COLOR-CODES- #
Color_Off="\033[0m"
###-Regular-###
Red="\033[0;31m"
Green="\033[0;32m"
Yellow="\033[0;33m"
####-Bold-####

function __stat() {
    if [ $? -eq 0 ]; then
        echo -en "$Green ✔ $Color_Off "
    else
        echo -en "$Red ✘ $Color_Off "
    fi
}

PS1='$(__stat)'
PS1+="[\t] "
PS1+="\e[0;33m\u@\h\e[0m:\e[1;34m\w\e[0m \n$ "

export PS1
```