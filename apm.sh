

0. 컴파일시 필요사항
	!. yum -y groupinstall 'Developer Tools' 
	!. yum -y install zlib-devel openssl-devel pcre-devel
	!. yum -y install automake1.4 <- php에서 buildconf --force를  사용하기 위해서 
	
0. mysql [리눅스 디비서버]
	!. mysql-enterprise-gpl-5[1].1.34-linux-x86_64-glibc23.tar.gz
	!. 기능 : 디비서버
	!. 컴파일시 옵션 :  
		./configure \
		--prefix=/usr/local/mysql \
		--localstatedir=/home/sqldata \
		--enable-assembler \
		--without-debug \
		--with-mysqld-user=mysql \
		--with-charset=utf8 \
		--with-extra-charsets=complex \
		--enable-thread-safe-client
	!. 설치방법 : 
		root@root ~] # rpm -e mysql `rpm -qa |grep mysql ` --nodeps <== sqlrelay 가 설치되지 않는다.
		root@root ~] # useradd mysql 
		root@root ~] # tar xvzf mysql-enterprise-gpl-5[1].1.34-linux-x86_64-glibc23.tar.gz
		root@root ~] # mv mysql-enterprise-gpl-5.1.34-linux-x86_64-glibc23 /web/mysql5
		root@root ~] # ./scripts/mysql_install_db
		root@root ~] # cp ./support-files/mysql.server bin/
		root@root ~] # chmod 777 bin/mysql.server 
		root@root ~] # vi bin/mysql.server
		> basedir=수정
		> datadir=수정
		root@root ~] # sed -i "s/basedir=/basedir=/g" bin/mysql.server
		root@root ~] # sed -i "s/datadir=/datadir=/g" bin/mysql.server
		root@root ~] # cp support-files/my-huge.cnf /etc/my.cnf


0. apache [ 리눅스 아파치 웹서버 ] - http://httpd.apache.org
	!. 링크 : http://apache.tt.co.kr/httpd/httpd-2.4.2.tar.gz
	!. 기능 : 웹서버
	!. 설치방법 :
		root@root ~] # rpm -e apache `rpm -qa |grep apache ` --nodeps
		root@root ~] # wget http://mirror.khlug.org/apache/httpd/httpd-2.4.2.tar.gz
		root@root ~] # tar xvfj httpd-2.4.2.tar.tar.gz
		root@root ~] # cd httpd-2.4.2  

		>> MaxClient 설정 
		// server/mpm/prefork/prefork.c 256 -> 1024 변경
		root@root ~] # sed -i "s/#define DEFAULT_SERVER_LIMIT 256/#define DEFAULT_SERVER_LIMIT 1024/g" server/mpm/prefork/prefork.c
		// server/mpm/worker/worker.c 16 -> 32 변경
		root@root ~] # sed -i "s/#define DEFAULT_SERVER_LIMIT 16/#define DEFAULT_SERVER_LIMIT 64/g" server/mpm/worker/worker.c
		root@root httpd-2.2.17] # ./configure \ 
		> --prefix=/web/apache \			<- install architecture-independent files in PREFIX
		> --with-layout=Apache \			<- layout
		> --enable-modules=all \			<- Space-separated list of modules to enable | "all" | "most" 
		> --enable-mods-shared=all \		<- Space-separated list of shared modules to enable | "all" | "most"
		> --enable-vhost-alias \			<- mass virtual hosting module
		> --enable-mime-magic \				<- automagically determining MIME type
		> --enable-usertrack \				<- user-session tracking
		> --enable-speling \				<- correct common URL misspellings
		> --enable-deflate \				<- Deflate transfer encoding support
		> --enable-rewrite \				<- rule based URL manipulation
		> --enable-info \					<- server information
		> --enable-proxy \					<- Apache proxy module
		> --enable-proxy-http \				<- Apache proxy HTTP module
		> --enable-ssl \					<- OpenSSL SSL/TLS toolkit
		> --enable-so \						<- DSO capability
		> --with-mpm=worker					<- Choose the process model for Apache to use.
												MPM={beos|event|worker|prefork|mpmt_os2}
 
		# 이거 3개는 뭘까?
		> --enable-dav \ 
		> --enable-maintainer-mode   
		> --enable-cache 
		> --enable-disk-cache 
		> --enable-mem-cache
		root@root ~] # make -j 4			<- cpu 개수에 따라 숫자지정
		root@root ~] # make install

 
		
	NameVirtualHost * 
	<VirtualHost *>
		ServerName home.sorii.com
		ServerAdmin home@sorii.com
		DocumentRoot /var/www/html
	</VirtualHost>

	<VirtualHost *>
		ServerName board.sorii.com
		ServerAdmin home@sorii.com
		DocumentRoot /home/public_html/phpBB2
	</VirtualHost>

	<VirtualHost *>
		ServerName sorii.com
		# 모든 호스트에 대해
		ServerAlias *.sorii.com
		ServerAdmin home@sorii.com
		# 호스트명이 생략 되었을 경우에는 home.sorii.com으로
		Redirect /index.html http://home.sorii.com/
		# 호스트명을 매칭 시켜서 해당 폴더로 리다이렉팅
		RewriteEngine on
		RewriteCond   %{HTTP_HOST}         ^[^.]+\.sorii\.com$
		RewriteRule   ^(.+)                %{HTTP_HOST}$1     [C]
		RewriteRule   ^([^.]+)\.sorii\.com(.*) /home/public_html/$1$2
	</VirtualHost>


	<부팅 시 자동 실행>
	# vi /etc/rc.d/rc.local
	/usr/local/apache2/bin/apachectl start


