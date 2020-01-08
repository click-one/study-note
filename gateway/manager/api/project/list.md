# 项目列表接口

## API接口

**/manager/project/list**

## 请求方法

**GET**

## 请求参数

参数名 | 参数类型 | 是否必填 | 参数含义
:-: | :-: | :-: | :-:
page | int | 是 | 查询的页码
size | int | 是 | 查询的数据量,最大 **200**
name | string | 否 | 项目名称
flag | string | 否 | 项目标识

## 请求结果

### 响应数据结构

```go
//uint类型枚举
type UintEnum struct {
	Code  uint   `json:"code"`
	Value string `json:"value"`
}
//列表数据每一项数据结构
type ProjectListItemOutput struct {
	Id         uint64        `json:"id"`
	Flag       string        `json:"flag"`
	Name       string        `json:"name"`
	Status     enum.UintEnum `json:"status"`
	CreateTime string        `json:"createTime"`
	UpdateTime string        `json:"updateTime"`
}
//列表数据输出的data
type ProjectListOutput struct {
	List        []ProjectListItemOutput `json:"list"`        //数据里表
	CurrentPage int                     `json:"currentPage"` //当前页码
	PageSize    int                     `json:"PageSize"`    //每页数据量
	TotalCount  int64                   `json:"totalCount"`  //数据总量
	TotalPage   float64                 `json:"totalPage"`   //总页数
}
```

### 响应结果说明

字段 | 类型 | 含义
:-: | :-: | :-:
list | []ProjectListItemOutput | 项目列表
currentPage | int | 当前查询页码
pageSize | int | 每页查询的数据量
totalCount | int64 | 查询到的数据总量
tatalPage | int64 | 数据一共有多少页

### 响应结果示例

```json
{
    "code":0,
    "message":"请求成功",
    "traceId":"a00d8a02b4ac020246a2918717599ea0",
    "data":{
        "list":[
            {
                "id":19,
                "flag":"test",
                "name":"测试项目",
                "status":{
                    "code":3,
                    "value":"已删除"
                },
                "createTime":"2020-01-05 22:11:21",
                "updateTime":"2020-01-07 20:28:06"
            },
            {
                "id":20,
                "flag":"test2",
                "name":"测试项目",
                "status":{
                    "code":0,
                    "value":"新建"
                },
                "createTime":"2020-01-06 12:09:03",
                "updateTime":"2020-01-06 12:09:03"
            },
            {
                "id":21,
                "flag":"test3",
                "name":"测试项目",
                "status":{
                    "code":0,
                    "value":"新建"
                },
                "createTime":"2020-01-06 12:10:15",
                "updateTime":"2020-01-06 12:10:15"
            },
            {
                "id":22,
                "flag":"test4",
                "name":"测试项目",
                "status":{
                    "code":0,
                    "value":"新建"
                },
                "createTime":"2020-01-06 12:15:41",
                "updateTime":"2020-01-06 12:15:41"
            },
            {
                "id":23,
                "flag":"test5",
                "name":"测试项目",
                "status":{
                    "code":0,
                    "value":"新建"
                },
                "createTime":"2020-01-06 12:16:09",
                "updateTime":"2020-01-06 12:16:09"
            },
            {
                "id":24,
                "flag":"test6",
                "name":"测试项目",
                "status":{
                    "code":0,
                    "value":"新建"
                },
                "createTime":"2020-01-06 12:20:09",
                "updateTime":"2020-01-06 12:20:09"
            },
            {
                "id":25,
                "flag":"test10",
                "name":"测试项目",
                "status":{
                    "code":0,
                    "value":"新建"
                },
                "createTime":"2020-01-08 12:06:23",
                "updateTime":"2020-01-08 12:06:23"
            }
        ],
        "currentPage":1,
        "PageSize":20,
        "totalCount":7,
        "totalPage":1
    }
}
```

<script>
var pageId = "网关设计-manger-api-查询项目列表"
</script>

!INCLUDE "../../../../common/gitalk.html"
