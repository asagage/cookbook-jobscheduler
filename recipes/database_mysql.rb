#
# Cookbook Name:: jobscheduler
# Recipe:: database_mysql
#

mysql = node['mysql']
mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password mysql['server_root_password']
  action [:create, :start]
end

jobs = node['jobscheduler']

#include_recipe "mysql::server"
#include_recipe "database::mysql"
include_recipe "database"

mysql_chef_gem 'default' do
  action :install
end

#define our mysql connection
mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

# Create a user for JobScheduler.
mysql_database_user jobs['user'] do
  connection mysql_connection_info
  password jobs['database_password']
  action :create
end

# Create the JobScheduler database & grant all privileges on database
mysql_database jobs['user'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user jobs['user'] do
  connection mysql_connection_info
  password jobs['database_password']
  database_name jobs['user']
  host 'localhost'
  privileges [:select, :update, :insert, :delete, :create, :drop, :index, :alter]
  action :grant
end