0. mod_cband [ 리눅스 아파치 웹서버 트래픽 관리 툴 ]
	!. 링크 : http://codee.pl/download/cband/mod-cband-0.9.7.5.tgz
	!. 기능 : 
		* Apache2용 가볍운 트래픽제한 모듈
		* 사용자별 대역폭제한 기능
		* 가상호스트별 대역폭 제한 기능
		* 목적지별 대역폭 제한 기능
		* 제한기능:
			o 모든사용자 대역폭 제한
			o 다운로드 속제 제한
			o 초당요청수 제한
			o 아이피대역별 제한    
		* Support for virtualhosts
		* Support for defined users
		* 제한결과 웹을 통한 확인 (/cband-status)
		* 각 사용자별 제한 결과 확인(/cband-status-me)
	!. 설치방법 :
		root@root ~] # wget http://codee.pl/download/cband/mod-cband-0.9.7.5.tgz
		root@root ~] # tar xvzf mod-cband-0.9.7.5.tgz
		root@root ~] # cd mod-cband-0.9.7.5 
		root@root ~] # ./configure --with-apxs=/web/apache/bin/apxs 
		root@root ~] # make -j 4
		root@root ~] # make install
		root@root ~] #
		root@root ~] #
	!. 설치확인
		- httpd.conf 파일에
			LoadModule cband_module	modules/mod_cband.so 
		- apache/modules 디렉토리에
			mod_cband.so 
		파일이 추가 된 것을 볼수 있습니다.
	!. 기본 설정
		<Location /cband-status> 
			SetHandler cband-status
			Order deny,allow
			Deny from all
			Allow from 열어줄아이피
		</Location> 
		<Location /cband-status-me> 
			SetHandler cband-status-me
			Order deny,allow
			Deny from all
			Allow from all
		</Location> 
		==================================== 
		<VirtualHost *>
			ServerName 서버네임
			Document 홈디렉토리
			CBandLimit 300Mi
			CBandPeriod 1M
			CBandExceededURL http://서버네임/traffic_exceeded.html
		   CBandSpeed 1024 10 30
		   CBandRemoteSpeed 20kb/s 3 30
		</VirtualHost>
    

 


