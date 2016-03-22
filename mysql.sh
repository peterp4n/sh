	### http://www.solanara.net/solanara/memcached
	### http://xinet.kr/?p=991
	### https://dev.mysql.com/doc/refman/5.7/en/innodb-memcached-setup.html  
	# cmake \
	-DBUILD_CONFIG=mysql_release \
	-DCMAKE_INSTALL_PREFIX=/web/mysql5 \
	-DMYSQL_DATADIR=/web/mysql5/data \
	-DWITH_EXTRA_CHARSETS=all \
	-DENABLED_LOCAL_INFILE=1 \
	-DDOWNLOAD_BOOST=1 \
	-DWITH_BOOST=./boost \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DWITH_FEDERATED_STORAGE_ENGINE=1 \
	-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DMYSQL_UNIX_ADDR=/web/mysql5/data/mysql.sock \
	-DSYSCONFDIR=/etc \
	-DDEFAULT_CHARSET=utf8 \
	-DDEFAULT_COLLATION=utf8_general_ci \
	-DWITH_INNODB_MEMCACHED=ON \
	-DENABLE_DTRACE=ON 
	# make -j `grep processor /proc/cpuinfo | wc -l`
	# make install 
 
	# /web/mysql5/bin/mysql_install_db --user=mysql --datadir=/web/mysql5/data
	# mysql -uroot -p
	mysql> source /web/mysql5/share/innodb_memcached_config.sql
	mysql> INSTALL PLUGIN daemon_memcached soname "libmemcached.so";
	mysql> DESCRIBE innodb_memcache.containers;
  

