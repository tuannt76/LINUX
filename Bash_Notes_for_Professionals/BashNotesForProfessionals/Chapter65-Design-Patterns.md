# Chapter 65: Design Patterns

Hoàn thành một số mẫu thiết kế phổ biến trong Bash

## 65.1: Dạng xuất bản /đăng ký (Pub/Sub)

Khi một dự án Bash chuyển thành thư viện, việc thêm chức năng mới có thể trở nên khó khăn. Tên hàm, biếnvà các thông số thường cần được thay đổi trong các tập lệnh sử dụng chúng. Trong các tình huống như thế này, sẽ rất hữu ích đểtách mã và sử dụng mẫu thiết kế theo hướng sự kiện. Trong mẫu đã nói, một tập lệnh bên ngoài có thể đăng ký mộtbiến cố. Khi sự kiện đó được kích hoạt (xuất bản), tập lệnh có thể thực thi mã mà nó đã đăng ký với sự kiện.

**pubsub.sh:**
```
#!/usr/bin/env bash

#
# Lưu đường dẫn đến thư mục của tập lệnh này trong một biến env toàn cục
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#
# Mảng sẽ chứa tất cả các sự kiện đã đăng ký
#
EVENTS=()

function action1() {
    echo "Action #1 was performed ${2}"
}

function action2() {
    echo "Action #2 was performed"
}

#
# @desc :: Đăng ký sự kiện
# @param :: string $1 - Tên của sự kiện. Về cơ bản là một bí danh cho một tên hàm
# @param :: string $2 - Tên của hàm sẽ được gọi
# @param :: string $3 - Đường dẫn đầy đủ đến tập lệnh bao gồm hàm đang được gọi
#
function subscribe() {
    EVENTS+=("${1};${2};${3}")
}

#
# @desc :: Công khai sự kiện
# @param :: string $1 - Tên sự kiện đang được xuất bản
#
function publish() {
    for event in ${EVENTS[@]}; do
        local IFS=";"
        read -r -a event <<< "$event"
        if [[ "${event[0]}" == "${1}" ]]; then
            ${event[1]} "$@"
        fi
    done
}

#
# Đăng ký các sự kiện của chúng tôi và các chức năng xử lý chúng
#
subscribe "/do/work" "action1" "${DIR}"
subscribe "/do/more/work" "action2" "${DIR}"
subscribe "/do/even/more/work" "action1" "${DIR}"

#
# Thực hiện các sự kiện của chúng tôi
#
publish "/do/work"
publish "/do/more/work"
publish "/do/even/more/work" "again"
```

**Run:**

```
chmod +x pubsub.sh
./pubsub.sh
```