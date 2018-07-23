 #!/bin/bash
__run_supervisor() {
echo "###########  Running all server services  ##################"
#
# supervisor -n
}
echo "call script"
# # Call all functions
bash -x /usr/local/bin/run-mysql.sh & /usr/local/bin/run-httpd.sh
# bash -x  /usr/local/bin/config_mysql.sh
__run_supervisor
# 

