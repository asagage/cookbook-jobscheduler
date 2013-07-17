#
# Cookbook Name:: jobscheduler
# Recipe:: database_mysql
#

mysql = node['mysql']
jobs = node['jobscheduler']

include_recipe "mysql::server"
include_recipe "database::mysql"

mysql_connexion = {
  :host => 'localhost',
  :username => 'root',
  :password => mysql['server_root_password']
}

# Create a user for JobScheduler.
mysql_database_user jobs['user'] do
  connection mysql_connexion
  password jobs['database_password']
  action :create
end

# Create the JobScheduler database & grant all privileges on database
mysql_database jobs['user'] do
  connection mysql_connexion
  action :create
end

mysql_database_user jobs['user'] do
  connection mysql_connexion
  password jobs['database_password']
  database_name jobs['user']
  host 'localhost'
  privileges [:select, :update, :insert, :delete, :create, :drop, :index, :alter]
  action :grant
end
