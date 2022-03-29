#!/bin/bash

username=$1
password=$2
hostIP=$3
database=$4
test_directory=$5
active_idle_conn=${test_directory}/active_idle_conn.csv
echo "cronjobs/log_active_idle.sh args : $@"

#enable_extention=$(psql --dbname=postgresql://$username:$password@$hostIP:5432/$database -c "CREATE EXTENSION IF NOT EXISTS pg_stat_activity;")
pg_stat_activity_idle=$(psql --dbname=postgresql://$username:$password@$hostIP:5432/$database -c "SELECT count(*) FROM pg_stat_activity WHERE datname = '${database}' and state = 'idle';" | sed '3q;d'  | awk '{ gsub(/ /,""); print }')

pg_stat_activity_active=$(psql --dbname=postgresql://$username:$password@$hostIP:5432/$database -c "SELECT count(*) FROM pg_stat_activity WHERE datname = '${database}' and state = 'active';" | sed '3q;d'  | awk '{ gsub(/ /,""); print }')

timeStamp=`date +%s`

echo "timeStamp,$timeStamp,idle,$pg_stat_activity_idle,active,$pg_stat_activity_active" 
echo "timeStamp,$timeStamp,idle,$pg_stat_activity_idle,active,$pg_stat_activity_active" >> $active_idle_conn
