# georadius 命令

## 功能描述

    检索指定点附近的地理空间坐标，并且不超过指定半径距离。

## 命令格式

    GEORADIUS key lng lat radius unit [WITHCOORD] [WITHDIST] [WITHHASH] [COUNT count] sort

    GEORADIUSBYMEMBER key member radius unit [WITHCOORD] [WITHDIST] [WITHHASH] [COUNT count] sort


    key : 要检索的key
    lng : 中心点经度
    lat : 中心点纬度
    radius : 检索的半径
    unit : 检索半径radius的单位,以及返回结果中距离的单位,支持 m|km|ft|mi
    WITHCOORD : 可选参数, 返回匹配到的结果的经纬度信息
    WITHDIST : 返回检索到的坐标距离中心点的距离，单位同检索半径的单位
    WITHHASH : 还以52位无符号整数的形式返回项目的原始 geohash 编码的有序集合分数。这只对低级别的黑客或调试很有用，对于普通用户来说这很有趣。
    sort : 返回数据排序规则,支持 asc(升序), desc(降序),默认返回的是未排序的数据,排序基于返回值中检索到的点距离中心点的距离来进行处理。

## 返回值
    1. 没有指定任何with选项,返回为检索到的member的name属性列表。
    2. 如果WITHCOORD，WITHDIST或者WITHHASH指定了选项，该命令将返回结果对象。

## 使用示例
    geoadd demo 116.406568 39.915378 "tiananmen" 116.433589 39.909622 "guangqumen"

    1. GEORADIUS demo 116.40657037496566772 39.91537824494462683 12 km, 不带任何的with选项,返回值如下:
      1) "tiananmen"
      2) "guangqumen"

    2. GEORADIUS demo 116.40657037496566772 39.91537824494462683 12 km  withcoord withdist withhash 携带with选项,返回值如下:
      1) 1) "tiananmen"
         2) "0.0000"
         3) (integer) 4069885556661671
         4) 1) "116.40657037496566772"
            2) "39.91537824494462683"
      2) 1) "guangqumen"
         2) "2.3925"
         3) (integer) 4069885676118936
         4) 1) "116.43359094858169556"
            2) "39.90962189319177611"

    3. GEORADIUS demo 116.40657037496566772 39.91537824494462683 12 km  count 1 指定count,返回值如下:
        1) "tiananmen"

    4. GEORADIUS demo 116.40657037496566772 39.91537824494462683 12 km  count 1 desc 指定指定规则,返回值如下:
        1) "guangqumen"

    5. GEORADIUS demo 116.40657037496566772 -90 12 km, 非法的经纬度，返回值如下:
        (error) ERR invalid longitude,latitude pair 116.406570,-90.000000

## 注意事项
    1. 关于经纬度的取值范围限制，针对本命令依旧有效，超出范围的值，会抛出异常。
    2. GEORADIUSBYMEMBER 基本相同，区别只在入参时,GEORADIUSBYMEMBER 使用member的name代替里具体的经纬度值。
    3. GEORADIUSBYMEMBER 当传递的 member查不到时，会抛异常(ERR could not decode requested zset member)，而不是返回空结果。
