rsync를 이용한 백업

1.  rsyncd.conf 설정

[b2b2_content]
path = /myProject/b2b2_content/
comment = b2b2_content.web
read only = false
transfer logging = yes
uid = apache
gid = apache
use chroot = yes
max connections = 3
timeout=600

2. rsync Daemon 실행
/usr/bin/rsync --daemon
ps -ef |grep rsync 로 데몬 실행 확인

3.rsync 명령어 실행

-source Data 끝에 / 붙이는 것이 중요

*)사전 실행
-rsync -avn(Data File Copy) --delete(Data Incr) [Source Data] [Destination IP]::[Destination Name]

*)실제 실행
-rsync -av(Data File Copy) --delete(Data Incr) [Source Data] [Destination IP]::[Destination Name]

*) 예제
rsync -av --delete --exclude 'upload' /Tmax/j2ee/project/ 1.1.1.1::b2b2_content
