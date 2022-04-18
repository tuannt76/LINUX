# Chapter 61: When to use eval - Khi nào sử dụng eval

Đầu tiên và quan trọng nhất: biết bạn đang làm gì! Thứ hai, trong khi bạn nên tránh sử dụng eval , nếu việc sử dụng nó làm chomã sạch hơn, hãy tiếp tục.

## 61.1: Sử dụng Eval

Ví dụ: hãy xem xét điều sau đây đặt nội dung của $ @ thành nội dung của một biến nhất định:

```
a=(1 2 3)
eval set -- "${a[@]}"
```

Mã này thường đi kèm với **getopt** hoặc **getopts** để đặt $ @ thành đầu ra của trình phân tích cú pháp tùy chọn nói trên,tuy nhiên, bạn cũng có thể sử dụng nó để tạo một hàm pop đơn giản có thể hoạt động trên các biến một cách âm thầm và trực tiếpmà không cần phải lưu trữ kết quả vào biến ban đầu:

```
isnum()
{
    # is argument an integer?
    local re='^[0-9]+$'
    if [[ -n $1 ]]; then
        [[ $1 =~ $re ]] && return 0
        return 1
    else
        return 2
    fi
}

isvar()
{
    if isnum "$1"; then
        return 1
    fi
    local arr="$(eval eval -- echo -n "\$$1")"
    if [[ -n ${arr[@]} ]]; then
        return 0
    fi
    return 1
}

pop()
{
    if [[ -z $@ ]]; then
        return 1
    fi

    local var=
    local isvar=0
    local arr=()

    if isvar "$1"; then # let's check to see if this is a variable or just a bare array
        var="$1"
        isvar=1
        arr=($(eval eval -- echo -n "\${$1[@]}")) # if it is a var, get its contents
    else
        arr=($@)
    fi

    # chúng ta cần đảo ngược nội dung của $ @ để có thể thay đổi
    # phần tử cuối cùng thành hư vô
    arr=($(awk <<<"${arr[@]}" '{ for (i=NF; i>1; --i) printf("%s ",$i); print $1; }'

    # đặt $ @ thành $ {arr [@]} để chúng tôi có thể thay đổi nó.
    eval set -- "${arr[@]}"

    shift   # loại bỏ phần tử cuối cùng

    # đặt mảng trở lại thứ tự ban đầu
    arr=($(awk <<<"$@" '{ for (i=NF; i>1; --i) printf("%s ",$i); print $1; }'

    # echo các nội dung vì lợi ích của người dùng và các mảng trống
    echo "${arr[@]}"

    if ((isvar)); then
        # đặt nội dung của var gốc thành mảng mới được sửa đổi
        eval -- "$var=(${arr[@]})"
    fi
}
```

## 61.2: Sử dụng Eval với Getopt

Mặc dù eval có thể không cần thiết cho hàm pop like, tuy nhiên, nó được yêu cầu bất cứ khi nào bạn sử dụng getopt :

Hãy xem xét hàm sau chấp nhận -h như một tùy chọn:

```
f()
{
    local __me__="${FUNCNAME[0]}"
    local argv="$(getopt -o 'h' -n $__me__ -- "$@")"
    eval set -- "$argv"
    while :; do
        case "$1" in
            -h)
                echo "LOLOLOLOL"
                return 0
                ;;
            --)
                shift
                break
                ;;
    done

    echo "$@"
}
```

Không có **eval set -- "$argv"** tạo ra
-h --
thay vì mong muốn (-h --) và sau đó đi vào một vòng lặp vô hạn vì
-h --
không khớp -- hoặc -h.