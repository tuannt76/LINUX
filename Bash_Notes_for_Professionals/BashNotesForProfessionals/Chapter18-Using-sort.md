# Chapter 18: Using sort - Sử dụng sắp xếp

Tuỳ chọn| Nghĩa
|---|---|
-u |Làm cho mỗi dòng đầu ra là duy nhất

sắp xếp là một lệnh Unix để sắp xếp dữ liệu trong (các) tệp theo một trình tự.

## 18.1:Sort command output - Sắp xếp đầu ra lệnh

lệnh `sort` được sử dụng để sắp xếp một danh sách các dòng.

**Đầu vào từ một tệp**

```
sort file.txt
```

**Nhập từ một lệnh**

Bạn có thể sắp xếp bất kỳ lệnh đầu ra nào. Trong ví dụ, danh sách tệp theo sau một mẫu.

```
find * -name pattern | sort
```

## 18.2:Make output unique - Làm cho đầu ra là duy nhất

Nếu mỗi dòng của đầu ra cần phải là duy nhất, hãy thêm tùy chọn -u .

Để hiển thị chủ sở hữu của các tệp trong thư mục

```
ls -l | awk '{print $3}' | sort -u
```

## 18.3:Numeric sort - Sắp xếp số

Giả sử chúng ta có tệp này:

```
test>>cat file
10.Gryffindor
4.Hogwarts
2.Harry
3.Dumbledore
1.The sorting hat
```

Để sắp xếp tệp này theo số, hãy sử dụng tùy chọn sắp xếp với -n:

```
test>>sort -n file
```

Điều này sẽ sắp xếp tệp như dưới đây:

```
1.The sorting hat
2.Harry
3.Dumbledore
4.Hogwarts
10.Gryffindor
```
 
Đảo ngược thứ tự sắp xếp: Để đảo ngược thứ tự sắp xếp, hãy sử dụng tùy chọn -r


Để đảo ngược thứ tự sắp xếp của tệp ở trên, hãy sử dụng:

```
sort -rn file
```

Điều này sẽ sắp xếp tệp như dưới đây:

```
10.Gryffindor
4.Hogwarts
3.Dumbledore
2.Harry
1.The sorting hat
```


## 18.4:Sort by keys - Sắp xếp theo các phím

Giả sử chúng ta có tệp này:

```
test>>cat   Hogwarts
Harry           Malfoy          Rowena          Helga
Gryffindor      Slytherin       Ravenclaw       Hufflepuff
Hermione        Goyle           Lockhart        Tonks
Ron             Snape           Olivander       Newt
Ron             Goyle           Flitwick        Sprout
```

Để sắp xếp tệp này bằng cách sử dụng một cột làm khóa, hãy sử dụng tùy chọn k:

```
test>>sort -k 2 Hogwarts
```

Thao tác này sẽ sắp xếp tệp với cột 2 là khóa:
```
Ron             Goyle           Flitwick        Sprout
Hermione        Goyle           Lockhart        Tonks
Harry           Malfoy          Rowena          Helga
Gryffindor      Slytherin       Ravenclaw       Hufflepuff
Ron             Snape           Olivander       Newt
```
Bây giờ nếu chúng ta phải sắp xếp tệp bằng khóa phụ cùng với việc sử dụng khóa chính:

```
sort -k 2,2 -k 1,1 Hogwarts
```

Điều này đầu tiên sẽ sắp xếp tệp với cột 2 làm khóa chính, sau đó sắp xếp tệp với cột 1 làm khóa phụ:

```
Hermione        Goyle           Lockhart        Tonks
Ron             Goyle           Flitwick        Sprout
Harry           Malfoy          Rowena          Helga
Gryffindor      Slytherin       Ravenclaw       Hufflepuff
Ron             Snape           Olivander       Newt
```

Nếu chúng ta cần sắp xếp một tệp có nhiều hơn 1 khóa, thì đối với mọi tùy chọn -k, chúng ta cần chỉ định nơi sắp xếp kết thúc. Vì thế -k1,1 có nghĩa là bắt đầu sắp xếp ở cột đầu tiên và kết thúc sắp xếp ở cột đầu tiên.

**Tùy chọn -t**

Trong ví dụ trước, tệp này có tab - mê sảng mặc định. Trong trường hợp sắp xếp một tệp có giá trị không mặc địnhchúng ta cần tùy chọn -t để chỉ định máy nghiền. Giả sử chúng ta có tệp như sau:
```
test>>cat file
```

```
5.|Gryffindor
4.|Hogwarts
2.|Harry
3.|Dumbledore
1.|The sorting hat
```

Để sắp xếp tệp này theo cột thứ hai, hãy sử dụng:

```
test>>sort -t "|" -k 2 file
```

Thao tác này sẽ sắp xếp tệp như dưới đây:

```
3.|Dumbledore
5.|Gryffindor
2.|Harry
4.|Hogwarts
1.|The sorting hat
```