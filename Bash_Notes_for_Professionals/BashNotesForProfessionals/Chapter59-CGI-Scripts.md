# Chapter 59: CGI Scripts

## 59.1: Phương thức Yêu cầu: GET - Request Method: GET

Khá dễ dàng để gọi một CGI-Script thông qua GET .
Trước tiên, bạn sẽ cần url được mã hóa của tập lệnh.

Sau đó, bạn thêm một dấu chấm hỏi ? theo sau là các biến.

- Mọi biến phải có hai phần cách nhau bởi dấu = .
Phần đầu tiên phải luôn là một tên duy nhất cho mỗi biến,
trong khi phần thứ hai chỉ có các giá trị trong đó
- Các biến được phân tách bằng &
- Tổng độ dài của chuỗi không được vượt quá 255 ký tự
- Tên và giá trị cần được mã hóa html (thay thế: **< / , / ? : @ & = + $** )
**Dấu:**
Khi sử dụng **html-form** , phương thức yêu cầu có thể được tạo bởi chính nó.
Với **Ajax**, bạn có thể mã hóa tất cả thông qua **encodeURI** và **encodeURIComponent**

**Thí dụ:**
```
http://www.example.com/cgi-bin/script.sh?var1=Hello%20World!&var2=This%20is%20a%20Test.&
```

Máy chủ chỉ nên giao tiếp thông qua **Chia sẻ Tài nguyên Nhiều Nguồn gốc - Cross-Origin Resource Sharing (CORS)** để làm cho yêu cầu an toàn hơn. Trongtrưng bày này, chúng tôi sử dụng **CORS** để xác định Data-Type mà chúng tôi muốn sử dụng.

Có nhiều kiểu dữ liệu mà chúng ta có thể chọn, phổ biến nhất là ...

- **text/html**
- **text/plain**
- **application/json**

Khi gửi một yêu cầu, máy chủ cũng sẽ tạo ra nhiều biến môi trường. Cho đến bây giờ là quan trọng nhất các biến môi trường là `$REQUEST_METHOD` và `$QUERY_STRING` .

Các **Request Method** phải là GET không có gì khác!
Các **Query String** bao gồm tất cả các dữ liệu html-endoded .

**The Script**
```
#!/bin/bash

# CORS là cách để giao tiếp, vì vậy trước tiên hãy phản hồi với máy chủ

echo "Content-type: text/html"  # đặt kiểu dữ liệu mà chúng tôi muốn sử dụng
echo ""  # chúng ta không cần thêm quy tắc, dòng trống bắt đầu điều này.

# CORS được thiết lập bằng đá và bất kỳ giao tiếp nào từ bây giờ trở đi sẽ giống như đọc một tài liệu html.
# Vì vậy, chúng tôi cần tạo bất kỳ stdout nào ở định dạng html!

# tạo cấu trúc html và gửi nó đến stdout
echo "<!DOCTYPE html>"
echo "<html><head>"

# Nội dung sẽ được tạo tùy thuộc vào Phương thức Yêu cầu
if [ "$REQUEST_METHOD" = "GET" ]; then

    # Lưu ý rằng các biến môi trường $ REQUEST_METHOD và $ QUERY_STRING có thể được xử lý bởivỏ trực tiếp.

    # Người ta phải lọc đầu vào để tránh tạo kịch bản trang web chéo.

    Var1=$(echo "$QUERY_STRING" | sed -n 's/^.*var1=\([^&]*\).*$/\1/p') # read value of "var1"
    Var1_Dec=$(echo -e $(echo "$Var1" | sed 's/+/ /g;s/%\(..\)/\\x\1/g;')) # html decode

    Var2=$(echo "$QUERY_STRING" | sed -n 's/^.*var2=\([^&]*\).*$/\1/p')
    Var2_Dec=$(echo -e $(echo "$Var2" | sed 's/+/ /g;s/%\(..\)/\\x\1/g;'))

    # create content for stdout
    echo "<title>Bash-CGI Example 1</title>"
    echo "</head><body>"
    echo "<h1>Bash-CGI Example 1</h1>"
    echo "<p>QUERY_STRING: ${QUERY_STRING}<br>var1=${Var1_Dec}<br>var2=${Var2_Dec}</p>" # print
the values to stdout
else
    echo "<title>456 Wrong Request Method</title>"
    echo "</head><body>"
    echo "<h1>456</h1>"
    echo "<p>Requesting data went wrong.<br>The Request method has to be \"GET\" only!</p>"
fi

echo "<hr>"
echo "$SERVER_SIGNATURE" # an other environment variable
echo "</body></html>" # close html

exit 0
```

Các **html-document** sẽ trông như thế này ...
```
<html><head>
<title>Bash-CGI Example 1</title>
</head><body>
<h1>Bash-CGI Example 1</h1>
<p>QUERY_STRING: var1=Hello%20World!&amp;var2=This%20is%20a%20Test.&amp;<br>var1=Hello
World!<br>var2=This is a Test.</p>
<hr>
<address>Apache/2.4.10 (Debian) Server at example.com Port 80</address>

</body></html>
```

Đầu ra của các biến sẽ như thế này ...

