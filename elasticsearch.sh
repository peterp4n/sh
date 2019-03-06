### java 버전 확인해서 1.8 이상으로 교체
1. 버전확인
$ java -version
2. 최신버전설치 
$ yum -y install java-최신버전
3. 최신버전 선택 
$ /usr/sbin/alternatives --config java

### max file descriptors
1. ulimit -Hn
2. limits.conf 편집
$ vi /etc/security/limits.conf 의 하단에 내용추가후 재접속
*        hard    nofile           65536
*        soft    nofile           65536

### 가상메모리 증가
1. sudo sysctl -a | grep vm.max_map_count
2. 일시적 증가
sudo sysctl -w vm.max_map_count=262144
2. 영구증가
sudo vim /etc/sysctl.conf 의 하단에 내용추가후 재접속
vm.max_map_count=262144

### Elasticsearch
1. 다운로드 https://www.elastic.co/downloads/elasticsearch
2. 압축풀기 

### Kibana
1. 다운로드 https://www.elastic.co/downloads/kibana
2. 압축풀기

### Logstash 
1. 다운로드 https://www.elastic.co/downloads/logstash
2. 압축풀기
 
 
### jvm options 설정
1. Elasticsearch/config/jvm.options 수정
Xms와 Xmx를 모두 128m로 변경 (일반적으로 서버메모리의 절반정도 적용)
Xms1g => Xms128m
Xmx1g => Xmx128m
2. Logstash/config/jvm.options 설정
Xms와 Xmx를 모두 128m로 변경
Xms1g => Xms128m
Xmx1g => Xmx128m

### Elasticsearch 설정
1. Elasticsearch/config/elasticsearch.yml 수정

### Kibana 설정
1. Elasticsearch/config/kibana.yml 수정

### Beats 설정

### Elasticsearch 시작
일반 시작 : elasticsearch/bin/elasticsearch
데몬 시작 : elasticsearch/bin/elasticsearch -d
백그라운드 시작 : nohup elasticsearch/bin/elasticsearch &


