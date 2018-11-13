1. download
   https://nodejs.org/en/download/ 
   
2. install
  tar zxvf node-v*.tar.gz
  cd node-v*
  ./configure --prefix=/web/nodejs
  make 
  make install
  
3. path 
  vi /etc/profile 
  source /etc/profile
  
4. project
  mkdir procject
  cd project
  vi package.json
  project working

## process 관리 PM2
## 참조 : https://blog.outsider.ne.kr/1197
1. 설치 
$ npm install pm2 -g

2. 실행 -(fork / cluster)
$ pm2 start server.js --name "서버이름"   -- fork(일반적인 방식) 
$ pm2 start app.js -i 0 --name "서버이름" -- cluster

3. 목록
$ pm2 list

4. 상세
$ pm2 show 서버이름

5. 정지
$ pm2 stop 서버이름

6. 재시작
$ pm2 restart 서버이름

7. 로그파일 확인
$ pm2 logs 서버이름

8. 모니터링
$ pm2 monit

9. json 실행
$ pm2 start 서버이름.json

@@ 서버이름.json
{
  "apps": [{
    "name": "example",
    "script": "서버이름.js",
    "watch": false,
    "env": {
      "NODE_ENV": "production",
      "API_PORT": 4000
    },
    "exec_mode": "cluster",
    "instances": 0
  }]
}










