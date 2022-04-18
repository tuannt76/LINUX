# Các khái niệm cơ bản trong tệp cấu hình Nginx

Mục lục
- [Các khái niệm cơ bản trong tệp cấu hình Nginx](#các-khái-niệm-cơ-bản-trong-tệp-cấu-hình-nginx)
  - [I. Cấu trúc của tệp cấu hình](#i-cấu-trúc-của-tệp-cấu-hình)
  - [II. Chi tiết về file cấu hình](#ii-chi-tiết-về-file-cấu-hình)
    - [1. Main Block](#1-main-block)
    - [2. Events Block](#2-events-block)
    - [3. HTTP Block](#3-http-block)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

Bài viết này giải thích cấu trúc của  tệp cấu hình mặc định của NGINX.

Nginx có 1 quy trình chính (master process) và nhiều quy trình worker (worker process)
- Master process đọc (read), đánh giá (evaluate) cấu hình và duy trì các work process.
- Worker process xử lý các yêu cầu (request) thực tế. Nginx sử dụng mô hình dựa trên sự kiện (event-based model) và các cơ chế phụ thuộc vào hệ điều hành (OS-dependent mechanisms) để phân phối hiệu quả các yêu cầu giữa các work process.
  - Số lượng quy trình công nhân được xác định trong tệp cấu hình và có thể được cố định cho một cấu hình nhất định hoặc tự động điều chỉnh theo số lõi CPU có sẵn (xem [worker_processes](#1-main-block))

Cách thức hoạt động của nginx và các mô-đun của nó được xác định trong tệp cấu hình. 
## I. Cấu trúc của tệp cấu hình
- Tất cả các tệp cấu hình NGINX đều nằm trong thư mục `/etc/nginx`.
- Tệp cấu hình chính là `/etc/nginx/nginx.conf`

Nginx quản lý cấu hình theo:
1. Directives - là các option cấu hình NGINX
- Bao gồm:
   - Simple Directive -bao gồm tên và các tham số được phân tách bởi dấu cách và kết thúc bằng dấu chấm phẩy (`;`).
      - Những Directive này sẽ nhóm lại gọi là `Main Block`. Những cấu hình trên Block này ảnh hưởng tới toàn bộ server.
   - Block Directive - có cấu trúc giống Simple Directive nhưng nằm trong các Block.
     - Những Directive này chỉ có tác dụng trong Block của nó.
1. Block - còn gọi là contexts
    - Bao gồm các Directive bên trong dấu ngoặc nhọn (`{` và `}`).
    - Ví dụ 1 số block: events, http, server,...
    - 

Ví dụ của /etc/nginx/nginx.conf dưới đây:
```
      1 user  nginx;
      2 worker_processes  auto;
      3
      4 error_log  /var/log/nginx/error.log notice;
      5 pid        /var/run/nginx.pid;
      6
      7
      8 events {
      9     worker_connections  1024;
     10 }
     11
     12
     13 http {
     14     include       /etc/nginx/mime.types;
     15     default_type  application/octet-stream;
     16
     17     log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
     18                       '$status $body_bytes_sent "$http_referer" '
     19                       '"$http_user_agent" "$http_x_forwarded_for"';
     20
     21     access_log  /var/log/nginx/access.log  main;
     22
     23     sendfile        on;
     24     #tcp_nopush     on;
     25
     26     keepalive_timeout  65;
     27
     28     #gzip  on;
     29
     30     include /etc/nginx/conf.d/*.conf;
     31 }

```

Có 4 Directive trong file cấu hình trên nằm trong `Main Block`:
1. `user`
2. `worker_processes`
3. `error_log`
4. `pid`

Các Block trong file cấu hình trên : events{...}, http{...}.

Các lệnh sau dấu `#` gọi là 1 `comment`. Các `comment` không ảnh hưởng tới hoạt động của nginx. Ví dụ trong file cấu hình trên:
1. `#tcp_nopush     on;`
2. `#gzip  on;`

## II. Chi tiết về file cấu hình
### 1. Main Block
Cấu hình áp dụng cho tất cả các block, trong đó:
- `User nginx;` : Cấu hình quy định worker processes được chạy với tài khoản nào , ở đây là nginx.

- `worker_processes auto;` :Số lượng work process nginx sử dụng, giá trị này tương ứng với số CPU Core có trên máy chủ. Cấu hình ở đây là web server được xử lý bằng auto CPU core (processor). Để kiểm tra số lượng CPU Core trên máy chủ chúng ta dùng lệnh :

    ```sh
    nproc
    # hoặc 
    cat /proc/cpuinfo
    ```

- `error_log /var/log/nginx/error.log;` Đường dẫn đến file log của nginx. Được sử dụng để Debug.

- `pid /run/nginx.pid;` số PID (**P**rocess **id**entification) của master process , nginx sử dụng master process để quản lý worker process

### 2. Events Block
- `worker_connections 1024;` Số lượng kết nối mà worker_process có thể xử lý. Giá trị này liên quan đến worker processes, 1024 có nghĩa là mỗi worker process sẽ chịu tải là 1024 kết nối cùng lúc . Nếu chúng ta có 2 worker process thì khả năng chịu tải của server là 2048 kết nối tại một thời điểm. Giá trị này chúng ta có thể tùy thuộc vào phần cứng của máy chủ (giá trị 1024/worker process không phải là mặc định).

### 3. HTTP Block
HTTP Block giúp Nginx xử lý các kết nối HTTP, HTTPS:
- Định nghĩa một mẫu log có tên là `main` được sử dụng bởi `access_log `, các thông tin được đưa vào file tương ứng với các 
    biến như `$remote_addr`, `$remote_user` ,....
```
log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
```

- Chỉ ra đường dẫn tới file log .
```
access_log  /var/log/nginx/access.log  main;
```

- Cấu hình này gọi đến function sendfile để xử lý việc truyền file
```
sendfile on;
``` 

- `tcp_nopush on;` Tuỳ chọn này được bật khi sendfile đc sử dụng.

- `tcp_nodelay on;` : duy trì kết nối

- Xác định thời gian chờ trước khi đóng 1 kết nối, ở đây là 65s.

```
keepalive_timeout   65;
```
-  Gọi tới file chứa danh sách các file extension trong nginx (Thêm 1 file khác vào cấu hình của nginx. được hiểu là bất kỳ file nào đc viết trong mime.types đc hiểu là nó được viết bên trong khối HTTP)
```
include /etc/nginx/mime.types;
   default_type        application/octet-stream;
```

- `types_hash_max_size 2048;`: kích thước tối đa hàm băm `hash`

# Tài liệu tham khảo

1. https://www.linode.com/docs/guides/how-to-configure-nginx/
2. http://nginx.org/en/docs/beginners_guide.html
3. http://nginx.org/en/docs/http/ngx_http_core_module.html