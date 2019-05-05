#!/bin/bash

# init mysql
service mysql start
sleep 3
mysql -uroot -proot < /data/init.sql
sleep 3
service mysql stop

