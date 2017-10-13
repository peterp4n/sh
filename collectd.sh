collectd 

### download
https://collectd.org/download.shtml
http://collectd.org/

### install
$ yum -y install rrdtool-devel
$ ./configure --prefix=/home/server/collectd --enable-rrdtool --enable-debug --enable-write_graphite --enable-logfile
$ make
$ make install

###  init script file copy
$ cp contrib/redhat/init.d-collectd /etc/init.d/collectd
$ chmod 0755 /etc/init.d/collectd

### collectd-web install
* 미리 perl(Config:General), perl RRDs, perl(JSON), perl-rrdtool 설치
$ git clone https://github.com/httpdss/collectd-web.git
$ cd collectd-web
$ ./check_deps.sh

### collectd-web set 
$ cat /usr/etc/collectd-web.conf
  datadir: "/web/collectd/var/lib/collectd/rrd"
  libdir: "/web/collectd/var/lib/collectd"

### permission set
$ vi runserver.py
  127.0.0.1 부분을 0.0.0.0으로 수정

### web server start
$ ./runserver.py & 


### Plugins

Apache
APC UPS
Apple Sensors
Ascent
Battery
BIND
ConnTrack
ContextSwitch
CPU
CPUFreq
CSV
cURL
cURL-JSON
cURL-XML
DBI
DF
Disk
DNS
E-Mail
Entropy
Exec
FileCount
FSCache
GenericJMX
gmond
hddtemp
Interface
IPMI
IP-Tables
IPVS
IRQ
Java

libvirt
Load
LogFile
MadWifi
MBMon
memcachec
memcached
Memory
Modbus
Monitorus
Multimeter
MySQL
NetApp
Netlink
Network
NFS
nginx
Notify Desktop
Notify Email
NTPd
NUT
olsrd
OneWire
OpenVPN
OpenVZ
Oracle
Perl
Pinba
Ping
PostgreSQL
PowerDNS
Processes
Protocols
Python
RouterOS
RRDCacheD
RRDtool
Sensors
Serial
SNMP
StatsD
Swap
SysLog
Table
Tail
Tape
tcpconns
TeamSpeak2
TED
thermal
TokyoTyrant
UnixSock
Uptime
Users
UUID
vmem
VServer
Wireless
XMMS
Write HTTP
ZFS ARC

