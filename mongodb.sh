참조 : https://chichi.space/post/%ED%95%9C%EB%B2%88%EC%97%90-%EB%81%9D%EB%82%B4%EB%8A%94-AWS-EC2%EC%97%90-MongoDB-%EC%84%A4%EC%B9%98%ED%95%98%EA%B3%A0-%EB%B3%B4%EC%95%88%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0/
참조 : https://docs.mongodb.com/manual/tutorial/install-mongodb-on-amazon/

1. repo 등록
vi /etc/yum.repos.d/mongodb-org-4.0.repo  
[mongodb-org-4.0]
name=MongoDB 4.0 Repository
baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc

2. 설치
yum install -y mongodb-org
yum install -y mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools

3. 서비스 시작 / 정지
service mongod start
service mongod stop

4. 서비스 자동시작
chkconfig mongod on

5. mongodb connect
mongo

use admin
db.createUser({ user: "사용자 계정",
  pwd: "패스워드",
  roles: [ "userAdminAnyDatabase",
    "dbAdminAnyDatabase",
    "readWriteAnyDatabase"
  ]
})

use customDB
db.createUser({ user: "계정",
  pwd: "패스워드",
  roles: ["dbAdmin", "readWrite"]
})