```
var1=Hello%20World!&var2=This%20is%20a%20Test.&
Hello World!
This is a Test.
Apache/2.4.10 (Debian) Server at example.com Port 80
```
**Tác dụng phụ tiêu cực ...**
- Tất cả mã hóa và giải mã trông không đẹp, nhưng cần thiết
- Yêu cầu sẽ có thể đọc được công khai và để lại khay
- Kích thước của một yêu cầu có giới hạn
- Cần bảo vệ chống lại Kịch bản chéo bên (XSS)

## 59.2: Phương thức yêu cầu: POST /w JSON - Request Method: POST /w JSON

Sử dụng phương thức yêu cầu POST kết hợp với SSL giúp việc truyền dữ liệu trở nên an toàn hơn.

Ngoài...

- Hầu hết mã hóa và giải mã không cần thiết nữa
- URL sẽ hiển thị với bất kỳ ai và cần được mã hóa url.
Dữ liệu sẽ được gửi riêng và do đó phải được bảo mật qua SSL
- Kích thước của dữ liệu gần như không giới hạn
- Vẫn cần được bảo vệ chống lại Cross-Side-Scripting (XSS)

Để giữ cho buổi giới thiệu này đơn giản, chúng tôi muốn nhận  **JSON Data** và thông tin liên lạc nên được thông qua **Chia sẻ Tài nguyên Nhiều Nguồn gốc - Cross-Origin Resource Sharing (CORS)**.

Tập lệnh sau đây cũng sẽ trình bày hai **Content-Types** khác nhau .

```
#!/bin/bash

exec 2>/dev/null # Chúng tôi không muốn bất kỳ thông báo lỗi nào được in ra stdout
trap "response_with_html && exit 0" ERR   # với thông báo html khi xảy ra lỗivà đóng tập lệnh

function response_with_html(){
    echo "Content-type: text/html"
    echo ""
    echo "<!DOCTYPE html>"
    echo "<html><head>"
    echo "<title>456</title>"
    echo "</head><body>"
    echo "<h1>456</h1>"
    echo "<p>Attempt to communicate with the server went wrong.</p>"
    echo "<hr>"
    echo "$SERVER_SIGNATURE"
    echo "</body></html>"
}

function response_with_json(){
    echo "Content-type: application/json"
    echo ""
    echo "{\"message\": \"Hello World!\"}"
}

if [ "$REQUEST_METHOD" = "POST" ]; then
    # Biến thể môi trường $ CONTENT_TYPE mô tả kiểu dữ liệu đã nhận
    case "$CONTENT_TYPE" in
    application/json)
        # Biến thể môi trường $ CONTENT_LENGTH mô tả kích thước của dữ liệu
        read -n "$CONTENT_LENGTH" QUERY_STRING_POST     # đọc luồng dữ liệu

        # Các dòng sau sẽ ngăn XSS và kiểm tra dữ liệu JSON-Data có giá trị.
        # Nhưng các Biểu tượng này cần được mã hóa bằng cách nào đó trước khi gửi tới tập lệnh này
        QUERY_STRING_POST=$(echo "$QUERY_STRING_POST" | sed 
"s/'//g" | sed 's/\$//g;s/`//g;s/\*//g;s/\\//g' )        # removes some symbols (like \ * ` $ ') to prevent XSS with Bash and SQL.

        QUERY_STRING_POST=$(echo "$QUERY_STRING_POST" | sed -e :a -e 's/<[^>]*>//g;/</N;//ba')      #loại bỏ hầu hết các khai báo html để ngăn XSS trong tài liệu
        JSON=$(echo "$QUERY_STRING_POST" | jq .)        # json encode - Đây là một cách tiết kiệmđể kiểm tra mã valide
    ;;
    *)
        response_with_html
        exit 0
    ;;
    esac

else
    response_with_html
    exit 0
fi

# Some Commands ...

response_with_json

exit 0
```

Bạn sẽ nhận được { **"message" : "Hello World!"** } như một câu trả lời khi gửi **JSON-Data** qua POST tới Tập lệnh này. Mỗithứ khác sẽ nhận được tài liệu html.

Điều quan trọng cũng là biến thể $ JSON . Biến này không có XSS, nhưng vẫn có thể có các giá trị sai trong đó và cần phảiđược xác minh trước. Hãy ghi nhớ điều đó.

Mã này hoạt động tương tự mà không có JSON.
Bạn có thể lấy bất kỳ dữ liệu nào theo cách này.
Bạn chỉ cần thay đổi Loại-Nội dung theo nhu cầu của mình.

**Thí dụ:**

```
if [ "$REQUEST_METHOD" = "POST" ]; then
    case "$CONTENT_TYPE" in
    application/x-www-form-urlencoded)
        read -n "$CONTENT_LENGTH" QUERY_STRING_POST
    text/plain)
        read -n "$CONTENT_LENGTH" QUERY_STRING_POST
    ;;
    esac
fi
```

Cuối cùng nhưng không kém phần quan trọng, đừng quên phản hồi tất cả các yêu cầu, nếu không các chương trình của bên thứ ba sẽ không biết liệu họ cóđã thành công.