#!/bin/bash

test_directory=$1
analysisReport=${test_directory}/analysisReport.txt

echo "post_analysis agrs $@"

#### get the average active and idle connections (pg_stat_activity) during the workload
echo "stopping the cronjobs for active/idle connections ..."
echo "stopping the cronjobs for active/idle connections ..." >> $analysisReport
vm_user=$(pwd | awk '{split($0,array,"/")} END{print array[3]}') 
#echo "crontab -u ${vm_user} -r"
#crontab -u ${vm_user} -r

echo "getting the average active and idle connections (pg_stat_activity) during the workload" 
echo "getting the average active and idle connections (pg_stat_activity) during the workload" >> $analysisReport
echo "bash cronjobs/average_active_idle.sh ${test_directory}"
bash cronjobs/average_active_idle.sh ${test_directory}
####
