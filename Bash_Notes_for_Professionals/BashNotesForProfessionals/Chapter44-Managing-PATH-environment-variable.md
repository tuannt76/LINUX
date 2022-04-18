# Chapter 44: Managing PATH environment variable(Quản lý môi trường PATH Biến đổi)



Tham số |Thông tin chi tiết
|---|---|
PATH| Biến môi trường đường dẫn|

## 44.1: Thêm đường dẫn đến biến môi trường PATH - Add a path to the PATH environment variable

Biến môi trường PATH thường được định nghĩa trong ~ / .bashrc hoặc ~ / .bash_profile hoặc / etc / profile hoặc ~ / .profile hoặc/etc/bash.bashrc (tệp cấu hình Bash cụ thể của distro)

```
$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:
/usr/lib/jvm/jdk1.8.0_92/bin:/usr/lib/jvm/jdk1.8.0_92/db/bin:/usr/lib/jvm/jdk1.8.0_92/jre/bin
```

Bây giờ, nếu chúng ta muốn thêm một đường dẫn (ví dụ ~ / bin ) vào biến PATH:

```
PATH=~/bin:$PATH
# or
PATH=$PATH:~/bin
```

Nhưng điều này sẽ chỉ sửa đổi PATH trong shell hiện tại (và con của nó). Khi bạn thoát khỏi trình bao, sửa đổi nàysẽ biến mất.

Để làm cho nó vĩnh viễn, chúng ta cần thêm bit mã đó vào tệp ~ / .bashrc (hoặc bất cứ thứ gì) và tải lại tệp.

Nếu bạn chạy mã sau (trong terminal), nó sẽ thêm ~ / bin vào PATH vĩnh viễn:

```
echo 'PATH=~/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
```

Giải trình:

- `echo 'PATH=~/bin:$PATH' >> ~/.bashrc` thêm dòng PATH = ~ / bin: $ PATH vào cuối tệp ~ / .bashrc (bạncó thể làm điều đó với một trình soạn thảo văn bản)
- `source ~/.bashrc` tải lại tệp ~ / .bashrc

Đây là một đoạn mã (chạy trong thiết bị đầu cuối) sẽ kiểm tra xem đường dẫn đã được đưa vào chưa và chỉ thêm đường dẫn nếu chưa:

```
path=~/bin # đường dẫn được đưa vào
bashrc=~/.bashrc # tệp bash sẽ được ghi và tải lại
# chạy đoạn mã sau chưa được sửa đổi
echo $PATH | grep -q "\(^\|:\)$path\(:\|/\{0,1\}$\)" || echo "PATH=\$PATH:$path" >> "$bashrc";
source "$bashrc"
```

## 44.2: Xóa một đường dẫn khỏi môi trường PATH Biến đổi - Remove a path from the PATH environment variable

Để xóa PATH khỏi biến môi trường PATH, bạn cần chỉnh sửa ~ / .bashrc hoặc ~ / .bash_profile hoặc / etc / profilehoặc ~ / .profile hoặc /etc/bash.bashrc (bản phân phối cụ thể) và xóa chỉ định cho đường dẫn cụ thể đó.

Thay vì tìm chính xác nhiệm vụ, bạn chỉ có thể thực hiện thay thế trong $ PATH trong giai đoạn cuối cùng của nó.

Thao tác sau sẽ xóa $ path khỏi $ PATH một cách an toàn :

```
path=~/bin
PATH="$(echo "$PATH" |sed -e "s#\(^\|:\)$(echo "$path" |sed -e 's/[^^]/[&]/g' -e
's/\^/\\^/g')\(:\|/\{0,1\}$\)#\1\2#" -e 's#:\+#:#g' -e 's#^:\|:$##g')"
```

Để làm cho nó vĩnh viễn, bạn sẽ cần thêm nó vào cuối tệp cấu hình bash của mình.

Bạn có thể làm điều đó theo một cách chức năng:

```
rpath(){
    for path in "$@";do
        PATH="$(echo "$PATH" |sed -e "s#\(^\|:\)$(echo "$path" |sed -e 's/[^^]/[&]/g' -e
's/\^/\\^/g')\(:\|/\{0,1\}$\)#\1\2#" -e 's#:\+#:#g' -e 's#^:\|:$##g')"
    done
    echo "$PATH"
}

PATH="$(rpath ~/bin /usr/local/sbin /usr/local/bin)"
PATH="$(rpath /usr/games)"
# etc ...
```

Điều này sẽ giúp bạn dễ dàng xử lý nhiều đường dẫn hơn.

Ghi chú:

- Bạn sẽ cần thêm các mã này vào tệp cấu hình Bash (~ / .bashrc hoặc bất cứ thứ gì).
- Chạy `source ~/.bashrc` để tải lại tệp cấu hình Bash (~ / .bashrc)