0. mod_security [ 리눅스 아파치 웹서버용 보안 모듈 ]
	!. 링크 : http://www.modsecurity.org/download/
	!. 기능 : 웹서버용 보안모듈
	          Mod Security 는 Apache 용 웹 방화벽이다.
		  가장 널리 알려져 있는 HTTP,HTTPS를 이용한 공격을 차단 할 수 있는 웹 방화벽이다.
		  공격의 종류는 XSS, SQL Injection, Command Execute 등을 차단하여 웹 보안에 있어서 최소한의 보안을 해주는 Apache 모듈이다.
	!. 설치방법 : 
		root@root ~] # wget http://www.modsecurity.org/download/modsecurity-apache_2.5.12.tar.gz
		root@root ~] # tar xvfz modsecurity-apache_2.5.12.tar.gz 
		root@root ~] # cd modsecurity-apache_2.5.12
		root@root ~] # cd apache2
		root@root ~] # ./configure \
				--with-apxs=/web/apache/bin/apxs \ 
				--with-apr=/web/apache/bin/apr-1-config \
				--with-apu=/web/apache/bin/apu-1-config \
				--with-pcre=/usr/local/pcre

		 [root@root ~]#    

		>> 만약 pcre 및 apr에 관련된 에러가 나온다면
		root@root ~] # yum install -y pcre* apr*
		root@root ~] # make
		root@root ~] # make install
		root@root ~] # cd ..
		root@root ~] # cp modsecurity.conf-minimal /web/apache/conf/modsecurity.conf

		apache/conf/httpd.conf 의 내용에 아래 추가
		LoadModule security2_module modules/mod_security2.so
		# Mod_Security RollSet 
		Include conf/modsecurity.conf   


0. mod_evasive [ 리눅스 아파치 웹서버용 DDOS 방어용 ]
	!. 링크 : http://www.zdziarski.com/projects/mod_evasive/ 
	!. 기능 : 웹서버용 보안모듈
	!. 설치방법 :
 
		root@root ~] # wget http://www.zdziarski.com/blog/wp-content/uploads/2010/02/mod_evasive_1.10.1.tar.gz
		root@root ~] # cd mod_evasive_1.10.1
		root@root ~] # /web/apache/bin/apxs -cia mod_evasive.c 

		apache/conf/httpd.conf 의 내용에 아래 추가
			 
			DOSHashTableSize 3097
			DOSPageCount 5
			DOSSiteCount 100
			DOSPageInterval 1
			DOSSiteInterval 1
			DOSBlockingPeriod 600
			DOSLogDir "/var/log/httpd/"
			DOSEmailNotify users@example.com


0. php를 설치하기 전에 관련 패키지 설치 및 확인
		root@root ~] # yum install libXpm*
		root@root ~] # yum install libmcrypt*
		root@root ~] # yum install ImageMagick* 

		다음의 라이브러리들이 깔려 있는지 확인한다
			libpng
			libpng-devel
			zlib
			zlib-devel
			libjpeg
			libjpeg-devel
			libjpeg6a
			# rpm -qa |grep <확인할 패키지> 없는 것이 있을 경우 찾아서 설치한다.


0. php [ 리눅스 ]
	!. 링크 : http://kr.php.net/
	!. 기능 : PHP 프로그램 모듈
	!. 설치방법 :
	
	php5_gd_patch_suhosin_patch
	php install
	#> cd php5_gd_suhosin_patch
	#> sh p.sh
	#> make -j 4
	#> make test
	#> make install


