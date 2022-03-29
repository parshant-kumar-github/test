test_directory=$1
db_ip=$2
db_name=$3
db_user=$4
db_password=$5
cronjob_log_active_idle_every_X_min=$6
default_db_user=$7
default_db_password=$8
primary_db_ip=$9

echo "pre_analysis args : $@"

username=$db_user
password=$db_password
hostIP=$db_ip
database=$db_name
create_extention_pg_stat_activity=$(psql --dbname=postgresql://$default_db_user:$default_db_password@$primary_db_ip:5432/$database -c "CREATE EXTENSION IF NOT EXISTS pg_stat_activity;")
echo "$create_extention_pg_stat_activity"

sudo bash cronjobs/cronjob_active_idle.sh ${username} ${password} ${hostIP} ${database} ${test_directory} ${cronjob_log_active_idle_every_X_min}
