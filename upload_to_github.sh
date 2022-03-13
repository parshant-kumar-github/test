#!/bin/bash

test_directory=$1
git_results_diretory=$2
test_no=$3
application_name=$4
workload_configuration=$5
workload_type=$6
git_branch=$7


cp -r ${test_directory}/results $git_results_diretory/test${test_no}

git add .
git commit -m "test-${test_no}-${application_name}-${workload_configuration}-${workload_type}"
git pull
git push origin ${git_branch}

# bash upload_to_github.sh /Users/prashantkumar/Desktop/code/DB_performance/test_directory /Users/prashantkumar/Desktop/code/DB_performance/git_testing/test/Phase2 1 dbmail small read-pool main