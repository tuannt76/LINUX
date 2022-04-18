# Chapter 49: Type of Shells - Loại Shells

## 49.1: Bắt đầu một trình bao tương tác

```
bash
```

## 49.2: Phát hiện loại vỏ

```
shopt -q login_shell && echo 'login' || echo 'not-login'
```

## 49.3: Giới thiệu về tệp chấm

Trong Unix, các tệp và thư mục bắt đầu bằng dấu chấm thường chứa các cài đặt cho một chương trình cụ thể / một loạtcác chương trình. Các tệp chấm thường bị ẩn với người dùng, vì vậy bạn sẽ cần phải chạy ls -a để xem chúng.

Một ví dụ về tệp chấm là .bash_history, chứa các lệnh được thực thi mới nhất, giả sử người dùng làbằng cách sử dụng Bash.

Có nhiều tệp khác nhau được lấy từ nguồn khi bạn được đưa vào trình bao Bash. Hình ảnh dưới đây, được lấy từtrang web này, hiển thị quy trình quyết định đằng sau việc chọn tệp nào để tạo nguồn khi khởi động.