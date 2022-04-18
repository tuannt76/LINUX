# Chapter 23: Scripting with Parameters - Scripting với tham số

## 23.1: Multiple Parameter Parsing - Phân tích cú pháp nhiều tham số

Để rất nhiều phân tích các thông số, cách ưa thích để làm điều này là sử dụng một trong khi vòng lặp, một trường hợp tuyên bố, và sự thay đổi .

shift được sử dụng để bật tham số đầu tiên trong chuỗi, làm cho giá trị trước đây là 2 đô la , bây giờ là 1 đô la . Điều này hữu ích choxử lý các đối số tại một thời điểm.

```
#! /bin/bash
# Tải các thông số do người dùng xác định
while [[ $# > 0 ]]
do
        case "$1" in
                -a|--valueA)
                        valA="$2"
                        shift
                        ;;
                -b|--valueB)
                        valB="$2"
                        shift
                        ;;
                --help|*)
                        echo "Usage:"
                        echo " --valueA \"value\""
                        echo " --valueB \"value\""
                        echo " --help"
                        exit 1
                        ;;
        esac
        shift
done

echo "A: $valA"
echo "B: $valB"
```

Đầu vào và đầu ra

```
$ ./multipleParams.sh --help
Usage:
    --valueA "value"
    --valueB "value"
    --help

$ ./multipleParams.sh
A:
B:

$ ./multipleParams.sh --valueB 2
A:
B: 2

$ ./multipleParams.sh --valueB 2 --valueA "hello world"
A: hello world
B: 2
```

## 23.2: Argument parsing using a for loop - Phân tích cú pháp đối số bằng vòng lặp for

Một ví dụ đơn giản cung cấp các tùy chọn:

Opt |Alt.Opt|Thông tin chi tiết|
|---|---|---|
-h|--help|Hiển thị trợ giúp
-v|--version|Hiển thị thông tin phiên bản
-dr path |--doc-root path |Một tùy chọn nhận tham số phụ (một đường dẫn)
-i|--install|Một tùy chọn boolean (true / false)
-*|--|Tùy chọn không hợp lệ

```
#!/bin/bash
dr=''
install=false

skip=false
for op in "$@";do
    if $skip;then skip=false;continue;fi
    case "$op" in
        -v|--version)
            echo "$ver_info"
            shift
            exit 0
            ;;
        -h|--help)
            echo "$help"
            shift
            exit 0
            ;;
        -dr|--doc-root)
            shift
            if [[ "$1" != "" ]]; then
                dr="${1/%\//}"
                shift
                skip=true
            else
                echo "E: Arg missing for -dr option"
                exit 1
            fi
            ;;
        -i|--install)
            install=true
            shift
            ;;
        -*)
            echo "E: Invalid option: $1"
            shift
            exit 1
            ;;
    esac
done
```

## 23.3: Wrapper script - Tập lệnh gói

Tập lệnh gói là một tập lệnh bao bọc một tập lệnh hoặc lệnh khác để cung cấp các chức năng bổ sung hoặc chỉ để thực hiệnmột cái gì đó ít tẻ nhạt hơn.

Ví dụ, `egrep` thực tế trong hệ thống GNU / Linux mới đang được thay thế bằng một tập lệnh trình bao bọc có tên là `egrep` . Đây là trông nó thế nào:

```
#!/bin/sh
exec grep -E "$@"
```

Vì vậy, khi bạn chạy egrep trong các hệ thống như vậy, bạn thực sự đang chạy grep -E với tất cả các đối số được chuyển tiếp.
Trong trường hợp chung, nếu bạn muốn chạy một tập lệnh / lệnh ví dụ exmp với một mexmp tập lệnh khác thì trình bao bọctập lệnh mexmp sẽ giống như sau:

```
#! /bin/sh
exmp "$@" # Thêm các tùy chọn khác trước "$@"
# or
#full/path/to/exmp "$@"
```
## 23.4: Accessing Parameters - Truy cập các tham số

Khi thực thi một tập lệnh Bash, các tham số được truyền vào tập lệnh được đặt tên phù hợp với vị trí của chúng: $ 1 làtên của tham số đầu tiên, $ 2 là tên của tham số thứ hai, v.v.

Một tham số bị thiếu chỉ đơn giản là đánh giá một chuỗi trống. Kiểm tra sự tồn tại của một tham số có thể được thực hiện như sau:

```
if [ -z "$1" ]; then
    echo "No argument supplied"
fi
```

**Nhận tất cả các thông số**

`$@` và `$*` là các cách tương tác với tất cả các tham số tập lệnh. Tham khảo trang người đàn ông Bash, chúng ta thấy rằng:

- `$*` : Mở rộng đến các tham số vị trí, bắt đầu từ một. Khi mở rộng xảy ra trong phạm vi képdấu ngoặc kép, nó mở rộng thành một từ duy nhất với giá trị của mỗi tham số được phân tách bằng ký tự đầu tiên củaBiến đặc biệt IFS.

- `$@` : Mở rộng đến các tham số vị trí, bắt đầu từ một. Khi mở rộng xảy ra trong phạm vi képdấu ngoặc kép, mỗi tham số mở rộng thành một từ riêng biệt.

**Nhận số lượng tham số**

`$#` nhận số lượng tham số được truyền vào một tập lệnh. Một trường hợp sử dụng điển hình sẽ là kiểm tra xemsố đối số được truyền:

```
if [ -z "$1" ]; then
    echo "Không có đối số được cung cấp"
fi
```

**Example 1**

Lặp lại tất cả các đối số và kiểm tra xem chúng có phải là tệp hay không:

```
for item in "$@"
do
    if [[ -f $item ]]; then
        echo "$item is a file"
    fi
done
```

**Example 2**

Lặp lại tất cả các đối số và kiểm tra xem chúng có phải là tệp hay không:

```
for (( i = 1; i <= $#; ++ i ))
do
    item=${@:$i:1}

    if [[ -f $item ]]; then
        echo "$item is a file"
    fi
done
```

## 23.5: Split string into an array in Bash - Tách chuỗi thành một mảng trong Bash

Giả sử chúng ta có một tham số String và chúng ta muốn chia nó bằng dấu phẩy

```
my_param="foo,bar,bash"
```

Để chia chuỗi này bằng dấu phẩy, chúng ta có thể sử dụng;

```
IFS=',' read -r -a array <<< "$my_param"
```

Ở đây, IFS là một biến đặc biệt được gọi là Dấu phân tách trường nội bộ , xác định ký tự hoặc các ký tự được sử dụng đểtách một mẫu thành các mã thông báo cho một số hoạt động.

Để truy cập một phần tử riêng lẻ:

```
echo "${array[0]}"
```

Để lặp lại các phần tử:

```
for element in "${array[@]}"
do
    echo "$element"
done
```

Để nhận cả chỉ mục và giá trị:

```
for index in "${!array[@]}"
do
    echo "$index ${array[index]}"
done
```