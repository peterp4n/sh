#!/usr/local/bin/php -q
<?php
	$config = array();
	$config['db_pass'] = 'db root pass';
	$webRoot = 'home directory base';
	$userGroup = 'usergroup';
	$script_name = 'hostingadd';

	# check args
	if (count($argv) < 2) {
		useage();
		exit;
	}

	$conn = mysql_connect('localhost', 'root', $config['db_pass']);
	if (!$conn) {
		echo "DB Connect Fail.\n";
		exit;
	}

	#$user_id = 'h_'.$argv[1];
	$user_id = $argv[1];
	$passwd = !empty($argv[2]) ? $argv[2] : $argv[1].'123*&';
	#$sub_domain = 'h-'.$argv[1];
	$sub_domain = $argv[1];

	// user 생성
	$shell = "useradd {$user_id} -d $webRoot/{$user_id} -g $userGroup";
	shell_exec($shell);
	$shell = "echo \"{$passwd}\" | passwd --stdin {$user_id}";
	shell_exec($shell);
	$shell = "chmod 705 $webRoot/{$user_id}";
	shell_exec($shell);

	// db 생성
	$query = "GRANT ALL PRIVILEGES ON h_{$user_id}.* TO h_{$user_id}@localhost IDENTIFIED BY '{$passwd}'";
	mysql_query($query);
	$query = "CREATE DATABASE h_{$user_id}";
	mysql_query($query);
	$query = "FLUSH PRIVILEGES";
	mysql_query($query);

	// apache 설정
	$datetime = date('Y-m-d H:i:s');
	$fp = fopen('/web/apache/conf/extra/httpd-vhosts.conf', 'a');
	$cfg_str = "
	## auto-added {$datetime}
	<VirtualHost *:80>
		ServerAdmin master@google.com
		DocumentRoot \"/home/hosting/{$user_id}/www\"
		ServerName {$sub_domain}.google.com
		CBandLimit 3Gi
		CBandPeriod 1D
	</VirtualHost>
	";
	fwrite($fp, $cfg_str);
	shell_exec("/web/apache/bin/apachectl restart");

	function useage() {
		global $script_name;
		echo "useage : $script_name username [password]\n";
	}
?>
