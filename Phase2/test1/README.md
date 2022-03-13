Information about testing:
Testing done using bash scripts which invoke the dbmail executables. Data generation using a bash script to automatically add the input data to the test directory. The dbmail utilities used are dbmail-users, dbmail-deliver and dbmail-export. The workload being run is: users are added and deleted, emails are sent and emails are exported (with and without search). 

Instructions on how to run test:
1. Start a GCP VM and install DBMail. Upload script files and navigate to script directory.
2. Run 'sudo apt install screen' (screen allows the test to run even if ssh connection is lost to the VM)
3. Run 'sudo apt install dos2unix' (if running the read pool workload)
4. Run 'screen'
5. Pick a testing plan from between: 1. regular testing, 2. infinite loop testing, 3. read pool testing
6. (1) If regular testing has been selected run 'sudo bash testing.sh <testplan> <test_dir_location> <test_no> <users_added> <users_deleted> <emails_sent_per_user> <addition_string> <search_string> <database_internal_ip_address> <database_username> <database_password> <database_name> <randomness>'
NOTE: a. number of deleted users should be 1/5th of number of added users b. addition string is the string added a portion of which is later searched for using the search string c. test directory location should preferably be an external disk since exporting emails will generate a lot of large output files
NOTE: Example of testrun: sudo bash testing.sh 1 /mnt/disks/disk2/testing/test50 50 100 20 100 ozymandias ozyman 10.11.0.5 dbmail dbmail123 dbmdatabase
NOTE: 'Randomness' decides how many emails are checked for text correctness (if randomness is x then around 1 in every x emails is checked)
(2) If infinte loop testing has been selected run 'sudo bash testing.sh <testplan>'
NOTE: Example of testrun: sudo bash testing.sh 2
(3) If read pool testing has been selected run `sudo bash workload.sh </path/to/external_disk_directory> <test number> </path/to/bin/jmeter> <database ip address> <database user> <database password> <name of database> <number of jmeter threads exporting emails> <number of jmeter threads listing emails>`
7. If the connection to the VM is lost run 'screen -r' to reattach the screen
8. Once the test is finished running navigate to test_directory. Results of correctness scripts are available on standard output. Further correctness check results are present in file 'correctnessreport'
9. Check metrics of the test using Metrics Explorer, Log Explorer and Query Insights.
10. If the read pool workload was selected then run 'sudo bash read_pool_testing/cleanup.sh <workload_directory> <export_directory>