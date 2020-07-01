
yum install libaio

###########################
# mysql 5.7
###########################
### mysql rpm install
https://dev.mysql.com/doc/refman/5.7/en/linux-installation-yum-repo.html
yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum install -y mysql-community-server
systemctl start mysqld
grep 'temporary password' /var/log/mysqld.log
mysql_secure_installation
mysql -uroot -p
alter user 'root'@'localhost' identified by 'password';

### 참고
yum repolist all | grep mysql
yum-config-manager --disable mysql56-community
yum-config-manager --enable mysql57-community
yum repolist enabled | grep mysql
yum module disable mysql



#### mysql 5.7.17 binary install 
https://osskdb.wordpress.com/2016/09/30/mysql-5-7-x-%EC%84%A4%EC%B9%98/
https://dev.mysql.com/doc/refman/5.7/en/binary-installation.html
groupadd mysql
useradd -r -g mysql -s /bin/false mysql
cd /usr/local
wget mysql-VERSION-OS.tar.gz
tar xvzf mysql-VERSION-OS.tar.gz
mv mysql-VERSION-OS mysql
cd mysql
mkdir data mysql-files
chown mysql. -R ../mysql
./bin/mysqld --initialize --user=mysql	# MySQL 5.7.6 and up
./bin/mysql_ssl_rsa_setup
./bin/mysqld_safe --user=mysql &
./bin/mysql -uroot -p
    Enter password: ptpiGPrw)0Rc <임시 비밀번호 입력
mysql> alter user 'root'@'localhost' identified by 'new password';
mysql> set password=password('new password');
cp support-files/mysql.server /etc/init.d/mysql.server



### my.cnf add
[mysqld]
sql_mode = '' <=== strict_trans_tables disabled  중요해










### mysql account add
mysql> CREATE DATABASE dbname;
mysql> CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'db_pass';
mysql> GRANT ALL ON dbname.* TO 'db_user'@'localhost';
mysql> FLUSH PRIVILEGES;


###########################
# mysql 8.0
###########################

## 계정삭제
DROP USER 'redmine'@'localhost';
 
## 계정생성
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'redmine';
GRANT ALL ON redmine.*   TO 'redmine'@'localhost';

## 디비생성
CREATE DATABASE redmine CHARACTER SET utf8;



###########################
# mysql migration
###########################
#!/bin/sh

if [ $# -ne 5 ]; then
echo "Usage: ${0} <REMOTE_HOST> <REMOTE_DB> <REMOTE_DB_ID> <REMOTE_DB_PW> <LOCAL_TARGET_DB>"
echo "<Example>"
echo "REMOTE_HOST : 192.168.100.10"
echo "REMOTE_DB : snsdb"
echo "REMOTE_DB_ID : sns"
echo "REMOTE_DB_PW : sns12#"
echo "LOCAL_TARGET_DB : kth_snsdb"
echo "==> ${0} targetdb01 snsdb sns sns12# kth_snsdb"
exit 1
fi

## Exec profile for mysql user
. ~/.bash_profile

## Declare Valiables
REMOTE_HOST=${1}
REMOTE_DB=${2}
REMOTE_DB_ID=${3}
REMOTE_DB_PW=${4}
LOCAL_TARGET_DB=${5}

echo ">> Start Migration $db database"

echo ">> Drop and Create Database at Local Host"
mysql -uroot -p${ADMIN_PWD} -e"DROP DATABASE IF EXISTS ${LOCAL_TARGET_DB};CREATE DATABASE ${LOCAL_TARGET_DB};"

echo ">> Dump, Rename DB name, Insert Data"
mysqldump -u${REMOTE_DB_ID} -p${REMOTE_DB_PW} --host=${REMOTE_HOST} --single-transaction --no-create-db --databases ${REMOTE_DB} | sed -r 's/^USE `(.*)`;$/USE `'${LOCAL_TARGET_DB}'`/g' | mysql -uroot -p${ADMIN_PWD} ${LOCAL_TARGET_DB}

echo ">> Finish Migration $db database"




















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
 
