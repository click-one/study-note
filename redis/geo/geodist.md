# geodist命令

## 功能描述

	返回排序集合表示的地理空间索引中两个成员之间的距离。

## 命令格式

	geodist key member1 member2 unit

## 返回值

	1. 该命令以指定单位的双精度值（以字符串表示）返回距离

	2. 如果缺少一个或两个元素，则返回 NULL

	3. 返回值精度保留到小数点后第四位小数


## 注意事项

	uint(返回的距离单位),为可选参数,不传时默认以m(米作为单位),该参数只支持一下四个单位:

	1. m 为米。

	2. km 为千米。

	3. mi 为英里。

	4. ft 为英尺。

## 使用示例

	geoadd demo 116.406568 39.915378 "tiananmen" 116.433589 39.909622 "guangqumen"

	1. geodist demo tiananmen guangqumen, 返回值为: 2392.4782

	2. geodist demo tiananmen guangqumen km, 返回值为: 2.3925

	3. geodist demo tiananmen guangqumen kkm, 返回异常信息: (error) ERR unsupported unit provided. please use m, km, ft, mi

	4. geodist demo tiananmen foo, 返回值为: nil
