# go modules 的使用

## go modules 是什么?

	go1.11版本之后,go官方推出的依赖管理模块,更加易于管理项目中所需要的模块.

## go modules 的规则?

	1. 模块是存储在文件树中的 Go 包的集合，其根目录中包含 go.mod 文件。 
	2. go.mod 文件定义了模块的模块路径，它也是用于根目录的导入路径，以及它的依赖性要求。
	3. 每个依赖性要求都被写为模块路径和特定语义版本。

## go modules 注意事项？

	1. 从 Go 1.11 开始，Go 允许在 $GOPATH/src 外的任何目录下使用 go.mod 创建项目。
	2. 在 $GOPATH/src 中，为了兼容性，Go 命令仍然在旧的 GOPATH 模式下运行。
	3. 从 Go 1.13 开始，模块模式将成为默认模式。

## go modules 使用时的环境变量

	export GO111MODULE=on //开启go modules
	export GOPROXY=https://goproxy.io // 设置代理 (速度真的很不错)

## go modules 基本使用

### 创建一个新模块

	你可以在 $GOPATH/src 之外(原因参见注意事项)的任何地方创建一个新的目录。命令如下:
```go
	go mod init dependence(这个名称可自定义)
```
	执行完成后，会发现目录下多了 go.md 文件,其内容如下:

```go
	module dependence

	go 1.13
```

### 添加依赖项

	创建一个文件 main.go 然后加入以下代码，这里直接 import 了 gin 的依赖包。

```go
package main

import "github.com/gin-gonic/gin"

func main() {
    r := gin.Default()
    r.GET("/ping", func(c *gin.Context) {
        c.JSON(200, gin.H{
            "message": "pong",
        })
    })
    r.Run(":8080")
}
```

	go build 之后，会在 go.mod 引入所需要的依赖包。之后再来看看 go.mod 文件的情况, 多了如下信息:。

	github.com/gin-contrib/sse v0.0.0-20190301062529-5545eab6dad3 // indirect
    github.com/gin-gonic/gin v1.3.0
    github.com/golang/protobuf v1.3.1 // indirect
    github.com/mattn/go-isatty v0.0.7 // indirect
    github.com/ugorji/go v1.1.4 // indirect
    gopkg.in/go-playground/validator.v8 v8.18.2 // indirect
    gopkg.in/yaml.v2 v2.2.2 // indirect

    require 就是 gin 框架所需要的所有依赖包 并且在每个依赖包的后面已经表明了版本号

## 查看项目的依赖包

### 查看项目全部的依赖包
	go list -m all

### 查看一个包可用的版本
	go list -m -versions [包的导入路径]

	如 : go list -m -versions github.com/gin-gonic/gin 会输出如下信息：
	github.com/gin-gonic/gin v1.1.1 v1.1.2 v1.1.3 v1.1.4 v1.3.0 v1.4.0

### 更新一个包的版本

	方式一:
		go get [包的导入路径@版本号(版本号要在可用版本中)] 

		示例： go get github.com/gin-gonic/gin@v1.1.4

	方式二:

		go mod edit -require="github.com/gin-gonic/gin@v1.1.4" // 修改 go.mod 文件
		go mod tidy //下载更新依赖
		go mod tidy 命令会自动清理掉不需要的依赖项，同时可以将依赖项更新到当前版本

## 结论

	Go Module 是 Go 依赖管理的未来。 目前只有 1.11及以上版本支持该功能，介绍了 Go 依赖管理的功能。更多的功能会在以后补充。

## 额外: GoLand代码自动提示补全配置

	Preferences -> GO -> GO Modules(vgo) -> 勾选 Enable GO Modules(vgo) integration



