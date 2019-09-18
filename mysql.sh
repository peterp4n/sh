	### http://www.solanara.net/solanara/memcached
	### http://xinet.kr/?p=991
	### https://dev.mysql.com/doc/refman/5.7/en/innodb-memcached-setup.html  
	# cmake \
	-DBUILD_CONFIG=mysql_release \
	-DCMAKE_INSTALL_PREFIX=/web/mysql5 \
	-DMYSQL_DATADIR=/web/mysql5/data \
	-DWITH_EXTRA_CHARSETS=all \
	-DENABLED_LOCAL_INFILE=1 \
	-DDOWNLOAD_BOOST=1 \
	-DWITH_BOOST=./boost \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DWITH_FEDERATED_STORAGE_ENGINE=1 \
	-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DMYSQL_UNIX_ADDR=/web/mysql5/data/mysql.sock \
	-DSYSCONFDIR=/etc \
	-DDEFAULT_CHARSET=utf8 \
	-DDEFAULT_COLLATION=utf8_general_ci \
	-DWITH_INNODB_MEMCACHED=ON \
	-DENABLE_DTRACE=ON 
	# make -j `grep processor /proc/cpuinfo | wc -l`
	# make install 
 
	# /web/mysql5/bin/mysql_install_db --user=mysql --datadir=/web/mysql5/data
	# mysql -uroot -p
	mysql> source /web/mysql5/share/innodb_memcached_config.sql
	mysql> INSTALL PLUGIN daemon_memcached soname "libmemcached.so";
	mysql> DESCRIBE innodb_memcache.containers;
  

https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/binary-installation.html


cmake \
-DCMAKE_INSTALL_PREFIX=/home/server/mysql \
-DMYSQL_DATADIR=/home/server/mysql/data \
-DWITH_EXTRA_CHARSETS=all \
-DENABLED_LOCAL_INFILE=1 \
-DSYSCONFDIR=/etc \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_BOOST=./boost \

-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \

   
make

make install

./mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data 



### 참고사이트
https://osskdb.wordpress.com/2016/09/30/mysql-5-7-x-%EC%84%A4%EC%B9%98/
https://dev.mysql.com/doc/refman/5.7/en/binary-installation.html
#### mysql 5.7.17 binary install 
00. cd /usr/local
01. wget mysql-VERSION-OS.tar.gz
02. tar xvzf mysql-VERSION-OS.tar.gz
03. mv mysql-VERSION-OS mysql
04. cd mysql
05. mkdir data mysql-files
06. chown mysql. -R ../mysql
07. ./bin/mysqld --initialize --user=mysql	# MySQL 5.7.6 and up
08. ./bin/mysqld_safe --user=mysql &
09. ./bin/mysql -uroot -p
    Enter password: ptpiGPrw)0Rc <임시 비밀번호 입력
mysql> alter user 'root'@'localhost' identified by 'new password';
mysql> set password=password('new password');
11. cp support-files/mysql.server /etc/init.d/mysql.server
 
### my.cnf create
[mysqld]
user = mysql
port = 3306
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
socket=/tmp/mysql.sock
innodb_data_file_path=ibdata1:12M:autoextend
innodb_log_files_in_group=2
innodb_log_file_size=50M

[mysqld_safe]
log-error=/usr/local/mysql/data/mysqld.log


