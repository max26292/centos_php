__run_supervisor() {
echo "Running the run_supervisor function."
supervisord -n
}

# Call all functions
exec bash -c "./config_mysql.sh"
exec bash =c "./docker-entrypoint.sh"
__run_supervisor
