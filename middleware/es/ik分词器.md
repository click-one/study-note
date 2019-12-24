# IK分词器安装教程

## 什么是分词器

分词器是将存储进去的文档进行短语拆分处理，用来作为查询索引。比如要在es中存储“人民币”，默认的分词器会将这个词语进行拆分，分为“人”，“民”，“币”。查询时输入“人”，“民”，“币”三者中的一者都会关联出“人民币”这个内容。

## 为什么需要自定义分词器

​ 原生的分词器对于 **中文的分词支持不是很好**。原生中文不支持短语分词，而是将中文一个一个的拆分。比如：“人民币”，原生的分词器会将其分为“人”，“民”，“币”。这时你只想查询人相关信息的时候，“人民币”也会被关联出来。索引出了很多相关不大的结果，降低了查询质量。

## 业内比较好用的中文分词器

IK , [github地址](https://github.com/medcl/elasticsearch-analysis-ik)

## 安装IK分词器

安装方式一:

https://github.com/medcl/elasticsearch-analysis-ik/releases 已发布版本页面,chazhao 和你es版本对应的分词器, 下载后,解压至 **$ES_HOME/plugin/ik** 目录下,重启es，分词器插件就自动加载了。

安装方式二:

./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.8.4/elasticsearch-analysis-ik-6.8.4.zip


## 问题

- 安装方式一: 服务启动报错如下:

[2019-12-24T14:47:44,722][WARN ][o.e.b.ElasticsearchUncaughtExceptionHandler] [2CDGpSy] uncaught exception in thread [main]
org.elasticsearch.bootstrap.StartupException: java.lang.IllegalStateException: Could not load plugin descriptor for plugin directory [ik]
	at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:163) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.execute(Elasticsearch.java:150) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.cli.EnvironmentAwareCommand.execute(EnvironmentAwareCommand.java:86) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.cli.Command.mainWithoutErrorHandling(Command.java:124) ~[elasticsearch-cli-6.8.4.jar:6.8.4]
	at org.elasticsearch.cli.Command.main(Command.java:90) ~[elasticsearch-cli-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:116) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:93) ~[elasticsearch-6.8.4.jar:6.8.4]
Caused by: java.lang.IllegalStateException: Could not load plugin descriptor for plugin directory [ik]
	at org.elasticsearch.plugins.PluginsService.readPluginBundle(PluginsService.java:401) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.plugins.PluginsService.findBundles(PluginsService.java:386) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.plugins.PluginsService.getPluginBundles(PluginsService.java:379) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.plugins.PluginsService.<init>(PluginsService.java:151) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.node.Node.<init>(Node.java:339) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.node.Node.<init>(Node.java:266) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap$5.<init>(Bootstrap.java:212) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap.setup(Bootstrap.java:212) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:333) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:159) ~[elasticsearch-6.8.4.jar:6.8.4]
	... 6 more
Caused by: java.nio.file.NoSuchFileException: /home/www/telrobot/es/plugins/ik/plugin-descriptor.properties
	at sun.nio.fs.UnixException.translateToIOException(UnixException.java:86) ~[?:?]
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:102) ~[?:?]
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:107) ~[?:?]
	at sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:214) ~[?:?]
	at java.nio.file.Files.newByteChannel(Files.java:361) ~[?:1.8.0_181]
	at java.nio.file.Files.newByteChannel(Files.java:407) ~[?:1.8.0_181]
	at java.nio.file.spi.FileSystemProvider.newInputStream(FileSystemProvider.java:384) ~[?:1.8.0_181]
	at java.nio.file.Files.newInputStream(Files.java:152) ~[?:1.8.0_181]
	at org.elasticsearch.plugins.PluginInfo.readFromProperties(PluginInfo.java:162) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.plugins.PluginsService.readPluginBundle(PluginsService.java:398) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.plugins.PluginsService.findBundles(PluginsService.java:386) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.plugins.PluginsService.getPluginBundles(PluginsService.java:379) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.plugins.PluginsService.<init>(PluginsService.java:151) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.node.Node.<init>(Node.java:339) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.node.Node.<init>(Node.java:266) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap$5.<init>(Bootstrap.java:212) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap.setup(Bootstrap.java:212) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:333) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:159) ~[elasticsearch-6.8.4.jar:6.8.4]
	... 6 more

总结起来就是: 没有这个文件 /home/www/telrobot/es/plugins/ik/plugin-descriptor.properties

查看后确实没有，手动创建,别写入如下内容:

```js
description=IK Analyzer for Elasticsearch
version=6.8.4
name=analysis-ik
classname=org.elasticsearch.plugin.analysis.ik.AnalysisIkPlugin
java.version=1.8
elasticsearch.version=6.8.4
```

<script>
var pageId = "es-ik分词器安装"
</script>

!INCLUDE "../../common/gitalk.html"
