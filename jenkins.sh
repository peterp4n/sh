
### jenkins rpm install
1. sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo 
2. sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key 
3. sudo yum install jenkins -y 
4. sudo yum -y install java-1.8.0-openjdk
5. sudo alternatives --config java
6. sudo /etc/init.d/jenkins restart
7. sudo cat /var/lib/jenkins/secrets/initialAdminPassword 

### war install
1. 자바버전 설정 - 확인 후 1.8 미만이면 최신버전 설치

   java -version 
   yum -y install java-1.8.0-openjdk
   alternatives --config java

2. 젠킨스 down ( https://jenkins.io/download/ )
   wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

3. 젠킨스 실행 batch 파일 만들기
#!/bin/bash
# Startup script for the Jenkins

export JENKINS_HOME=/root/jenkins   ## (변경가능)
PORT=8888  ## (변경가능)

start() {
	# Start daemon.
	echo -e "Starting jenkins \n"
	nohup /usr/bin/java -jar $JENKINS_HOME/jenkins.war --httpPort=$PORT --sessionTimeout=120 -XX:+AggressiveOpts >> $JENKINS_HOME/logs/jenkins.log 2>&1 &
}

stop() {
	# Stop daemons.
	echo -e "Shutting down jenkins \n"
	pid=`ps -ef | grep jenkins |grep $PORT | awk '{print $2}'`
	kill $pid
}

# See how we were called.
case "$1" in
start)
start
;;
stop)
stop
;;
restart)
stop
start
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac

exit 0

4. apache web server에서 가상도메인 설정 (proxy reverse)



5. 웹에서 가상도메인 실행



설정하기

https://waspro.tistory.com/553?category=857042

https://kingbbode.tistory.com/35
https://jojoldu.tistory.com/356
기타
