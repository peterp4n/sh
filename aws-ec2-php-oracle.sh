
##############################################################################
###### 아마존 리눅스에 APACHE + PHP + ORACLE 설치
##############################################################################
01. yum makecache fast
02. yum -y update
03. yum -y install rdate htop mc nmap fail2ban rec2
04. timezone 설정
   1) /etc/sysconfig/clock 수정
      ZONE = "Asia/Seoul"
      UTC=false
   2) mv /etc/localtime /etc/localtime.UTC
      cp -p /usr/share/zoneinfo/Asia/Seoul /etc/localtime
   3) tzselect 
      5(Asia) => 23(Korea south)
   4) rdate -s time.bora.net
05. yum -y group install 'Development tools'
06. yum -y install httpd24* php71* 
07. /etc/profile edit
##################### oracle oci setting
export ORACLE_HOME=/usr/lib/oracle/18.5
export TNS_ADMIN=$ORACLE_HOME/NETWORK/admin
export LD_LIBRARY_PATH=$ORACLE_HOME:$ORACLE_HOME/sdk
export PATH=$PATH:$ORACLE_HOME:$ORACLE_HOME/bin
export PHP_DTRACE=yes

##################### nodejs setting
export NODEJS_HOME=/web/nodejs6
export PATH=$PATH:$NODEJS_HOME/bin
08. source /etc/profile
09. download oracle 18c instantclient  패키지 다운로드 / 설치
   https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
   download instantclient-basic-linux.x64-version.zip
   download instantclient-sdk-linux.x64-version.zip
   download instantclient-sqlplus-linux.x64-version.zip <-- sqlplus 사용으로 필요, 사용치 않으면 필요없음   
   unzip *	
   mv instantclient_18_5/ /usr/lib/oracle/18.5
   mkdir -p /usr/lib/oracle/18.5/bin /usr/lib/oracle/18.5/doc /usr/lib/oracle/18.5/NETWORK/admin 
   ln -s libclntsh.so.18.5 libclntsh.so
   ln -s libocci.so.18.5 libocci.so
   mv adrci exp expdp genezi imp impdp sqlldr sqlplus uidrvci wrc bin 
   mv BASIC_README glogin.sql SQLPLUS_README TOOLS_README
   vi NETWORK/admin/sqlnet.ora
DIAG_ADR_ENABLED=off

TRACE_LEVEL_CLIENT=off
LOG_FILE_CLIENT=/dev/null

   vi NETWORK/admin/tnsnames.ora  
# tnsnames.ora Network Configuration File
# Generated by Oracle configuration tools.

ORCL =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )

서비스명 =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 아이피)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = 서비스명)
    )
  )


10. echo /usr/lib/oracle/18.5 > /etc/ld.so.conf.d/oracle-instantclient
11. ldconfig
12. oracle 접속 확인
	# sqlplus 아이디/비밀번호@//아이피:포트/서비스명  
  # sqlplus 아이디/비밀번호@서비스명
13. php7.1 down
   wget http://jp2.php.net/get/php-7.1.17.tar.gz/from/this/mirror -O php-7.1.17.tar.gz
   tar xvzf php-7.1.17.tar.gz
   cd php-7.1.17/ext/
14. oracle oci8 설치
   yum -y install systemtap-sdt-devel
   cd oci8
   phpize
   ./configure --with-oci8=instantclient,/usr/lib/oracle/18.5,18.5
   make install
   
15. oracle pdo_oci 설치 - 현재 에러 발생 (해결 방법 찾지 못함)   
   오류내용 : undefined symbol: php_pdo_unregister_driver
   cd pdo_oci
   phpize
   ./configure --with-pdo-oci=instantclient,/usr/lib/oracle/18.5,18.5
   make install

   ## PDO_OCI 는 안정화 되어 있지 않고 업데이트가 오래된 드라이버이므로 사용하지 않는 게 좋습니다.
   ## 대신 OCI8 을 래핑한 https://github.com/yajra/pdo-via-oci8 를 사용하여 PDO 를 에뮬레이션할 수 있습니다.
   
16. php.ini 설정 (오라클포함)
    extension=oci8.so
    extension=pdo_oci.so -- 에러발생시(제외시킴)
    short_tag = On
    timezone = Asia/Seoul
    display_errors = On
 17. composer install (설치가 안되어 있다면)
   curl -sS https://getcomposer.org/installer | /usr/bin/php && mv composer.phar /usr/bin/composer

 18. postfix install (확인해야됨)

