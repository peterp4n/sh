
1. down
https://goaccess.io/

2. 필요한 패키지
yum install gcc ncurses-devel GeoIP-devel

3. 설치
./configure --prefix=/web/goaccess --enable-utf8 --enable-geoip
make
make install

4. 설정
vi /etc/goaccess/goaccess.conf

# Apache/NGINX’s log formats below.
time-format %H:%M:%S  <=== 주석제거

# Apache/NGINX’s log formats below.
date-format %d/%b/%Y  <=== 주석제거

# Common Log Format (CLF)
log-format %h %^[%d:%t %^] "%r" %s %b  <=== 주석제거

5. 실행
./bin/goaccess /var/log/httpd/access.log -o webroot/weblog.html --log-format=COMMON --real-time-html


