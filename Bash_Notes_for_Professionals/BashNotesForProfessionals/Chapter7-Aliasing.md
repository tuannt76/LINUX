
# Aliasing

``Shell alias`` là một cách đơn giản để tạo các lệnh mới hoặc đặt một tên gợi nhớ hơn cho các lệnh bằng mã của riêng bạn.

## 1: Bypass an alias
Sử dụng lệnh ls mà không cần tắt alias. Bạn có một số tùy chọn:

Sử dụng nội trang lệnh: lệnh ls
Sử dụng đường dẫn đầy đủ của lệnh: /bin/ls
Thêm \ vào bất kỳ đâu trong tên lệnh, ví dụ: \ls hoặc l\s
Sử dụng trích dẫn lệnh: “ls” hoặc ‘ls’

## 2: Create an Alias
alias key= 'command' hoặc alas key = 'command [option]' Khi sử dụng key như một lệnh để gắn cho command mà bạn đã khai báo.

Để bao gồm nhiều lệnh trong một alias, bạn có thể xâu chuỗi chúng lại với nhau bằng &&.

[root@localhost ~]# alias chao='echo "Xin" && echo "chao" && echo "Viet Nam" '
[root@localhost ~]# chao
Xin
chao
Viet Nam

## 3: Remove an alias

Để xóa alias hiện có, hãy sử dụng:

```
unalias {alias_name}
```
```
[root@localhost ~]# alias
alias chao='echo "test" && echo "alias" && echo "tuan" '
alias cp='cp -i'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
[root@localhost ~]# unalias test
[root@localhost ~]# test
```

-bash: chao: command not found

## 4: The BASH_ALIASES is an internal bash assoc array

Alias được đặt tên(Aliases) là các phím tắt của lệnh, người ta có thể xác định và sử dụng trong các phiên bản bash tương tác. Chúng được tổ chức trong một mảng kết hợp có tên BASH_ALIASES. Để sử dụng var này trong một script, nó phải được chạy trong một trình shell tương tác(interactive shell)

Tạo 1 file alias.sh rồi ghi script sau:

```
/bin/bash -li
# note the -li above! -l makes this behave like a login shell
# -i makes it behave like an interactive shell
#
# shopt -s expand_aliases will not work in most cases
echo There are ${#BASH_ALIASES[*]} aliases defined.
for ali in "${!BASH_ALIASES[@]}"; do
printf "alias: %-10s triggers: %s\n" "$ali" "${BASH_ALIASES[$ali]}"
done
Output
```

```
[root@localhost ~]# ./alias.sh
There are 10 aliases defined.
alias: grep       triggers: grep --color=auto
alias: egrep      triggers: egrep --color=auto
alias: mv         triggers: mv -i
alias: which      triggers: alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde
alias: fgrep      triggers: fgrep --color=auto
alias: ls         triggers: ls --color=auto
alias: ll         triggers: ls -l --color=auto
alias: cp         triggers: cp -i
alias: l.         triggers: ls -d .* --color=auto
alias: rm         triggers: rm -i
```