0. suhosin [ PHP 보안 ] - http://www.hardened-php.net/suhosin
	!. 링크 : http://www.hardened-php.net/suhosin
	!. 기능 : PHP 보안
	!. 다운 : 	http://download.suhosin.org/suhosin-0.9.32.1.tar.gz
				http://download.suhosin.org/suhosin-patch-5.2.14-0.9.7.patch.gz
	!. 설치방법 :  
 
	# php-suhosin-patch
	#> gunzip suhosin-patch-5.2.14-0.9.7.patch.gz
	#> cd php-5.2.14
	#> patch -p 1 -i ../suhosin-patch-5.2.14-0.9.7.patch

	# suhosin install
	#> cd suhosin-0.9.32.1
	#> /web/php5/bin/phpize
	#> ./configure \
		> --with-php-config=/web/php5/bin/php-config 
	#> make -j 4
	#> make install
 

0. imagick-3.0.1 [ 리눅스 ]
	!. 링크 : http://pecl.php.net/package/imagick
	!. 기능 : 웹서버
	!. 설치방법 : 
		imagick-3.0.1
	# imagick-3.0.1 install
	#> cd imagick-3.0.1
	#> /web/php5/bin/phpize
	#> ./configure \
		> --with-php-config=/web/php5/bin/php-config 
	#> make -j 4
	#> make install 

0. libssh2 1.2.7 [ 리눅스 ]
	!. 링크 : http://www.libssh2.org/
	!. 기능 : libssh
	!. 설치방법 : 
		libssh2 1.2.7
		./configure --prefix=/usr/local/libssh
		make -j 4
		make install


0. php_ssh2-0.11.2 [ 리눅스 ]
	!. 링크 : http://pecl.php.net/package/ssh2
	!. 기능 : 웹서버
	!. 설치방법 : 
		php_ssh2-0.11.2
		./configure \
		--with-php-config=/web/php5/bin/php-config \
		--with-ssh2=/usr/local/libssh 
		make -j 4
		make install


0. PHP-JAVA Bridge [ 리눅스 ]
	!. 링크 : http://sourceforge.net/projects/php-java-bridge/
	!. 기능 : php-java 연동
	!. 설치방법 : 
		php-java-bridge_6.2.1
		/web/php5/bin/phpize
		./configure \
		--with-php-config=/web/php5/bin/php-config \
		--with-java=/web/java/ 
		make
		make install 
 
	# vi /usr/local/php/lib/php.ini
	;Insert Data Java Module extension=java.so
	[java]
	java.java_home=/usr/local/jdk1.6.0;/usr/local/jdk1.6.0/bin
	java.java=/usr/local/jdk1.6.0/jre/bin/java

	java.java_home=/usr/local/java
	java.java=/usr/local/java/jre/bin/java
	java.log_file=/var/log/php-java-bridge.log
	java.classpath=/usr/lib/php/modules/JavaBridge.jar
	java.libpath=/usr/lib/php/modules
	extension_dir=/usr/lib/php/modules/
	extension=java.so

	[테스트]
	이번 설치예제가 Apache를 제외한 상태에서 설치를 하기때문에 웹상에서 확인을 하지 않고 콘솔상에서 직접 실행하여 확인하는 방법을 취한다.
		# echo '<?php phpinfo() ?>'| /usr/local/php/bin/php |fgrep java
	   java
	   java support => Enabled
	   java bridge => 3.2.1b
	   java status => running
	   ..........

	[사용]
	# vi test.php
	<?
		   $v = new Java("java.util.Vector");
		   $v -> add ($buf=new Java("java.lang.StringBuffer"));
		   $buf -> append("100"); echo (int)($v->elementAt(0)->toString()) + 2;
	?>
	# /usr/local/php/bin/php test.php

	[에러]
	# echo '<?php phpinfo(); ?>' | /usr/local/php/bin/php | fgrep java
	Cannot load Zend Extension Manager - it was built with configuration 1.2.0, whereas running engine is API220090626,NTS
	===>
		   # chcon -t texrel_shlib_t /usr/local/Zend/lib/ZendExtensionManager.so
		   # chcon -t texrel_shlib_t /usr/local/Zend/lib/ZendExtensionManager_TS.so
		   # chcon -t texrel_shlib_t /usr/local/Zend/lib/Optimizer-3.3.3/php-5.2.x/ZendOptimizer.so
		   # /usr/local/apache2/bin/apachectl -t
		   Syntax OK
		   # /usr/local/apache2/bin/apachectl restart





