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
