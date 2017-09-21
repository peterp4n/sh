sed -i "s/#define DEFAULT_SERVER_LIMIT 256/#define DEFAULT_SERVER_LIMIT 1024/g" server/mpm/prefork/prefork.c
sed -i "s/#define DEFAULT_SERVER_LIMIT 16/#define DEFAULT_SERVER_LIMIT 64/g" server/mpm/worker/worker.c
sed -i "s/User daemon/User apache/g" docs/conf/httpd.conf.in
sed -i "s/Group daemon/Group apache/g" docs/conf/httpd.conf.in
sed -i "s/#ServerName www.example.com:@@Port@@/ServerName 000.000.000.000/g" docs/conf/httpd.conf.in
yum -y install pcre*
./configure \
--prefix=/web/apache \
--with-layout=Apache \
--with-included-apr \
--with-pcre \
--enable-modules=all \
--enable-mods-shared=all \
--enable-vhost-alias \
--enable-mime-magic \
--enable-usertrack \
--enable-speling \
--enable-deflate \
--enable-rewrite \
--enable-info \
--enable-ssl \
--enable-so
make -j `grep processor /proc/cpuinfo | wc -l`
make install

#make -j `grep -c ^processor /proc/cpuinfo`
#--enable-proxy \
#--enable-proxy-http \
#--with-mpm=worker \

### httpd.conf
<Directory />
    #AllowOverride none
    #Require all denied
    AllowOverride All
</Directory>

# PHP set
Include conf/extra/httpd-php.conf

<IfModule mod_deflate>
#AddType text/css  .css
#AddType application/xml .xml
#AddType application/javascript  .js
#AddType application/x-httpd-php .php 
#AddType application/x-httpd-php-source .phps

# Legacy versions of Apache
AddOutputFilterByType DEFLATE text/plain text/html text/css text/xml
AddOutputFilterByType DEFLATE application/xhtml+xml application/xml application/rss+xml
AddOutputFilterByType DEFLATE application/json application/javascript application/x-javascript

DeflateCompressionLevel 9          #사용할 압축레벨을 선택, 값이 클수록 압축률이 증가하지만, CPU를 더 많이 사용함

BrowserMatch ^Mozilla/4 gzip-only-text/html                # Netscape 4.xx에는 HTML만 압축해서 보냄
BrowserMatch ^Mozilla/4\.0[678] no-gzip                   # Netscape 4.06~4.08에는 압축해서 보내지 않음
BrowserMatch \bMSIE !no-gzip !gzip-only-text/html     # 자신을 Mozilla로 알리는 MSIE에는 그대로 압축해서 보냄

# 압축하지 않을 파일들을 지정
SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png|bmp|zip|tar|rar|alz|a00|ace|txt|mp3|mpe?g|wav|asf|wma|wmv|swf|exe|pdf|doc|xsl|hwp|java|c|t?gz|bz2|7z)$ no-gzip dont-vary

</ifModule>

<IfModule filter_module>
# HTML, TXT, CSS, JavaScript, JSON, XML, HTC:
FilterDeclare   COMPRESS
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$text/html'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$text/css'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$text/plain'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$text/xml'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$application/javascript'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$application/json'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$application/xml'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$application/xhtml+xml'"
FilterProvider  COMPRESS  DEFLATE "%{CONTENT_TYPE} = '$application/rss+xml'"
FilterChain     COMPRESS
FilterProtocol  COMPRESS  DEFLATE change=yes;byteranges=no
</IfModule>



### extra/httpd-php.conf 파일추가
# php handler
<filesmatch \.(html|php|inc)$>
      SetHandler application/x-httpd-php
</filesmatch>

<filesmatch \.phps$>
      SetHandler application/x-httpd-php-source
</filesmatch>


