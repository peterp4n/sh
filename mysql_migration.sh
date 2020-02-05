#!/bin/sh

if [ $# -ne 5 ]; then
echo "Usage: ${0} <REMOTE_HOST> <REMOTE_DB> <REMOTE_DB_ID> <REMOTE_DB_PW> <LOCAL_TARGET_DB>"
echo "<Example>"
echo "REMOTE_HOST : 192.168.100.10"
echo "REMOTE_DB : snsdb"
echo "REMOTE_DB_ID : sns"
echo "REMOTE_DB_PW : sns12#"
echo "LOCAL_TARGET_DB : kth_snsdb"
echo "==> ${0} targetdb01 snsdb sns sns12# kth_snsdb"
exit 1
fi

## Exec profile for mysql user
. ~/.bash_profile

## Declare Valiables
REMOTE_HOST=${1}
REMOTE_DB=${2}
REMOTE_DB_ID=${3}
REMOTE_DB_PW=${4}
LOCAL_TARGET_DB=${5}

echo ">> Start Migration $db database"

echo ">> Drop and Create Database at Local Host"
mysql -uroot -p${ADMIN_PWD} -e"DROP DATABASE IF EXISTS ${LOCAL_TARGET_DB};CREATE DATABASE ${LOCAL_TARGET_DB};"

echo ">> Dump, Rename DB name, Insert Data"
mysqldump -u${REMOTE_DB_ID} -p${REMOTE_DB_PW} --host=${REMOTE_HOST} --single-transaction --no-create-db --databases ${REMOTE_DB} | sed -r 's/^USE `(.*)`;$/USE `'${LOCAL_TARGET_DB}'`/g' | mysql -uroot -p${ADMIN_PWD} ${LOCAL_TARGET_DB}

echo ">> Finish Migration $db database"