############################################################################################




nginx + apache + tomcat + php + mysql + oracle


### [ 검색엔진 ]
0. sphinx + lucene + php + zend_framework

### [ 디비서버 ]
0. mysql + replication [ mysql master server, mysql slave server ]

### [ 웹서버]
0. mysql [ mysql server ]
0. mysql middleware [ rudiments + sqlrelay ]
0. apache [ apache + mod_cband + net-snmp ] 
0. php [ php5 + gd+patched + suhosin-patched + libssh + php_ssh2 + image_magick + 


0. rudiments

0. sqlrelay

0. snort [ 침입탐지 ]
		root@root ~] yum install libpcap-devel.x86_64
		root@root ~] ./configure \
		> --prefix=/usr/local/snort \ 
		> --with-mysql=/web/mysql5 \
		> --enable-dynamicplugin 
		root@root ~] make 
		root@root ~] make install 


0. nginx [리눅스 웹서버] - http://nginx.org/
	!. 링크 : http://nginx.org/download/nginx-0.8.35.tar.gz
	!. 기능 : 웹서버
		root@root ~]
		root@root ~] ./configure \
		> --prefix=/web/nginx \ 
		> --http-client-body-temp-path=/web/tmp/nginx/client \
		> --http-proxy-temp-path=/web/tmp/nginx/proxy \
		> --http-fastcgi-temp-path=/web/tmp/nginx/fastcgi \
		> --with-http_realip_module \
		> --with-http_addition_module \
		> --with-http_sub_module \
		> --with-http_dav_module \
		> --with-http_gzip_static_module \
		> --with-http_stub_status_module \
		> --with-http_flv_module \
		> --with-http_image_filter_module \
		> --with-http_random_index_module \
		> --with-http_secure_link_module \
		> --with-http_degradation_module \
		> --with-http_ssl_module \
		> --with-cpp_test_module \
		> --with-cpu-opt=pentium4 \

		> --without-http_autoindex_module \
		> --without-http_ssi_module \
		> --without-http_userid_module \
		> --without-http_auth_basic_module \
		> --without-http_geo_module \
		> --without-http_empty_gif_module \
		> --without-http_rewrite_module \
		> --user=apache \
		> --group=apache
 
 		> --with-poll_module \   
		> --with-openssl  \   
		> --with-google_perftools_module   \
		> --add-module=./modules/ncache-2.3 \
		> --add-module=./modules/nginx-geoip-0.1  \ 

		> --with-http_geoip_module \   
		> --with-http_perl_module \
		> --with-perl=`which perl` \ 
		> --with-cc-opt="-I /usr/include/pcre" 
		root@root ~] make 
		root@root ~] make install 

user  nginx nginx;
error_log  /var/log/nginx/error.log;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile       on;
    tcp_nopush     on;
    server {
        listen       80;
        server_name  localhost;
        location / {
            root   /var/www/html
            index  index.html index.htm;
        }
		location /nginx_status {
			stub_status on;
			# disable access_log if requared
			access_log   off;
			allow 218.148.24.83;
			#allow YY.ZZ.JJ.CC;
			deny all;
		}
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}




2. snmp
	net-snmp-5.5 # ./configure --prefix=/usr/local/net-snmp --exec-prefix=/usr/local/net-snmp
	php5-gd-patch # vi acconfig.h
	#define NO_ZEROLENGTH_COMMUNITY 1







MagickWand
mrtg-2.16.2
mod_fcgid-2.3.4


mod_evasive_1.10.1
webalizer-2.21-02
  
