# geohash 命令

## 功能描述
    获取一个集合中一个或多个元素位置的有效 Geohash 字符串。

    该命令返回11个字符的 Geohash 字符串，因此与 Redis 内部52位表示相比，没有任何精度损失。返回的 Geohashes 具有以下属性：

        1. 他们可以缩短删除右侧的字符。它会失去精确度，但仍会指向同一区域。

        2. 可以在geohash.org URL 中使用它们，例如http://geohash.org/<geohash-string>。这是这种 URL 的一个例子。

        3. 带有相似前缀的字符串在附近，但相反的情况并非如此，有可能前缀不同的字符串也在附近。

## 命令格式
    GEOHASH key member [member ...]

## 返回值
    返回一个数组，其中每个元素是与作为参数传递给该命令的每个成员名称对应的 Geohash。

## 使用示例
    geoadd demo 116.406568 39.915378 "tiananmen" 116.433589 39.909622 "guangqumen"

    1. geohash demo foo tiananmen, 返回值如下:
        1) (nil)
        2) "wx4g0fkevt0"

    2. geohash demo guangqumen tiananmen, 返回值如下:
        1) "wx4g19267k0"
        2) "wx4g0fkevt0"

## 注意事项
    1. member即使不存在，也会返回，会返回null，此处需要留意在业务上的处理
