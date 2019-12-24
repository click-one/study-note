# es 单机部署

## 服务器环境

**centos7**

## 安装包下载

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.4.tar.gz

## 安装包解压

tar zxvf elasticsearch-6.8.4.tar.gz

## 服务启动

./bin/elasticsearch

## 验证

访问: 127.0.0.1:9200

出现如下信息证明es安装成功:

```json
{
    "name": "2CDGpSy",
    "cluster_name": "elasticsearch",
    "cluster_uuid": "n9VHhE3TQea1ODxLlG7QGQ",
    "version": {
        "number": "6.8.4",
        "build_flavor": "default",
        "build_type": "tar",
        "build_hash": "bca0c8d",
        "build_date": "2019-10-16T06:19:49.319352Z",
        "build_snapshot": false,
        "lucene_version": "7.7.2",
        "minimum_wire_compatibility_version": "5.6.0",
        "minimum_index_compatibility_version": "5.0.0"
    },
    "tagline": "You Know, for Search"
}
```

## 可能会遇到的问题

[2019-12-24T12:21:57,304][WARN ][o.e.b.ElasticsearchUncaughtExceptionHandler] [unknown] uncaught exception in thread [main]

org.elasticsearch.bootstrap.StartupException: java.lang.RuntimeException: can not run elasticsearch as root
	at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:163) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.execute(Elasticsearch.java:150) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.cli.EnvironmentAwareCommand.execute(EnvironmentAwareCommand.java:86) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.cli.Command.mainWithoutErrorHandling(Command.java:124) ~[elasticsearch-cli-6.8.4.jar:6.8.4]
	at org.elasticsearch.cli.Command.main(Command.java:90) ~[elasticsearch-cli-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:116) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:93) ~[elasticsearch-6.8.4.jar:6.8.4]
Caused by: java.lang.RuntimeException: can not run elasticsearch as root
	at org.elasticsearch.bootstrap.Bootstrap.initializeNatives(Bootstrap.java:103) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap.setup(Bootstrap.java:170) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:333) ~[elasticsearch-6.8.4.jar:6.8.4]
	at org.elasticsearch.bootstrap.Elasticsearch.init(Elasticsearch.java:159) ~[elasticsearch-6.8.4.jar:6.8.4]
	... 6 more

**es5** 之后的都不能使用添加启动参数或者修改配置文件等方法启动了，**必须** 要创建用户

创建一个用户,然后执行 **chown -R 用户:用户组 es**,然后切换到新建的用户,即可启动

- 报错信息如下:

[2019-12-24T14:18:16,126][INFO ][o.e.b.BootstrapChecks    ] [2CDGpSy] bound or publishing to a non-loopback address, enforcing bootstrap checks
ERROR: [1] bootstrap checks failed

处理方法，依次执行如下命令:

sudo vim /etc/sysctl.conf

在文件末尾添加 **vm.max_map_count=655360**,保存并推退出

sudo sysctl -p

<script>
var pageId = "es服务安装"
</script>

!INCLUDE "../../common/gitalk.html"
