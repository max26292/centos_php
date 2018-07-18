#!/bin/sh
__run_supervisor() {
echo "Running the run_supervisor function."
supervisord -n
}
# __run_sql(){

# }
# _run_httpd(){

# }
# # Call all functions
sh -x ./config_mysql.sh & ./run-httpd.sh

__run_supervisor
exit 1

