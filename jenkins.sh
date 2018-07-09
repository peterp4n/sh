
jenkins install
1. sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo 
2. sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key 
3. sudo yum install jenkins -y 
4. sudo yum -y install java-1.8.0-openjdk
5. sudo alternatives --config java
6. sudo /etc/init.d/jenkins restart
7. sudo cat /var/lib/jenkins/secrets/initialAdminPassword 
