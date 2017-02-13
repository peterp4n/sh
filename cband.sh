https://wiki.mooo.org/w/%EC%95%84%ED%8C%8C%EC%B9%98_mod_cband_%EB%AA%A8%EB%93%88

1. 다운로드
wget http://pkgs.fedoraproject.org/repo/pkgs/mod_cband/mod-cband-0.9.7.5.tgz/5c5d65dc9abe6cdc6931b6dd33be5018/mod-cband-0.9.7.5.tgz

2. patch
# sed s/remote_ip/client_ip/g -i src/mod_cband.c
# sed s/c-\>remote_addr/c-\>client_addr/g -i src/mod_cband.c

3. /cband-status 기능에서 글꼴의 크기 수정 
# src/mod_cband.c 파일의 2485번째 줄 근처에 보면 화면 글꼴을 설정하는 CSS가 있으니 이를 적당한 값으로 고치면 된다. 

4. 설치
# ./configure --with-apxs=/web/apache/bin/apxs
# make
# make install

5. 설정
# /cband-status 기능에 대한 접근 
<IfModule cband_module>
    CBandScoreFlushPeriod 500
    CBandRandomPulse Off

    <Location /cband-status>
        SetHandler cband-status
        Order deny,allow
        Deny from all
        # for admin
        Allow from 127.0.0.1 111.111.111.111/24
    </Location>

    <Location /cband-status-me>
        SetHandler cband-status-me
        Order deny,allow
        Deny from all
        # for admin
        Allow from 127.0.0.1 111.111.111.111/24
    </Location>
</IfModule>

# mod_cband의 설정은 ServerName 설정 이후에 설정
<VirtualHost *>
    ServerName my.sample.com
...
    <IfModule cband_module>
        CBandLimit 500Mi
        CBandExceededSpeed 128bps 5 10
        CBandPeriod 1D

        CBandSpeed 2Mbps 50 150
        CBandRemoteSpeed 1Mbps 20 20
    </IfModule>
...
</VirtualHost>

# 특정 사용자가 여러 가상 호스트를 소유하고 있을 때, 특정 사용자가 소유한 모든 가상 호스트를 통합해서 제어하고자 할 때는 CBandUser를 설정한다
<IfModule cband_module>
...
    <CBandUser sam>
        CBandUserLimit 500Mi
        CBandUserExceededSpeed 128bps 5 10
        CBandUserPeriod 1D

        CBandUserSpeed 2Mbps 50 150
    </CBandUser>
</IfModule>

<VirtualHost *>
    ServerName sam.sample.com
...
    <IfModule cband_module>
        CBandUser sam
        CBandRemoteSpeed 1Mbps 20 20
    </IfModule>
...
</VirtualHost>

<VirtualHost *>
    ServerName sam2.sample.com
...
    <IfModule cband_module>
        CBandUser sam
        CBandRemoteSpeed 1Mbps 20 20
    </IfModule>
...
</VirtualHost>
