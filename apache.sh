sed -i "s/#define DEFAULT_SERVER_LIMIT 256/#define DEFAULT_SERVER_LIMIT 1024/g" server/mpm/prefork/prefork.c
sed -i "s/#define DEFAULT_SERVER_LIMIT 16/#define DEFAULT_SERVER_LIMIT 64/g" server/mpm/worker/worker.c
sed -i "s/User daemon/User apache/g" docs/conf/httpd.conf.in
sed -i "s/Group daemon/Group apache/g" docs/conf/httpd.conf.in
sed -i "s/#ServerName www.example.com:@@Port@@/ServerName ServerAddr/g" docs/conf/httpd.conf.in
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
make -j `grep -c ^processor /proc/cpuinfo`
make install

#--enable-proxy \
#--enable-proxy-http \
#--with-mpm=worker \
