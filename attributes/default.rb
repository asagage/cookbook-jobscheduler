# JobScheduler
## User
default['jobscheduler']['user'] = "scheduler"
default['jobscheduler']['group'] = "scheduler"
default['jobscheduler']['home'] = "/home/scheduler"

#http://download.sos-berlin.com/JobScheduler.1.7/jobscheduler_linux-x64.1.7.4321.tar.gz
## Source
default['jobscheduler']['platform'] = "linux-x64"
#default['jobscheduler']['version'] = "1.5.3192"
default['jobscheduler']['version'] = "1.7.4321"
default['jobscheduler']['path'] = "/opt/sos-berlin.com/jobscheduler"
default['jobscheduler']['user_path'] = "/home/scheduler/sos-berlin.com/jobscheduler"

## Database
default['jobscheduler']['database_adapter'] = "mysql"
default['jobscheduler']['database_port'] = "3306"
default['jobscheduler']['database_schema'] = "scheduler"
default['jobscheduler']['database_user'] = "scheduler"

## Server
default['jobscheduler']['host'] = "localhost"
default['jobscheduler']['port'] = "80"

#
default['authorization']['sudo']['users'] = ["scheduler","vagrant"]
default['authorization']['sudo']['passwordless'] = "true"
