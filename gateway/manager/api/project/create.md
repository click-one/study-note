# 创建一个新项目

## 接口API

/manager/project/create

## 请求方法

POST

## 请求参数

参数名 | 参数类型 | 参数含义 | 是否必填
:-: | :-: | :-: | :-:
flag | string | 项目唯一标示 | 是
name | string | 项目名称 | 是
description | string | 项目描述 | 否
isOpenGray | uint | 是否开启灰度 | 是 0 - 不开启 1 - 开启
masterDomain | string | 生产环境域名 | 是
grayDomain | string | 灰度环境域名 | 否, isOpenGray = 1 必填

## 关键参数解析

### flag

**flag参数** 是项目的唯一标识, 接入api后,此标示会作为当前项目公共的uri前缀,因为flag **全局唯一**,通过此,亦可保证uri全局唯一

eg. 注册项目 flag = test 添加uri /user/getUserInfo, 则最终体现在网关上的uri为: /test/user/getUserInfo

### isOpenGray

**isOpenGray参数**, 是当前项目全局的是否开启会读功能的开关,只有全局开关打开,会面针对api的灰度功能才会生效

### masterDomain

**masterDomain参数**, 为生产环境域名, 提供稳定服务的集群地址

### grayDomain

**grayDomain参数**,为灰度环境域名, 提供 A/B test的灰度服务,开启灰度功能后,命中指定规则的请求,将会将流量转发至灰度集群

## 返回数据

### 返回数据结构定义
```go
type CreateProjectOutput struct {
	ProjectId       uint64 `json:"projectId"`
	ProjectConfigId uint64 `json:"projectConfigId"`
}
```

### 返回数据示例
```json
{
    "code":0,
    "data":{
        "ProjectId":25,
        "ProjectConfigId":19
    },
    "traceId":"xxxxxxxx",
    "message":"请求成功"
}
```

### 返回数据说明

**projectId** : 项目创建成功后,生成的向木ID

**projectConfigId** : 项目创建成功后,生成的配置ID

**traceId**: 本次请求的唯一日志ID,问题定位诊断使用

<script>
var pageId = "网关设计-manger-api-创建项目"
</script>

!INCLUDE "../../../../common/gitalk.html"
