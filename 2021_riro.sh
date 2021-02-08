
######################################
#
# dev-db
# redis install
# mariadb install
#
######################################
yum -y update
## timezone set
echo "UTC=true" >> /etc/sysconfig/clock
echo "ZONE=\"Asia/Seoul\"" > /etc/sysconfig/clock
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
## amazon-linux-extras install
yum install -y amazon-linux-extras
amazon-linux-extras disable docker
amazon-linux-extras enable lamp-mariadb10.2-php7.2 redis4.0
yum install -y mariadb-server
systemctl start mariadb
mysql_secure_installation
systemctl enable mariadb
yum install -y redis redis-devel
systemctl enable redis
systemctl start redis


######################################
#
# httpd install
# php install
#
######################################
yum -y update
## timezone set
echo "UTC=true" >> /etc/sysconfig/clock
echo "ZONE=\"Asia/Seoul\"" > /etc/sysconfig/clock
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
## java 1.8 install
yum -y install java-1.8.0
alternatives --config java
yum -y groupinstall 'Development Tools'
## amazon-linux-extras install
#yum install -y amazon-linux-extras
amazon-linux-extras disable docker
amazon-linux-extras enable epel httpd_modules php7.4
yum -y install epel-release
yum -y install s3fs-fuse
## aws-cli
yum -y install aws-cli
echo "access key:secret key" > /etc/password-s3fs
vi /etc/fuse.conf
aws configure
s3fs -o allow_other -o umask=0002 rirodata /web/rirodata
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
# web server install
yum install -y httpd httpd-tools mod_ssl ImageMagick ImageMagick-devel
sed -i "s/#ServerName www.example.com:80/ServerName localhost:80/g" /etc/httpd/conf/httpd.conf
sed -i "s/LoadModule http2_module modules\/mod_http2.so/#LoadModule http2_module modules\/mod_http2.so/g" /etc/httpd/conf.modules.d/10-h2.conf
sed -i "s/LoadModule lbmethod_heartbeat_module modules\/mod_lbmethod_heartbeat.so/#LoadModule lbmethod_heartbeat_module modules\/mod_lbmethod_heartbeat.so/g" /etc/httpd/conf.modules.d/00-proxy.conf
sudo systemctl enable httpd 
sudo systemctl start httpd 
yum -y install php php-devel php-common php-cli php-mysqlnd php-pdo php-redis php-gd php-opcache php-pear php-mbstring
pecl install xdebug
pecl install imagick
pecl install scrypt
## php.ini edit
echo "zend_extension=/usr/lib64/php/modules/xdebug.so" >> /etc/php.ini
echo "extension=scrypt.so" >> /etc/php.ini
echo "extension=imagick.so" >> /etc/php.ini
sed -i "s/display_errors = Off/display_errors = On/g" /etc/php.ini
sed -i "s/;date.timezone =/date.timezone = Asia\/Seoul/g" /etc/php.ini
sed -i "s/short_open_tag = Off/short_open_tag = On/g" /etc/php.ini

# composer install
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
     
### redis install
yum -y install jemalloc jemalloc-devl lua-devel
wget http://download.redis.io/redis-stable.tar.gz
mv redis-stable.tar.gz /usr/local/src
make PREFIX=/usr/local/redis install
cd utils
./install_server.sh

Config file    : /usr/local/redis/conf/redis.conf
Log file       : /usr/local/redis/log/redis.log
Data dir       : /usr/local/redis/data
Executable     : /usr/local/redis/bin/redis-server

cd /usr/local/redis/bin/
vi redis.status
./redis.status start
 
## codecommit 자격증명충돌로 403 오류 발생시
https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-https-unixes.html#setting-up-https-unixes-credential-helper
$ git config --global credential.helper '!aws codecommit credential-helper $@'
$ git config --global credential.UseHttpPath true


## efs mount
yum -y install amazon-efs-utils
vi /etc/fstab
## efs tls  사용
fs-code                                   /web/efs-point  efs    _netdev,tls,accesspoint=fsap-code 0 0

mount -a

















