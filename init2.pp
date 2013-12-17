#VARIABLES
$user = "ec2-user"

# GLOBAL PATH SETTING
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

include oracle_instant_client
include rvm
include install_things_with_rvm
include openresty
