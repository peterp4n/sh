
### mysql install
yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum install -y mysql-community-server
systemctl start mysqld
grep 'temporary password' /var/log/mysqld.log
mysql_secure_installation

### mysql account add
mysql> CREATE DATABASE dbname;
mysql> CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'db_pass';
mysql> GRANT ALL ON dbname.* TO 'db_user'@'localhost';
mysql> FLUSH PRIVILEGES;
