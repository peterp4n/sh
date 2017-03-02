sed -i "s/#define DEFAULT_SERVER_LIMIT 256/#define DEFAULT_SERVER_LIMIT 1024/g" server/mpm/prefork/prefork.c
sed -i "s/#define DEFAULT_SERVER_LIMIT 16/#define DEFAULT_SERVER_LIMIT 64/g" server/mpm/worker/worker.c
sed -i "s/User daemon/User apache/g" docs/conf/httpd.conf.in
sed -i "s/Group daemon/Group apache/g" docs/conf/httpd.conf.in
sed -i "s/#ServerName www.example.com:@@Port@@/ServerName 000.000.000.000/g" docs/conf/httpd.conf.in
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




### extra/httpd-php.conf
# php handler
<filesmatch \.(html|php|inc)$>
      SetHandler application/x-httpd-php
</filesmatch>

<filesmatch \.phps$>
      SetHandler application/x-httpd-php-source
</filesmatch>


