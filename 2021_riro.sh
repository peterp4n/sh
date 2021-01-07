yum -y update
echo "UTC=true" >> /etc/sysconfig/clock
echo "ZONE=\"Asia/Seoul\"" > /etc/sysconfig/clock
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
yum -y groupinstall 'Development Tools'
yum -y install openssl openssl-devel mod24_ssl httpd24 php72 php72-common php72-devel mysql57-server php72-pecl-scrypt 
yum -y install php72-bcmath php72-cli php72-dba php72-dbg php72-enchant php72-fpm php72-gd php72-gmp php72-intl php72-json php72-mbstring php72-mysqlnd php72-opcache php72-pdo php72-pecl-apcu php72-pecl-apcu-devel php72-pecl-igbinary php72-pecl-igbinary-devel php72-pecl-imagick php72-pecl-imagick-devel php72-pecl-mcrypt php72-pecl-oauth php72-pecl-redis php72-pecl-ssh2 php72-pecl-uuid php72-pecl-xdebug php72-pgsql php72-process php72-pspell php72-recode php72-snmp php72-soap php72-tidy php72-xml php72-xmlrpc 
sed -i "s/#ServerName www.example.com:80/ServerName localhost:80/g" /etc/httpd/conf/httpd.conf
sed -i "s/LoadModule http2_module modules\/mod_http2.so/#LoadModule http2_module modules\/mod_http2.so/g" /etc/httpd/conf.modules.d/00-base.conf
sed -i "s/LoadModule lbmethod_heartbeat_module modules\/mod_lbmethod_heartbeat.so/#LoadModule lbmethod_heartbeat_module modules\/mod_lbmethod_heartbeat.so/g" /etc/httpd/conf.modules.d/00-proxy.conf

### scrypt install 
yum -y install php7-pear
pecl7 install scrypt
echo '' >> /etc/php.ini
echo ';scrypt' >> /etc/php.ini
echo 'extension=scrypt.so' >> /etc/php.ini


## php.ini edit
display_errors = Off/display_errors = On
;date.timezone =/date.timezone = Asia/Seoul
short_open_tag = Off/short_open_tag = On

# composer install
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer

service httpd start
chkconfig httpd on
chkconfig --list httpd


## aws-cli
yum -y install aws-cli


## java 1.8 install
yum -y install java-1.8.0
alternatives --config java


### mysql install
yum -y install mysql-server
service mysqld start
chkconfig mysqld on


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
