#!/bin/bash

test_directory=$1
db_ip=$2
db_name=$3
db_user=$4
db_password=$5
cronjob_log_active_idle_every_X_min=$6
default_db_user=$7
default_db_password=$8
primary_db_ip=$9

echo "workload.sh args : $@"

bash pre_analysis.sh $test_directory $db_ip $db_name $db_user $db_password $cronjob_log_active_idle_every_X_min $default_db_user $default_db_password $primary_db_ip

#echo "sleep 3m"
#sleep 3m
bash post_analysis.sh $test_directory 
