# Chapter 58: global and local variables - Biến cục bộ và toàn cục

Theo mặc định, mọi biến trong bash là toàn cục đối với mọi hàm, tập lệnh và thậm chí cả bên ngoài nếu bạn đang khai báocác biến của bạn bên trong một tập lệnh.

Nếu bạn muốn biến của mình là cục bộ cho một hàm, bạn có thể sử dụng cục bộ để biến đó trở thành một biến mớiđộc lập với phạm vi toàn cục và giá trị của nó sẽ chỉ có thể truy cập được bên trong hàm đó.

## 58.1: Biến toàn cục -  Global variables

```
var="hello"

function foo(){
    echo $var
}

foo
```

Rõ ràng là sẽ xuất ra "hello", nhưng điều này cũng hoạt động theo cách khác:

```
function foo() {
    var="hello"
}

foo
echo $var
```

Cũng sẽ xuất ra:"hello"

## 58.2: Biến cục bộ - Local variables

```
function foo() {
    local var
    var="hello"
}

foo
echo $var
```

Sẽ không xuất ra gì, vì var là một biến cục bộ của hàm foo và giá trị của nó không thể nhìn thấy từ bên ngoài nó.

## 58.3: Trộn cả hai với nhau - Mixing the two together

```
var="hello"

function foo(){
    local var="sup?"
    echo "inside function, var=$var"
}

foo
echo "outside function, var=$var"
```

Sẽ xuất ra

```
inside function, var=sup?
outside function, var=hello
```