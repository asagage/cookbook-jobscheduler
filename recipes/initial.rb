#
# Cookbook Name:: jobscheduler
# Recipe:: initial
#

jobs = node['jobscheduler']

# Initial Change
directory "/tmp" do
  mode 0777
end


# Packages / Dependencies
include_recipe "apt" if platform?("ubuntu", "debian")
include_recipe "yum::epel" if platform?("centos")


# Java
include_recipe "java"


# System Users
## Create user for JobScheduler.
user jobs['user'] do
  comment "JobScheduler"
  home jobs['home']
  shell "/bin/bash"
  supports :manage_home => true
end

user jobs['user'] do
  action :lock
end

## SUDO
group "sudo" do
  members jobs['user']
  append true
  action :modify
end
