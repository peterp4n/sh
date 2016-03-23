wget https://github.com/phpredis/phpredis/tree/php7 -O phpredis7.zip

/configure \
--with-php-config=/web/php5/bin/php-config \
--enable-redis \
--enable-redis-igbinary \
--enable-redis-session \
