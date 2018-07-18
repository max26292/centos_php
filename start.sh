#!/bin/sh
__run_supervisor() {
echo "Running all server services"
#
}
# __run_sql(){

# }
# _run_httpd(){

# }
# # Call all functions
sh -x ./config_mysql.sh & ./run-httpd.sh

__run_supervisor


