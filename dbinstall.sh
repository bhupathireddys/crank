#!/bin/bash
locale-gen en_US.UTF-8
sudo apt-get update

/bin/bash -c "debconf-set-selections <<< \"mysql-server mysql-server/lowercase-table-names select Enabled\""
/bin/bash -c "debconf-set-selections <<< \"mysql-community-server mysql-community-server/data-dir select 'Y'\""
/bin/bash -c "debconf-set-selections <<< \"mysql-community-server mysql-community-server/root-pass password secret\""
/bin/bash -c "debconf-set-selections <<< \"mysql-community-server mysql-community-server/re-root-pass password secret\""

sudo apt-get install -y mysql-server
sudo apt-get install -yqq locales
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.orig
cp /app/my.cnf /etc/mysql/my.cnf
rm -rf /ssd/mysql
rm -rf /ssd/log/mysql
cp -R -p /var/lib/mysql /ssd/
cp -R -p /var/log/mysql /ssd/log
mkdir -p /var/run/mysqld

chown -R mysql:mysql /var/lib/mysql /var/log/mysql /var/run/mysqld /ssd && \
    mysqld & \
    until mysql -uroot -psecret -e "exit"; do sleep 1; done && \
    mysqladmin -uroot -psecret flush-hosts && \
    mysql -uroot -psecret < create.sql

chown -R mysql:mysql /var/lib/mysql /var/log/mysql /var/run/mysqld /ssd && mysqld
