#!/bin/bash

test_directory=$1
active_idle_conn_csv=${test_directory}/active_idle_conn.csv
analysis_log=${test_directory}/analysis.log
echo "cronjobs/average_active_idle.sh args : $@"

total_active=0
total_idle=0
max_active=0
min_active=99999999999
max_idle=0
min_idle=999999999999
N=0


while IFS= read -r line; do
    if [ ! -z "$line" ];
    then
        N=$((N+1))    
        active=$(echo $line | awk '{split($0,a,","); print a[6]}')
        idle=$(echo $line | awk '{split($0,a,","); print a[4]}')

        [ -z "$active" ] &&  active=0
        [ -z "$idle" ] &&  idle=0

        [ $active -gt $max_active ] && max_active=$active

        [ $active -lt $min_active ] && min_active=$active

        [ $idle -gt $max_idle ] && max_idle=$idle

        [ $idle -lt $min_idle ] && min_idle=$idle

        total_active=$(($total_active+$active))
        total_idle=$(($total_idle+$idle))
    fi       
    average_active=$(($total_active/$N))    
    average_idle=$(($total_idle/$N))    
done < $active_idle_conn_csv
echo "average_active_conn=$average_active" >> $analysis_log
echo "average_idle_conn=$average_idle" >> $analysis_log
echo "min_idle_conn=$min_idle" >> $analysis_log
echo "min_active_conn=$min_active" >> $analysis_log
echo "max_idle_conn=$max_idle" >> $analysis_log
echo "max_active_conn=$max_active" >> $analysis_log
