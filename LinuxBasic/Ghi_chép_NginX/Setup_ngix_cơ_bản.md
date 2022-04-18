# Tổng quan và Cài đặt NginX

## 1.Tổng quan NginX

- Nginx là sản phẩm mã nguồn mở dành cho web server . Là một reverse proxy cho các giao thức HTTP, SMTP , POP3 và IMAP. Nhằm nâng cao hiệu suất xử lý khi sử dụng lượng RAM thấp . Được cấp phép bởi BSD chạy trên nền tảng UNIX, Linux và các biến thể BSD , Mac OS , Solaris, AIX, HP-UX và windows.

- Nginx có thể triển khai nội dung của các trang web động bằng cách sử lý FastCGI, SCGI  cho các scripts . Và có thể sử dụng như là một server cân bằng tải . Sau đó vấn đề C10K xuất hiện  nói cách khác để cho phép mỗi máy chủ web phải có khả năng xử lý 10.000 khách hàng cùng một lúc.  Cần phải phát triển một mạng lưới  I / O tốt hơn và công nghệ quản lý chủ đề đã được xuất hiện. Sự xuất hiện của NGinx không phải là kết quả của một nỗ lực để giải quyết vấn đề C10K (như là một vấn đề phổ biến) nhưng “vấn đề C10K” đã thành công trong việc đưa ra các  nỗ lực để nâng cao hiệu suất phát triển mạng máy chủ

- Igor Sysoev phát triển nginx từ cách đây hơn 9 năm. Vào tháng 10/2004, phiên bản 0.1.0 được phát hành rộng rãi theo giấy phép BSD. Công dụng của nginx ngoài máy chủ web, còn có thể làm proxy nghịch cho Web và làm proxy email (SMTP/POP3/IMAP). Theo thống kê của Netcraft, trong số 1 triệu website lớn nhất thế giới, có 6,52% sử dụng nginx. Tại Nga, quê hương của nginx, có đến 46,9% sử dụng máy chủ này. Nginx chỉ đứng sau Apache và IIS (của Microsoft).
  
## 2.Setup Cơ bản 

### 1.Cài đặt Nginx


**Bước 1 :** 

Install the prerequisites:

```
yum install yum-utils -y
```

![](../image/proxy3.png)

**Bước 2 :** 
Thêm repo:

```
echo '[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true' >> /etc/yum.repos.d/nginx.repo
```
![](../image/proxy4.png)


**Bước 3 :** 
use mainline nginx packages:

```
yum-config-manager --enable nginx-mainline
```

![](../image/proxy5.png)

**Bước 4 :** 
Install nginx:

```
yum install nginx -y
```

![](../image/proxy6.png)


**Bước 5 :** 
Cấu hình firewall va Khởi động dịch vụ:

```
firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --reload
```
```
systemctl start nginx
systemctl enable nginx
```

![](../image/proxy7.png)


**Bước 6**
Kiểm tra file cấu hình:

```
NginX -t && NginX -s reload
```


kiểm tra địa chỉ Ip ``ip a``

truy cập theo địa chỉ: 

![](../image/proxy52.png)