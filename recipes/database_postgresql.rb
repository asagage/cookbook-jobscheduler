#
# Cookbook Name:: jobscheduler
# Recipe:: database_postgresql
#

postgresql = node['postgresql']
jobs = node['jobscheduler']

include_recipe "postgresql::server"
include_recipe "database::postgresql"

postgresql_connexion = {
  :host => 'localhost',
  :username => 'postgres',
  :password => postgresql['password']['postgres']
}

# Create a user for JobScheduler.
postgresql_database_user jobs['user'] do
  connection postgresql_connexion
  password jobs['database_password']
  action :create
end

# Create the JobScheduler database & grant all privileges on database
postgresql_database jobs['user'] do
  connection postgresql_connexion
  action :create
end

postgresql_database_user jobs['user'] do
  connection postgresql_connexion
  database_name jobs['user']
  password jobs['database_password']
  action :grant
end
