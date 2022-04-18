2.Tìm hiểu về lệnh Grep
2.1 Khái niệm

 Grep (Global Regular Expression Print):là một công cụ dòng lệnh Linux/Unix  được sử dụng để tìm kiếm một chuỗi ký tự trong một tệp được chỉ định. Khi tìm thấy kết quả khớp, nó sẽ in dòng kết quả.

Lợi ích dùng lệnh Grep:

 Lệnh grep tiện lợi khi tìm kiếm thông qua các tệp nhật ký lớn.
2.2 Cách sử dụng lệnh ls trong Linux

Cú pháp:

```
grep [option] ‘string’ file
```

2.2.1 Tìm một chuỗi trong file (grep)
In ra dòng chứa từ khóa, tính cả dạng chuỗi con. Có phân biệt hoa thường

Gõ lệnh : 

```
grep tuan tuan.txt
```
2.2.2 Tìm kiếm không phân biệt hoa thường (grep -i)

Gõ lệnh: 
```grep -i tuan tuan.txt```

3 Tìm kiếm ngược (grep -v)
Hiển thị ra những dòng không chứa từ khóa.

Gõ lệnh:
```grep -v “tuan” tuan.txt```

2.2.4 Hiển thị số dòng của ký tự cần tìm (grep -n)

gõ lệnh: 

```grep -n “tuan” tuan.txt```

2.2.5 Tính toán số dòng có từ mình cần tìm được

gõ lệnh:

```
grep -c “tuan” tuan.txt
```
2.2.6 Chỉ hiện thị số dòng mong muốn với từ khóa đang tìm 

Gõ lệnh:

```
grep -m1 “tuan” tuan.txt
```


2.2.7 Tìm kiếm nhiều chuỗi từ khóa

Gõ lệnh (grep -e)
```
grep -e “tuan” -e “ngoc” tuan.txt
```


2.2.8 Kiểm tra từ khóa mong muốn trong nhiều tệp 1 lúc và in ra tên file có chứa từ khóa

gõ lệnh :
```
grep -l “tuan” tuan.txt tuan1.txt
```


2.2.9 Kiểm tra từ khóa mong muốn trong nhiều tệp 1 lúc và in ra tên file không chứa từ khóa

gõ lệnh:

```
grep -L “tuan” tuan.txt hoặc nhiều tệp grep _l :”tuan” tuan.txt tuan1.txt
```
2.2.10 Hiển thị tên tệp và ký tự cần tìm ( grep -H)

Gõ lệnh cho tìm kiếm 1 tệp hoặc nhiều tệp 1 thời điểm:

1 tệp: grep -H “tuan” tuan.txt nhiều tệp: grep -H “tuan” tuan.txt tuan2.txt

2.2.11 Truy xuất từ khóa cần tìm

Gõ lệnh:
```
grep -o “tuan” tuan.txt
```



2.2.12 Tìm các dòng bắt đầu bằng từ khóa.

gõ lệnh:
```
grep “^tuan” tuan.txt hoặc nhiều tệp: grep “^tuan” tuan.txt tuan2.txt
```


2.2.13 Tìm các dòng kết thúc bằng từ khóa 

Gõ lệnh:
```
grep “^tuan$” tuan.txt hoặc nhiều tệp grep “^tuan$” tuan.txt tuan2.txt
```


