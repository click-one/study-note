# 编译安装mysql

## 环境

**centos7**

## 安装过程

### 创建用户

useradd -s /sbin/nologin mysql

### 解决mysql依赖

yum install cmake gcc gcc-c++ ncurses-devel bison zlib libxml openssl automake autoconf make libtool bison-devel libaio-devel

### 安装boost

wget https://jaist.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.bz2

tar -jxvf boost_1_59_0.tar.bz2


### 下载源码包

wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.20.tar.gz

### 解压

tar zxvf mysql-5.7.20.tar.gz

### 配置安装

cd mysql-5.7.20

cmake  .  -DCMAKE_INSTALL_PREFIX=/home/www/telrobot/mysql \
-DMYSQL_UNIX_ADDR=/home/www/telrobot/mysql/tmp/mysql.sock \
-DMYSQL_DATADIR=/home/www/telrobot/mysql/data \
-DSYSCONFDIR=/home/www/telrobot/mysql/etc \
-DMYSQL_USER=mysql \
-DMYSQL_TCP_PORT=3306 \
-DWITH_XTRADB_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_EXTRA_CHARSETS=1 \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_bin \
-DEXTRA_CHARSETS=all \
-DWITH_BIG_TABLES=1 \
-DWITH_DEBUG=0 \
-DWITH_BOOST=/home/www/telrobot/boost_1_59_0

make && make install

### 安装后初始化

./bin/mysqld  --initialize --user=mysql --datadir=/home/www/telrobot/mysql/data  --basedir=/home/www/telrobot/mysql

**注意输出数据最后一行,会生成密码,注意保存**

2019-12-23T12:35:29.920934Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2019-12-23T12:35:31.322621Z 0 [Warning] InnoDB: New log files created, LSN=45790
2019-12-23T12:35:31.684584Z 0 [Warning] InnoDB: Creating foreign key constraint system tables.
2019-12-23T12:35:31.790832Z 0 [Warning] No existing UUID has been found, so we assume that this is the first time that this server has been started. Generating a new UUID: b56a56fc-2580-11ea-82fb-52540032a88c.
2019-12-23T12:35:31.796422Z 0 [Warning] Gtid table is not ready to be used. Table 'mysql.gtid_executed' cannot be opened.
2019-12-23T12:35:31.797068Z 1 [Note] A temporary password is generated for root@localhost: 8dki0fhMOL_I

### 启动服务

./bin/mysqld --port=3390 --basedir=/home/www/telrobot/mysql --datadir=/home/www/telrobot/mysql/data --user=root

### 修改初始密码

./bin/mysql -uroot -P3390 -p8dki0fhMOL_I

set password for root@localhost = password('zhangdeman');

## 可能出现的问题

- 服务启动报错,类似如下:

2019-12-24T02:48:10.711352Z 0 [ERROR] Could not create unix socket lock file /var/lib/mysql/mysql.sock.lock.

2019-12-24T02:48:10.711360Z 0 [ERROR] Unable to setup unix socket lock file.

2019-12-24T02:48:10.711365Z 0 [ERROR] Aborting

我们在编译时已经指定socket路径,这个路径和我们期望的路径不一致, 此时需要看看是不是系统中已经安装其他mysql服务,配置文件冲突.执行命令:

**./mysql/bin/mysqld --verbose --help |grep -A 1 'Default options'**

会列出所有加载配置文件的路径,我的本机中包含如下路径:

/etc/my.cnf /etc/mysql/my.cnf /home/www/telrobot/mysql/etc/my.cnf ~/.my.cnf

可以看到我们指定的配置文件路径在查找中排在第三位,如果前两个位置已经有配置文件,不会加载我们期望的配置文件.

- 服务启动报错,信息如下:

2019-12-24T03:09:19.997957Z 0 [ERROR] Could not create unix socket lock file /home/www/telrobot/mysql/tmp/mysql.sock.lock.

2019-12-24T03:09:19.997963Z 0 [ERROR] Unable to setup unix socket lock file.

2019-12-24T03:09:19.997967Z 0 [ERROR] Aborting

原因是我们指定的socket存储目录对于mysql用户没有写入权限,执行如下命令:

**chown -R mysql:mysql /home/www/telrobot/mysql/tmp**

将目录所有者修改为mysql即可

- 服务启动报错,报错信息如下:

2019-12-24T03:44:37.460172Z 0 [ERROR] Fatal error: Please read "Security" section of the manual to find out how to run mysqld as root!

2019-12-24T03:44:37.460216Z 0 [ERROR] Aborting

报错原因,使用root用户启动了mysql服务,**不建议这样使用**,开发环境或自己环境,可以在启动服务时增加参数 : **--user=root**, 来使用root用户启动服务

- 客户端连接后,查询报错,信息如下:

mysql> show databases;

ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.

原因是使用的是初始化事分配的默认密码,修改掉默认密码即可,执行如下命令:

**set password for root@localhost = password('你的密码');**

## 编译安装参数说明

- -DCMAKE_INSTALL_PREFIX 指定安装目录
- -DMYSQL_UNIX_ADDR 指定服务器侦听套接字连接的Unix套接字文件路径，**默认/tmp/mysql.sock**。 这个值可以在服务器启动时用–socket选项来设置。所以这条可以去掉
- -DMYSQL_DATADIR MySQL数据目录的位置。 该值可以在服务器启动时使用–datadir选项进行设置。
- -DSYSCONFDIR 默认的my.cnf选项文件目录。 此位置不能在服务器启动时设置，但可以使用 **–defaults-file = file_name** 选项使用给定的选项文件启动服务器，其中file_name是该文件的完整路径名。
- -DMYSQL_USER=mysql 指定用户名
- -DMYSQL_TCP_PORT=3306 服务器侦听TCP / IP连接的端口号。默认值是3306。 该值可以在服务器启动时使用–port选项进行设置。
- -DWITH_XTRADB_STORAGE_ENGINE=1 储存引擎 XTRADB
- -DWITH_INNOBASE_STORAGE_ENGINE=1 储存引擎 INNOBASE
- -DWITH_PARTITION_STORAGE_ENGINE=1 储存引擎 PARTITION
- -DWITH_BLACKHOLE_STORAGE_ENGINE=1 储存引擎 BLACKHOLE
- -DWITH_MYISAM_STORAGE_ENGINE=1 储存引擎 MYISAM
- -DWITH_READLINE=1
- -DENABLED_LOCAL_INFILE=1 该选项控制MySQL客户端库的已编译默认LOCAL功能?没太懂
- -DWITH_EXTRA_CHARSETS=1 这个为什么是1，文档不是name ，字符串吗？ 要包含哪些额外的字符集： all complex none
- -DDEFAULT_CHARSET=utf8 服务器字符集。默认情况下，MySQL使用latin1（cp1252西欧）字符集。 该值可以在服务器启动时使用 **–character_set_server** 选项进行设置。
- -DDEFAULT_COLLATION 服务器整理。默认情况下，MySQL使用latin1_swedish_ci。该值可以在服务器启动时使用 **–character_set_server** 选项进行设置。
- -DEXTRA_CHARSETS=all
- -DWITH_BIG_TABLES=1
- -DWITH_DEBUG=0 是否包含调试支持。


<script>
var pageId = "mysql编译安装"
</script>

!INCLUDE "../../common/gitalk.html"
