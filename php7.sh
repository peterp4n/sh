ext/igbinary
ext/phpredis
ext/xdebug
rm -fr configure
./buildconf --force


./configure \
--prefix=/web/php7 \
--with-apxs2=/web/apache/bin/apxs  \
--with-config-file-path=/web/apache/conf/  \
--enable-mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-pdo-dblib=/web/freetds \
--disable-debug \
--enable-bcmath \
--enable-exif \
--enable-ftp \
--enable-gd-native-ttf \
--enable-inline-optimization \
--enable-mbregex \
--enable-mbstring=kr  \
--enable-sigchild \
--enable-soap \
--enable-sockets \
--enable-sysvmsg \
--enable-sysvsem=yes \
--enable-sysvshm=yes \
--enable-xml \
--enable-zip \
--enable-wddx  \
--enable-shmop  \
--enable-calendar  \
--enable-opcache \
--enable-intl \
--enable-pcntl \
--enable-apcu \
--with-mcrypt \
--with-bz2 \
--with-iconv \
--with-curl \
--with-zlib \
--with-gd \
--with-gettext \
--with-mhash \
--with-openssl \
--with-xmlrpc \
--with-snmp \
--with-openssl-dir \
--with-xsl \
--with-pcre-regex \
--with-pear \
--with-gmp \
--with-xpm-dir \
--with-webp-dir \
--with-png-dir \
--with-jpeg-dir  \
--with-libxml-dir \
--with-freetype-dir \
--enable-wddx \
--with-zlib-dir=/usr/lib 

# fpm 설정시 
#--enable-fpm \
#--with-fpm-user=nginx \
#--with-fpm-group=nginx \

#--enable-igbinary \
#--enable-redis \
#--enable-redis-igbinary \
#--enable-redis-session \
#--with-ldap \ 
#--with-icu \
#--enable-xdebug \
# ext/redis 추가  
# yum -y install openssh* libssh* openssl* net-snmp* libxslt* re2c*

timezone = Asia/Seoul
include_path = ".:/web/php7/lib/medoo:/web/php7/lib/predis:/web/php7/lib/phpMailer:/web/php7/lib/mobile:/web/php7/lib/Snoopy"

http://browscap.org/stream?q=PHP_BrowsCapINI
https://github.com/PHPMailer/PHPMailer/
http://mobiledetect.net
http://medoo.in
https://sourceforge.net/projects/snoopy/
https://github.com/nrk/predis

[opcache]
zend_extension=/web/php5/lib/php/extensions/no-debug-non-zts-20131226/opcache.so

[igbinary]
extension=/web/php5/lib/php/extensions/no-debug-non-zts-20131226/igbinary.so

[redis]
extension=/web/php5/lib/php/extensions/no-debug-non-zts-20131226/redis.so
                                                                               
