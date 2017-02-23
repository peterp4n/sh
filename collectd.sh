collectd 

### download
https://collectd.org/download.shtml
http://collectd.org/

### install
$ yum -y install rrdtool-devel
$ ./configure --prefix=/home/server/collectd --enable-rrdtool --enable-debug --enable-write_graphite --enable-logfile
$ make
$ make install


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

