# 编译安装rabbitMQ

## 开发语言Erlang

rabbitMQ采用Erlang开发,需要先安装Erlang


## 解决依赖

yum install erlang

## 下载源码

wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.3.5/rabbitmq-server-generic-unix-3.3.5.tar.gz

## 服务启动

### 启动web服务

./sbin/rabbitmq-plugins enable rabbitmq_management

### 启动mq

./sbin/rabbitmq-server -detached

### 配置linux 端口

**15672** 网页管理，  **5672** AMQP端口

### 常用命令

查看服务状态：rabbitmqctl status

关闭服务：rabbitmqctl stop

查看mq用户：rabbitmqctl list_users  

查看用户权限：rabbitmqctl list_user_permissions guest

新增用户： rabbitmqctl add_user admin 123456

赋予管理员权限：

rabbitmqctl set_user_tags admin administrator

rabbitmqctl set_permissions -p "/" admin ".*" ".*" ".*"

<script>
var pageId = "rabbitMQ搭建教程"
</script>

!INCLUDE "../../../common/gitalk.html"
