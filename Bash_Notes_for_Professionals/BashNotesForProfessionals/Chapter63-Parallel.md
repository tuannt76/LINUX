# Chapter 63: Parallel

|Option|Mô tả|
|---|---|
-j n|Chạy n công việc song song
-k|Giữ cùng một thứ tự
-X|Nhiều đối số với thay thế ngữ cảnh
--colsep regexp|Phân chia đầu vào trên regexp để thay thế vị trí
{} {.} {/} {/.} {#}| Chuỗi thay thế
{3} {3.} {3/} {3/.} |Chuỗi thay thế vị trí
-S sshlogin|Ví dụ: foo@server.example.com
--trc {}.bar|Viết tắt của --transfer--return {}.bar --cleanup
--onall|Chạy lệnh đã cho với đối số trên tất cả các sshlogins
--nonall|Chạy lệnh đã cho mà không có đối số trên tất cả sshlogins
--pipe|Chia stdin (đầu vào tiêu chuẩn) cho nhiều công việc.
--recend str|Ghi dấu phân cách cuối cho --pipe.
--recstart str|Ghi dấu phân cách bắt đầu cho --pipe.

Các công việc trong GNU Linux có thể được thực hiện song song bằng cách sử dụng song song GNU. Một công việc có thể là một lệnh đơn hoặc một tập lệnh nhỏ cóđược chạy cho mỗi dòng trong đầu vào. Đầu vào điển hình là danh sách tệp, danh sách máy chủ lưu trữ, danh sách người dùng, danh sáchURL hoặc danh sách các bảng. Một công việc cũng có thể là một lệnh đọc từ một đường ống.

## 63.1: Song song hóa các tác vụ lặp đi lặp lại trên danh sách các tệp - Parallelize repetitive tasks on list of files

Nhiều công việc lặp đi lặp lại có thể được thực hiện hiệu quả hơn nếu bạn sử dụng nhiều tài nguyên của máy tính hơn (tức là CPUvà RAM). Dưới đây là một ví dụ về việc chạy song song nhiều công việc.

Giả sử bạn có < list of files >, giả sử đầu ra từ ls . Ngoài ra, hãy để các tệp này được nén bz2 và thứ tự của các nhiệm vụ cần được vận hành trên chúng.

1. Giải nén các tệp bz2 bằng **bzcat** thành stdout1.
2. Grep (ví dụ: bộ lọc) các dòng với (các) từ khóa cụ thể bằng cách sử dụng **grep < some key word>**.
3. Nối kết quả đầu ra thành một tệp gzipped duy nhất bằng cách sử dụng **gzip**.

Chạy điều này bằng cách sử dụng vòng lặp while có thể trông giống như thế này

```
filenames="file_list.txt"
while read -r line
do
name="$line"
    ## grab lines with puppies in them
    bzcat $line | grep puppies | gzip >> output.gz
done < "$filenames"
```

Sử dụng GNU Parallel, chúng ta có thể chạy 3 công việc song song cùng một lúc bằng cách đơn giản

```
parallel -j 3 "bzcat {} | grep puppies" ::: $( cat filelist.txt ) | gzip > output.gz
```

Lệnh này đơn giản, ngắn gọn và hiệu quả hơn khi số lượng tệp và kích thước tệp lớn. Các công việc đượcbắt đầu bằng cách song song , tùy chọn `-j 3` khởi chạy 3 công việc song song và đầu vào cho các công việc song song được thực hiện bởi ::: . Cácđầu ra cuối cùng được chuyển đến `gzip > output.gz`

## 63.2: Song song hóa STDIN

Bây giờ, hãy tưởng tượng chúng ta có 1 tệp lớn (ví dụ: 30 GB) cần được chuyển đổi từng dòng một. Giả sử chúng ta có một kịch bản, convert.sh , thực hiện điều này **< task>** . Chúng tôi có thể chuyển nội dung của tệp này sang stdin để song song tiếp nhận và làm việc vớinhững phần chẳng hạn như

```
<stdin> | parallel --pipe --block <block size> -k <task> > output.txt
```

trong đó **< stdin>** có thể bắt nguồn từ bất kỳ thứ gì chẳng hạn như `cat < file>`.

Như một ví dụ có thể tái tạo, nhiệm vụ của chúng ta sẽ là `nl -n rz`. Lấy bất kỳ tệp nào, của tôi sẽ là data.bz2 và chuyển nó vào **< stdin>**

```
bzcat data.bz2 | nl | parallel --pipe --block 10M -k nl -n rz | gzip > ouptput.gz
```

Ví dụ trên lấy **< stdin>** từ `bzcat data.bz2 | nl` , trong đó tôi bao gồm nl chỉ như một bằng chứng về khái niệm rằngđầu ra cuối cùng output.gz sẽ được lưu theo thứ tự nhận được. Sau đó, song song chia **< stdin>** thànhcác phần có kích thước 10 MB và đối với mỗi phần, nó sẽ chuyển nó qua `nl -n rz` nơi nó chỉ thêm một số đúng vàohợp lý (xem `nl --help` để biết thêm chi tiết). Các tùy chọn --pipe cho biết song song để chia **< stdin>** thành nhiều công việc và --block xác định kích thước của các khối. Tùy chọn -k chỉ định rằng thứ tự phải được duy trì.

Đầu ra cuối cùng của bạn sẽ trông giống như

```
000001      1 <data>
000002      2 <data>
000003      3 <data>
000004      4 <data>
000005      5 <data>
...
000587 552409 <data>
000588 552410 <data>
000589 552411 <data>
000590 552412 <data>
000591 552413 <data>
```

Tệp gốc của tôi có 552.413 dòng. Cột đầu tiên đại diện cho các công việc song song và cột thứ hai đại diện chođánh số dòng ban đầu đã được chuyển sang song song theo từng đoạn. Bạn nên nhận thấy rằng thứ tự trong thứ haicột (và phần còn lại của tệp) được duy trì.