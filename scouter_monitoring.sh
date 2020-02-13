scouter monitoring

1. down - https://github.com/scouter-project/scouter/releases
scouter-all-2.7.1.tar.gz
scouter.client.product-win32.win32.x86_64.zip

2. collect server에서 실행

tar xvzf scouter-all-2.7.1.tar.gz
cd scouter/server
./startup.sh

3. 윈도우 client 에서 실행
scouter.client.product-win32.win32.x86_64.zip 압축해제
scouter 실행
ip - server ip 입력
계정 - admin / admin

4. 각 리눅스서버에 agent 실행
tar xvzf scouter-all-2.7.1.tar.gz
cd scouter/agent.host
vi conf/scouter.conf
net_collector_ip=collect server ip 입력
./host.sh