sudo vi /etc/ld.so.conf (아래의 경로들 추가)
/lib 
/usr/lib 
/usr/local/lib 
/usr/local/mysql/lib/mysql 
 

  
================================================================================
메일 서버를 제외한 서버들의 백신 설정
--------------------------------------------------------------------------------

윈도우와 공유되는 폴더의 바이러스를 막기 위해 AntiVir 백신 설치
다운받는 곳 : http://www.hbedv.com/에서 'AntiVir Linux Server'를 다운받는다
    avlxsrv.tgz
설치
    # tar xzvf avlxsrv.tgz
    # cd antivir-server-2.0.9
    # ./install
    이후엔 대화형으로 진행된다.
    대부분 디폴트 값을 선택하고 autoupdate항목에서 y를 한다

백신이 실행될 수 있도록 cron을 추가
    # crontab -e
-다음을 마지막에 추가-------------------------------------------

 
# 매일 5시 : /home 바이러스 검사
00 05  *      *  *      echo "[cron] daily    AM 05h : /home virus check" > /dev/tty2
00 05  *      *  *      /usr/lib/AntiVir/antivir --allfiles -s -nolnk /home

 
----------------------------------------------------------------

정해진 주기 말고 업데이트를 설정하고 싶으면 자동 업데이터를 정지시키고 cron으로 업데이트 한다
    # /usr/lib/AntiVir/avupdater stop
    # crontab -e
-다음을 마지막에 추가-------------------------------------------

 
# 매 홀수날 2시 : 바이러스 패턴 업데이트
00 02 1-31/2  *  *      echo "[cron] odd days AM 02h : update virus pattern" > /dev/tty2
00 02 1-31/2  *  *      /usr/lib/AntiVir/antivir --update

 
----------------------------------------------------------------
 



3. Tomcat connector : tomcat-connectors-1.2.28-src.tar.gz

# yum install apr*

# cd native
# ./buildconf.sh
# ./configure --with-apxs=/usr/local/apache2/bin/apxs
# make
# make install

/usr/local/apache2/modules/mod_jk.so 파일 생성됨!


4. Apache tomcat : http://jakarta.apache.org/

tar xvfz apache-tomcat-5.5.28.tar.gz
mv apache-tomcat-5.5.28 /usr/local/tomcat


1) JDK6 : jdk-6u16-linux-i586.bin
download : http://java.sun.com -> Download -> Java SE -> Java SE Development Kit (JDK) :: download

# mv jdk-6u16-linux-i586.bin /usr/local
# sh jdk-6u16-linux-i586.bin
yes
# mv jdk1.6.0_16 java

# vi /etc/profile
## for JDK, Tomact, Ant setting ##
export JAVA_HOME=/usr/local/java
export CATALINA_HOME=/usr/local/tomcat
export CLASSPATH=./:$JAVA_HOME/lib/tools.jar:/usr/local/tomcat/common/lib/servlet.jar
export PATH=$PATH:$JAVA_HOME/bin:/usr/local/ant/bin

# . /etc/profile <== 변경 값 읽혀 줌!


2) ant 설치(http://ant.apache.org/bindownload.cgi)
# wget http://apache.mirror.cdnetworks.com/ant/binaries/apache-ant-1.7.1-bin.tar.gz
# tar xvfz apache-ant-1.7.1-bin.tar.gz
# mv apache-ant-1.7.1-bin /usr/local/ant



3) workers.properties 파일 만들기

# vi /usr/local/apache2/conf/workers.properties

아래 내용만 입력 후 저장

#
# @(#)workers.properties
#
# Workers
worker.list=tomcat,wlb,jkstatus

# Tomcat Worker
worker.ajp13.type=tomcat
worker.ajp13.port=8009

# Load Balancer Worker
worker.wlb.type=lb
worker.wlb.balance_workers=tomcat

# Status Worker
worker.jkstatus.type=status

# EOF

 

