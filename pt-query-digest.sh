#
# This repo is managed by "percona-release" utility, do not edit!
#
[prel-release-noarch]
name = Percona Release release/noarch YUM repository
baseurl = http://repo.percona.com/prel/yum/release/$releasever/RPMS/noarch
enabled = 1
gpgcheck = 1
gpgkey = file:///etc/pki/rpm-gpg/PERCONA-PACKAGING-KEY


#!/bin/sh

DATE=`date --date='08:00 yesterday' '+%F %T'`

pt-query-digest --since "$DATE" --history=localhost --limit=100% /var/log/mariadb/slow_query.log

exit 0
