# Geo 数据类型(version >= 3.2支持)

## 支持的全部命令

### `geoadd`  `geopos`  `geodist`  `georadius`  `georadiusbymember`  `geohash`

## geoadd命令

### 功能描述

	将指定的地理空间位置（纬度、经度、名称）添加到指定的key中。这些数据会以有序集合的形式被储存在键里面,

	从而使得像 GEORADIUS 和 GEORADIUSBYMEMBER 这样的命令可以在之后通过位置查询取得这些元素。

### 命令格式
	geoadd key lng lat name [lng lat name...]

	lng : 经度

	lat : 纬度

	name : 名称


### 返回值
	返回值：添加到sorted set元素的数目，但不包括已更新score的元素。


### 使用示例

	向名为demo的key中增加天安门,广渠门 

	geoadd demo 116.406568 39.915378 "tiananmen" 116.433589 39.909622 "guangqumen"

	返回值: 2

	geoadd demo 116.406568 39.915379 "tiananmen" 116.433589 39.909623 "guangqumen"

	返回值: 0 原因: guangqunmen & tiananmen均已存在，本次操作无新增，实际为更新score

### 使用注意事项

	由于当key中指定名称已存在时，返回值的计数不包含该项，所以不能但存的使用返回的影响数据量判断处理的成功还是失败。

## goepos命令

### 功能描述

	获取指定的地理位置信息

### 命令格式

	geopos key name [name...]

	key : geoadd 时设置的key

	name : key 中包含的name

### 返回值

	返回一个 list,每一项的索引0是经度信息，索引1 是纬度信息, 当 name 不存在或者 key不存在时，返回nil

	注意只设置key,不设置name时，即使key存在，也返回nil,而不是返回key下的全部name

### 使用示例

	1. geopos demo tiananmen, 返回值如下

		1) 1) "116.40657037496566772"
		   2) "39.91537824494462683"

    2. geopos demo tiananmen guangqumen, 返回值如下

	    1) 1) "116.40657037496566772"
		   2) "39.91537824494462683"
		2) 1) "116.43359094858169556"
		   2) "39.90962189319177611"

	3. geo demo tiananmen guangqumen yongdingmen, 返回值如下

		1) 1) "116.40657037496566772"
		   2) "39.91537824494462683"
		2) 1) "116.43359094858169556"
		   2) "39.90962189319177611"
		3) (nil)

	 4. geopos demo, 返回 nil 


