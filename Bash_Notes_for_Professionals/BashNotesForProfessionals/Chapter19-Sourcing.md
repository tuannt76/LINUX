# Chapter 19: Sourcing - Tìm nguồn cung ứng



## 19.1:Sourcing a file - Tìm nguồn cung cấp tệp

Tìm nguồn cung ứng một tệp khác với việc thực thi, ở chỗ tất cả các lệnh được đánh giá trong ngữ cảnh hiện tạibash session - điều này có nghĩa là bất kỳ biến, hàm hoặc bí danh nào được xác định sẽ tồn tại trong suốt phiên của bạn.

Tạo tệp bạn muốn để nguồn sourceme.sh

```
#!/bin/bash

export A="hello_world"
alias sayHi="echo Hi"
sayHello() {
    echo Hello
}
```

Từ phiên của bạn, nguồn tệp

```
$ source sourceme.sh
```

Từ thứ tư, bạn có sẵn tất cả các tài nguyên của tệp có nguồn gốc

```
$ echo $A
hello_world

$ sayHi
Hi

$ sayHello
Hello
```

Lưu ý rằng lệnh . đồng nghĩa với nguồn , do đó bạn có thể đơn giản sử dụng

```
$ . sourceme.sh
```

## 19.2:Sourcing a virtual environment - Tìm nguồn cung ứng môi trường ảo

Khi phát triển một số ứng dụng trên một máy, việc tách các phần phụ thuộc thành các ứng dụng ảo sẽ trở nên hữu ích.các môi trường.

Với việc sử dụng virtualenv , các môi trường này được lấy nguồn từ trình bao của bạn để khi bạn chạy một lệnh, nóđến từ môi trường ảo đó.

Điều này được cài đặt phổ biến nhất bằng cách sử dụng pip .

```
pip install https://github.com/pypa/virtualenv/tarball/15.0.2
```

Tạo một môi trường mới

```
virtualenv --python=python3.5 my_env
```

Kích hoạt môi trường

```
source my_env/bin/activate
```