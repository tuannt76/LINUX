# Chapter 20: Here documents and here strings - Đây là tài liệu và đây chuỗi


## 20.1:Execute command with here document - Thực thi lệnh với tài liệu tại đây

```
ssh -p 21 example@example.com <<EOF
    echo 'printing pwd'
    echo "\$(pwd)"
    ls -a
    find '*.txt'
EOF
```

$ bị thoát vì chúng tôi không muốn nó được mở rộng bởi shell hiện tại, tức là $ (pwd) sẽ được thực thi trênvỏ từ xa.


Cách khác:

```
ssh -p 21 example@example.com <<'EOF'
    echo 'printing pwd'
    echo "$(pwd)"
    ls -a
    find '*.txt'
EOF
```


Lưu ý : EOF đóng phải ở đầu dòng (Không có khoảng trắng trước). Nếu cần thụt lề,các tab có thể được sử dụng nếu bạn bắt đầu heredoc của mình bằng << - . Xem tài liệu Thụt lề tại đây và các ví dụ về Chuỗi giới hạnđể biết thêm thông tin.


## 20.2:Indenting here documents - Thụt lề tại đây tài liệu

Bạn có thể thụt lề văn bản bên trong tài liệu ở đây với các tab, bạn cần sử dụng toán tử << - redirection thay vì<< :

```
$ cat <<- EOF
    Đây là một số nội dung được thụt lề với các tab `\ t`.
    Bạn không thể thụt lề với những khoảng trắng mà bạn __have__ để sử dụng các tab.
    Bash sẽ xóa không gian trống trước các dòng này.
    __Lưu ý__: Đảm bảo thay thế khoảng trắng bằng các tab khi sao chép ví dụ này.
EOF

Đây là một số nội dung được thụt lề bằng các tab _ \ t_.
Bạn không thể thụt lề với những khoảng trắng mà bạn __have__ để sử dụng các tab.
Bash sẽ xóa không gian trống trước các dòng này.
__Lưu ý__: Đảm bảo thay thế khoảng trắng bằng các tab khi sao chép ví dụ này.
```

Một trường hợp sử dụng thực tế của điều này (như đã đề cập trong man bash ) là trong các tập lệnh shell, ví dụ:

```
if cond; then
    cat <<- EOF
    hello
    there
    EOF
fi
```

Thông thường, bạn nên thụt lề các dòng trong các khối mã như trong câu lệnh if này , để dễ đọc hơn. Không có << -


cú pháp toán tử, chúng tôi sẽ buộc phải viết mã trên như thế này:

```
if cond; then
    cat << EOF
hello
there
EOF
fi
```

Điều đó rất khó chịu khi đọc, và nó trở nên tồi tệ hơn nhiều trong một kịch bản thực tế phức tạp hơn.

## 20.3:Create a file - Tạo tệp

Cách sử dụng cổ điển của tài liệu ở đây là tạo tệp bằng cách nhập nội dung của nó:

```
cat > fruits.txt << EOF
apple
orange
lemon
EOF
```

Tài liệu ở đây là các dòng giữa << EOF và EOF .

Tài liệu này ở đây trở thành đầu vào của lệnh cat . Lệnh cat chỉ xuất ra đầu vào của nó và sử dụngtoán tử chuyển hướng đầu ra > chúng tôi chuyển hướng đến tệp fruit.txt .

Do đó, tệp fruit.txt sẽ chứa các dòng:

```
apple
orange
lemon
```

Các quy tắc thông thường của chuyển hướng đầu ra được áp dụng: nếu trước đó fruit.txt không tồn tại, nó sẽ được tạo. Nếu nó tồn tại trước đây,nó sẽ bị cắt bớt.

## 20.4:Here strings - Chuỗi đây

Phiên bản ≥ 2.05b

Bạn có thể cung cấp một lệnh bằng cách sử dụng tại đây các chuỗi như thế này:

```
$ awk '{print $2}' <<< "hello world - how are you?"
world

$ awk '{print $1}' <<< "hello how are you
> she is fine"
hello
she
```

Bạn cũng có thể nuôi sống một khi vòng lặp với một chuỗi ở đây:

```
$ while IFS=" " read -r word1 word2 rest
> do
> echo "$word1"
> done <<< "hello how are you - i am fine"
hello
```


## 20.5:Run several commands with sudo - Chạy một số lệnh với sudo

```
sudo -s <<EOF
    a='var'
    echo 'Running serveral commands with sudo'
    mktemp -d
    echo "\$a"
EOF
```

- $ a cần được thoát để ngăn nó được mở rộng bởi shell hiện tại

Hoặc

```
sudo -s <<'EOF'
    a='var'
    echo 'Running serveral commands with sudo'
    mktemp -d
    echo "$a"
EOF
```

## 20.6: Limit Strings - Chuỗi giới hạn

Một heredoc sử dụng chuỗi giới hạn để xác định thời điểm ngừng sử dụng đầu vào. Chuỗi giới hạn kết thúc phải

- Ở đầu dòng.
- Là văn bản duy nhất trên dòng Lưu ý: Nếu bạn sử dụng << - chuỗi giới hạn có thể được bắt đầu bằng các tab \ t

Chính xác:

```
cat <<limitstring
line 1
line 2
limitstring
```

Điều này sẽ xuất ra:

>line 1
line 2

Sử dụng sai:

```
cat <<limitstring
line 1
line 2
limitstring
```

Vì chuỗi giới hạn trên dòng cuối cùng không chính xác ở đầu dòng, nên trình bao sẽ tiếp tục đợi thêmđầu vào, cho đến khi nó nhìn thấy một dòng bắt đầu bằng chuỗi giới hạn và không chứa bất kỳ thứ gì khác. Chỉ sau đó nó sẽ dừng lạiđang đợi đầu vào và tiến hành chuyển tài liệu tại đây tới lệnh `cat` .

Lưu ý rằng khi bạn đặt trước chuỗi giới hạn ban đầu bằng dấu gạch ngang, bất kỳ tab nào ở đầu dòng sẽ bị xóa trước đóphân tích cú pháp, vì vậy dữ liệu và chuỗi giới hạn có thể được thụt lề bằng các tab (để dễ đọc trong các tập lệnh shell).

```
cat <<-limitstring
        line 1 has a tab each before the words line and has
            line 2 has two leading tabs
        limitstring
```

sẽ sản xuất

>line 1 has a tab each before the words line and has
line 2 has two leading tabs

với các tab đầu (nhưng không phải các tab bên trong) bị xóa.