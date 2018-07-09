
1. xdebug
php.ini에 설정
[xdebug]
zend_extension=xdebug.so
xdebug.profiler_enable = 1
xdebug.profiler_enable_trigger = 1
xdebug.profiler_output_name = cachegrind.out.%H.%t.%p.%R
xdebug.profiler_output_dir = /tmp/xdebug/profiler
xdebug.trace_output_dir = /tmp/xdebug/output

2. webgrind - 웹으로 profile 하기위해서
   설정 : config.php에서 $defaultTimezone, $storageDir, $profilerDir만 하면 된다.
   
3. yum install -y graphviz
   graph를 python으로 그리기 위해 필요
   
   
