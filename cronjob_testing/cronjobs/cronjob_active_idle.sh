#!/bin/bash

username=$1
password=$2
hostIP=$3
database=$4
test_directory=$5
forEveryXMin=$6
vm_user=$(pwd | awk '{split($0,array,"/")} END{print array[3]}') 
analysisReport=${test_directory}/analysisReport.txt

iterate_log_file=$(pwd)/cronjobs/log_active_idle.sh

echo "cronjobs/cronjob_active_idle.sh args : $@"


echo "chmod +x ${iterate_log_file}"
chmod +x ${iterate_log_file}

echo "removing the already existing crontab..."
echo "removing the already existing crontab..." >> $analysisReport
echo "crontab -u ${vm_user} -r"
crontab -u ${vm_user} -r

echo "saving new cronjob into mycron file..."
echo "saving new cronjob into mycron file..." >> $analysisReport
echo "SHELL=/bin/bash" >> mycron
echo "PATH=/bin:/sbin:/usr/bin:/usr/sbin...." >> mycron 
echo "*/${forEveryXMin} * * * * /bin/bash ${iterate_log_file} ${username} ${password} ${hostIP} ${database} ${test_directory} 2>&1" >> mycron

echo "installing new cron file...."
echo "installing new cron file...." >> $analysisReport
echo "cat mycron"
echo "crontab -u ${vm_user} mycron"
cat mycron
crontab -u ${vm_user} mycron

echo "removing temperary file mycron....."
echo "removing temperary file mycron....." >> $analysisReport
echo "rm mycron"
rm mycron

echo "crontab -l -u ${vm_user}"
crontab -l -u ${vm_user}
