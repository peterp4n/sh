1. down
https://about.gitlab.com/downloads/#centos6

2. default package install
sudo yum install curl openssh-server openssh-clients postfix cronie
sudo service postfix start
sudo chkconfig postfix on
sudo lokkit -s http -s ssh

3. gitlab install
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce

4. configure
sudo gitlab-ctl reconfigure

5. apach web proxy server connect
1) httpd-vhosts.conf host add
    # gitlab passthrough
    ProxyRequests off
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>
    <Location />
        ProxyPass http://localhost:8080/
        ProxyPassReverse http://localhost:8080/
    </Location>
2) httpd.conf comment remove
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so
