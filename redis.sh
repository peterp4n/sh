
########################################################################
######   redis server
########################################################################

1. download
wget http://download.redis.io/releases/redis-3.2.8.tar.gz

2. unzip
tar xvzf redis-3.2.8.tar.gz

3. compile
make
make install

4. config set
cd utils
./install_server.sh -> 설치경로설정
vi /etc/init.d/redis_6379 -> 설치경로설정

5. 실행
/etc/init.d start


########################################################################
######   redis php client
########################################################################

wget https://github.com/phpredis/phpredis/tree/php7 -O phpredis7.zip

/configure \
--with-php-config=/web/php7/bin/php-config \
--enable-redis \
--enable-redis-igbinary \
--enable-redis-session \


########################################################################
######   window redis
########################################################################
### php에 redis 연동
1. phpinfo 에서 Thread Safety 확인
Thread Safety 	enabled => ts
Thread Safety 	disabled => nts

2. php 버전에 맞는 nt/nts 구분해서 zip 다운로드
http://windows.php.net/downloads/pecl/releases/redis/3.1.6/

3. php설치된 경로에 dll파일 추가
php/ext/php_redis.dll 

4. php.ini 에 제일 하단에 추가
;[Redis]
extension=php_redis.dll

5. 아파치 재시작

6. phpinfo 에서 redis 확인


########################################################################
######   codeigniter3 에서 session을 redis로 연동
########################################################################

1. application/config/config.php 수정
$config['sess_driver'] = 'redis'; 
$config['sess_save_path'] = 'tcp://localhost:6379';




