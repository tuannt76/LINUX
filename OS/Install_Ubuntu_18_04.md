# Cài đặt  Ubuntu server 18.04

- [Cài đặt  Ubuntu server 18.04](#cài-đặt--ubuntu-server-1804)
  - [Bước 1: Chuẩn bị](#bước-1-chuẩn-bị)
  - [Bước 2: Cài đặt máy ảo](#bước-2-cài-đặt-máy-ảo)
  - [Bước 3: Cài đặt và cấu hình Ubuntu 18.04 server](#bước-3-cài-đặt-và-cấu-hình-ubuntu-1804-server)

## Bước 1: Chuẩn bị 
Tải file iso ubuntu 18.04 server tại: https://releases.ubuntu.com/18.04/
## Bước 2: Cài đặt máy ảo

Mở VMware Workstation 16  --> Chọn Create a New Virtual Machine
![Imgur](https://i.imgur.com/Y1wzhqn.png)
Chọn Typical (recommended) → Chọn Next
![Imgur](https://i.imgur.com/4jRMDzH.png)
Chọn Browser sau đó tìm đến ổ lưu file iso ubuntu 18.04 server
![Imgur](https://i.imgur.com/sUImC6f.png)
Cấu hình tài khoản user. Rồi chọn Next
![Imgur](https://i.imgur.com/5blyLX4.png)
Đặt tên cho máy ảo, chọn vị trí lưu file cài đặt máy ảo. Rồi chọn Next
![Imgur](https://i.imgur.com/zCtnjvi.png)
Chỉ định dung lượng bộ nhớ → chọn Next
![Imgur](https://i.imgur.com/ChIZ8KH.png)
Ta có thể cài đặt dung lượng RAM, card mạng, …. 
Chọn Customize Hardware..
![Imgur](https://i.imgur.com/6vqvihR.png)
![Imgur](https://i.imgur.com/YpfFPoA.png)
Chọn Finish
![Imgur](https://i.imgur.com/rcz0MIX.png)
## Bước 3: Cài đặt và cấu hình Ubuntu 18.04 server
Chọn ngôn ngữ(nút lên, xuống để di chuyển; Enter để chọn)
![Imgur](https://i.imgur.com/gVog0Gp.png)
Ở đây nó sẽ nói là phiên bản 22.02.2 đã sẵn sàng để cài đặt và bạn muốn update không?
Chọn Update to the installer để update và cài đặt phiên bản mới nhất
Chọn Continue without updating để tiếp tục với phiên bản hiện tại 
![Imgur](https://i.imgur.com/cxPpjeO.png)
Cấu hình bố cục bàn phím. Rồi chọn Done
![Imgur](https://i.imgur.com/GAIRq2M.png)
Có thể cấu hình IP động tĩnh ở đây, hoặc sửa ip theo ý muốn, nhưng ở bài này ta đặt mặc định :
![Imgur](https://i.imgur.com/Ducb2gw.png)

Cấu hình Proxy(có thể bỏ qua). Xong chọn Done
![Imgur](https://i.imgur.com/Vyr0NYu.png)
Cấu hình Mirror(có thể bỏ qua). Xong chọn Done
![Imgur](https://i.imgur.com/lsIbJQu.png)
Lựa chọn ổ đĩa để cài đặt. Để đơn giản hãy chọn Use An Entire Disk để sử dụng toàn ổ đĩa. Ubuntu sẽ bố cục giúp bạn. Xong chọn Done
![Imgur](https://i.imgur.com/5DiCrRT.png)
kiểm tra lại phân vùng mà Ubuntu đã phân giúp bạn. Bạn cũng có thể cấu hình theo ý mình ở đây. Xong chọn Done
![Imgur](https://i.imgur.com/AlLpNEd.png)
Xác nhận lần cuối
Đồng ý chọn Continue
Không chọn No
![Imgur](https://i.imgur.com/ewDBeMH.png)
tạo một User và mật khẩu của User, User này sẽ dùng để đăng nhập vào hệ điều hành Ubuntu sau khi cài đặt xong.
![Imgur](https://i.imgur.com/QTYPdtw.png)
cài đặt SSH
Nếu muốn cài đặt ssh ấn phím Space. rồi chọn Done
![Imgur](https://i.imgur.com/SLfaojc.png)
Cài đặt các tùy chọn
Chọn ấn phím Space. Xong chọn Done
Không có thể chọn Done luôn
![Imgur](https://i.imgur.com/fzKtBj6.png)
Chờ quá trình cài đặt xong
![Imgur](https://i.imgur.com/NiS9SpX.png)
![Imgur](https://i.imgur.com/8B0ivpV.png)
Quá trình cài đặt hoàn tất. Chọn Reboot
Kết quả
Nhập tài khoản mật khẩu ta cài đặt ở trên để đăng nhập vào hệ thống
![Imgur](https://i.imgur.com/tHrjQ03.png)
