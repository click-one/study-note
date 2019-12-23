# 编译安装PHP

## 环境

**centos7**

## 安装过程

### 解决PHP的依赖问题

yum install libicu-devel libicu libzip libzip-devel gcc gcc-c++  make zlib zlib-devel pcre pcre-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel openssl openssl-devel openldap openldap-devel -y

### 安装pcre(已安装可跳过)

### 下载pcre源码包

wget ftp://ftp.pcre.org/pub/pcre/pcre-8.42.tar.bz2

### 解压pcre源码

tar -jxvf pcre-8.42.tar.bz2

### 安装pcre

cd pcre-8.42 && ./configure --prefix=/home/www/telrobot/pcre && make && make install

### 下载PHP源码包

wget http://cn2.php.net/distributions/php-7.3.12.tar.bz2

### 解压php源码

tar -jxvf php-7.3.12.tar.bz2

### 检查配置

cd php-7.3.12 && ./configure --prefix=/home/www/telrobot/php --with-config-file-path=/home/www/telrobot/php/etc --enable-mbstring --with-openssl --enable-ftp --with-gd --with-jpeg-dir=/usr --with-png-dir=/usr --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pear --enable-sockets --with-freetype-dir=/usr --with-zlib --with-libxml-dir=/usr --with-xmlrpc --enable-zip --enable-fpm --enable-xml --enable-sockets --with-gd --with-zlib --with-iconv --enable-zip --with-freetype-dir=/usr/lib/ --enable-soap --enable-pcntl --enable-cli --with-curl --enable-json --enable-posix --enable-session --enable-intl --enable-opcache --with-bz2 --enable-pdo --enable-fileinfo --enable-bcmath

### 编译安装

make && make install

#### 参数说明

- **--prefix** : 指定php安装目录
- **--with-config-file-path** : 指定配置文件目录
- **--enable-\*、--with-\*** : 安装时引入相应扩展

<script>
var pageId = "php编译安装"
</script>

!INCLUDE "../../common/gitalk.html"