4) 톰캣의 server.xml 수정
# vi /usr/local/tomcat/conf/server.xml


맨 아래에 기존 <host> 부분 주석처리하고 아래 내용 추가
      <Host name="localhost" appBase="webapps"
       unpackWARs="true" autoDeploy="true"
       xmlValidation="false" xmlNamespaceAware="false">

                <Context docBase="/home/www/htdocs" path=""
                 useNaming="true" workDir="/home/www/work"
                 reloadable="true">
                </Context>

      </Host>


<!-- VirtualHost 추가시 -->
      <Host name="jonny.co.kr" appBase="webapps"
       unpackWARs="true" autoDeploy="true"
       xmlValidation="false" xmlNamespaceAware="false">

                <Context docBase="/home/www/jonny.co.kr" path=""
                 useNaming="true" workDir="/home/www/jonny.co.kr/work"
                 reloadable="true">
                </Context>

      </Host>

      <Host name="jcc.kr" appBase="webapps"
       unpackWARs="true" autoDeploy="true"
       xmlValidation="false" xmlNamespaceAware="false">

                <Context docBase="/home/www/jcc" path=""
                 useNaming="true" workDir="/home/www/jcc/work"
                 reloadable="true">
                </Context>

      </Host>
            :
            :

5) httpd.conf 수정
/usr/local/apache2/conf/httpd.conf 설정 파일에 아래의 코드를 추가


# vi /usr/local/apache2/conf/httpd.conf

LoadModule jk_module modules/mod_jk.so


<IfModule mod_jk.c>
    JkWorkersFile conf/workers.properties
</IfModule>

ServerName www.abc.co.kr:80

DocumentRoot "/home/html/www.abc.co.kr/htdocs"

<Directory /home/html/www.abc.co.kr/htdocs>
    Allow from all
</Directory>


RewriteEngine On
RewriteCond %{REQUEST_METHOD} ^TRACE
RewriteRule .* - [F]

RewriteRule CVS/(.*)$ /error/error_404.jsp [PT]


<IfModule mod_jk.c>
JkMount  /*.jsp         tomcat
JkMount  /*.do          tomcat
</IfModule>

<IfModule dir_module>
    DirectoryIndex  index.html index.jsp
</IfModule>

ErrorDocument 403 /error/error_403.jsp
ErrorDocument 404 /error/error_404.jsp
ErrorDocument 500 /error/error_500.jsp

6) vhost.conf 셋팅
# vi /usr/local/apache2/conf/extra/httpd-vhosts.conf
<VirtualHost *:80>
        DefaultLanguage     ko
        AddDefaultCharset   UTF-8
        ServerAdmin         test@abc.co.kr

        ServerName          www.abc.co.kr
        ServerAlias         abc.co.kr

        DocumentRoot        /home/html/www.abc.co.kr/htdocs
        DirectoryIndex      index.html index.jsp index.do

        CustomLog           "|/usr/local/apache2/bin/rotatelogs /home/html/www.abc.co.kr/logs/access-%Y-%m-%d.log 86400"
 combined
        ErrorLog            "|/usr/local/apache2/bin/rotatelogs /home/html/www.abc.co.kr/logs/error-%Y-%m-%d.log 86400"

        ErrorDocument           403 /error/error_403.jsp
        ErrorDocument           404 /error/error_404.jsp
        ErrorDocument           500 /error/error_500.jsp
   
    <Directory /home/html/www.abc.co.kr/htdocs>
                Allow from all
    </Directory>
   
    RewriteEngine On
        RewriteCond %{REQUEST_METHOD} ^TRACE
        RewriteRule .* - [F]

        # Prevent CVS directory
        RewriteRule CVS/(.*)$ /error/error_404.jsp [PT]
   
    <IfModule mod_jk.c>
                JkMount  /*.jsp         tomcat
                JkMount  /*.do          tomcat
    </IfModule>
</VirtualHost> 
