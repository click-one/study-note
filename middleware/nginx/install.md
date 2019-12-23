# 编译暗转nginx

## 操作系统

**centos7.4**

## 安装过程

### 创建用户

```bash
groupadd -f www
useradd -g www www
```

### 解决nginx的依赖

```bash
yum install gcc git vim gcc gcc-c++ autoconf automake make zlib zlib-devel openssl openssl-devel  -y
```

### 下载nginx源码

```bash
wget http://nginx.org/download/nginx-1.17.6.tar.gz
```

### 解压源码

```base
tar zxvf nginx-1.17.6.tar.gz
```

### 安装

```bash
cd nginx-1.17.6

./configure --user=www --group=www --prefix=/home/www/telrobot/nginx --with-http_stub_status_module --with-http_ssl_module --with-stream --with-http_gzip_static_module --with-http_sub_module

make && make install
```

### 参数解析

- **--user** : 指定nginx运行的用户
- **--group** : 指定nginx运行的用户组
- **--prefix** : nginx的安装目录
- **--with-http_stub_status_module** : 安装nginx状态监控模块,配置方式:

在nginx.conf的 **server块** 中添加如下代码


```sh
location /nginx_status {
    # Turn on nginx stats
    stub_status on;
}
```

- **--with-http_ssl_module** : 启用SSL模块
- **--with-stream** : nginx从 **1.9.0版本** 开始，新增了ngx_stream_core_module模块，使nginx支持 **四层负载均衡**。默认编译的时候该模块并未编译进去，需要编译的时候添加--with-stream，使其支持stream代理。
- **--with-http_gzip_static_module** : 启用nginx静态压缩功能,配置参考如下:

```shell
gzip_static on;
gzip_http_version 1.1;
gzip_proxied expired no-cache no-store private auth;
gzip_disable "MSIE [1-6] .";
gzip_vary on;
#找不到预压缩文件，进行动态压缩
gzip on;
gzip_min_length 1000;
gzip_buffers 4 16k;
gzip_comp_level 5;
gzip_types text/plain application/x-javascript text/css application/xml;
#gzip公共配置
gzip_http_version 1.1
gzip_proxied expired no-cache no-store private auth;
```
- **--with-http_sub_module** : 通过将一个指定的字符串替换为另一个字符串来修改响应。

<script>
var pageId = "nginx编译安装"
</script>

!INCLUDE "../../common/gitalk.html"
