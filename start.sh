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
sh -x /usr/local/bin/config_mysql.sh & /usr/local/bin/run-httpd.sh

__run_supervisor


