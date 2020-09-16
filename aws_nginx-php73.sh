1. timezone set

2. base util install

3. nginx install
yum -y install nginx
service nginx start
chkconfig nginx on

4. php, php-fpm 7.2 install
yum -y install php72 php72-common php72-devel php72-process php72-cli php72-fpm php72-json php72-pdo php72-mysqlnd php72-pgsql 
                     php72-pecl-igbinary php72-pecl-imagick php72-pecl-redis php72-gd php72-xml php72-pecl-imagick-devel php72-mbstring
service php-fpm start
chkconfig php-fpm on

sudo vi /etc/php-fpm.d/www.conf
user = apache => nginx
group = apache => nginx

service php-fpm reload
