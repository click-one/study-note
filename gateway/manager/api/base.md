# 所有API的基础功能

## 基础公共参数

参数名 | 类型 | 含义
:-: | :-: | :-:
timestamp | int64 | 当前秒级时间戳
sign | string | 请求签名

## 参数说明

**sign** : 签名,签名逻辑如下

参数按照key的字典序升序排列，拼接成 k=v&k1=v1分配的secret,在进行md5加密

**timestamp**: 时间戳参数, 和服务器时间差值在300s以内为有效请求

## 签名算法

```go
func GetSign(param map[string]interface{}, secret string) string {
	var formatParam url.Values
	formatParam = make(map[string][]string)
	for key, val := range param {
		formatParam[key] = []string{fmt.Sprintf("%v", val)}
	}
	//拼接好的参数字符串
	paramStr := formatParam.Encode() + secret
	//md5加密
	md5Instance := md5.New()
	md5Instance.Write([]byte(paramStr))
	return hex.EncodeToString(md5Instance.Sum(nil))
}
```

## 错误码信息

错误码 | 含义
:-: | :-:
-1 | 请求参数错误
-2 | 请求签名缺失
-3 | 请求签名错误
-4 | 无效的请求,一般是由于 timestamp参数缺失或者距离当前时间超出300s所致
-11 | 无法开启事务,属数据库异常
-12 | 无法回滚事务,属数据库异常
-13 | 无法提交事务,属数据库异常
10100 | 创建项目失败
10101 | 创建项目配置失败
10102 | 根据项目标识获取项目信息失败,一般是标识未注册或者sql异常均为此错误
10103 | 项目标识已被占用,注册一个已存在的项目标识会返回此错误

<script>
var pageId = "网关设计-manger-api-接口公共基础信息"
</script>

!INCLUDE "../../../common/gitalk.html"
