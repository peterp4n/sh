#!/bin/bash

##########################################
#                                        #
#           repositories install         #
#                                        #
########################################## 
yum makecache fast
yum -y update
yum -y group install 'Development tools'
yum -y install wget nmap mc systemtap-sdt-devel epel-release yum-utils firewalld
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

##########################################
#                                        #
#         fail2ban arpwatch 설치         #
#                                        #
##########################################
yum -y install fail2ban arpwatch

# 확인 필요 ==> sed -i 's,\(#filter = sshd-aggressive\),\1\nenabled = true,g;' /etc/fail2ban/jail.conf 
systemctl start fail2ban
systemctl enable fail2ban

systemctl start arpwatch
systemctl enable arpwatch

##########################################
#                                        #
#           SELINUX disabled             #
#                                        #
##########################################

sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
/usr/sbin/setenforce 0

##########################################
#                                        #
#               firewalld                #
#                                        #
##########################################  

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --add-port=3306/tcp
firewall-cmd --permanent --zone=public --add-port=1521/tcp
firewall-cmd --reload

systemctl start firewalld 
systemctl enable firewalld

##########################################
#                                        #
#      S.M.A.R.T. 디스크 모니터링        #
#                                        #
########################################## 

yum -y install smartmontools
systemctl enable smartd
systemctl start smartd

