# 方法接收者是指针和非指针的区别

假定定义一个用户结构体如下:

```go
package main

import "fmt"

type User struct {
	userName string
}

func (u User) setUserName(userName string) {
	fmt.Println("1 步输出", u.userName)	//1 步
	u.userName = userName
	fmt.Println("2 步输出", u.userName) //2 步
}

func (u *User) setUserName2(userName string) {
	fmt.Println("4 步输出", u.userName) //4 步
	u.userName = userName
	fmt.Println("5 步输出", u.userName) //5 步
}

func main() {
	var user = User{userName:"zhangdeman"}
	user.setUserName("zhangwuji")
	fmt.Println("3 步输出", user.userName)//3 步
	user.setUserName2("zhangsanfeng")
	fmt.Println("6 步输出", user.userName)//6 步
}

```

以上代码，输出结果如下:

	1 步输出 zhangdeman
	2 步输出 zhangwuji
	3 步输出 zhangdeman
	4 步输出 zhangdeman
	5 步输出 zhangsanfeng
	6 步输出 zhangsanfeng

以上代码注意**2步**和**3步**以及**5步**和**6步**:

## 输出结果描述

	2步已经将userName设置为zhangeuji,且2步输出结果为“zhangwuji”,但是3步输出结果为“zhangdeman”

	5步已经将userName设置为zhangsanfeng,且5步已正常输出,且6步也输出了“zhangsanfeng”

## 输出结果原因

	2 步函数接受方法位非指针，参数是值传递，并不影响原始值。

	5 步函数的接受方法是指针，参数是指针地址，修改地址的值，会影响原始变量值。

其中,非指针接收函数
```go
func (u User) setUserName(userName string) {
	fmt.Println("1 步输出", u.userName)	//1 步
	u.userName = userName
	fmt.Println("2 步输出", u.userName) //2 步
}
```
等价于
```go
func setUserName(u User, userName string) {
	fmt.Println("1 步输出", u.userName)	//1 步
	u.userName = userName
	fmt.Println("2 步输出", u.userName) //2 步
}
```

指针接收函数
```go
func (u *User) setUserName(userName string) {
	fmt.Println("1 步输出", u.userName)	//1 步
	u.userName = userName
	fmt.Println("2 步输出", u.userName) //2 步
}
```
等价于
```go
func setUserName(u *User, userName string) {
	fmt.Println("1 步输出", u.userName)	//1 步
	u.userName = userName
	fmt.Println("2 步输出", u.userName) //2 步
}
```

通过以上函数对比，很容易看出一个是值传递，一个是指针传递，这就是产生demo程序输出如上结果原因。
