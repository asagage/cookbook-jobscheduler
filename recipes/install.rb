#
# Cookbook Name:: jobscheduler
# Recipe:: install
#

jobs = node['jobscheduler']

# Database
include_recipe "jobscheduler::database_#{jobs['database_adapter']}"


# JobScheduler
directory jobs['path'] do
  recursive true
end

remote_file File.join(jobs['path'], "jobscheduler_#{jobs['platform']}.#{jobs['version']}.tar.gz") do
  source "http://sourceforge.net/projects/jobscheduler/files/jobscheduler_#{jobs['platform']}.#{jobs['version']}.tar.gz"
  mode 0644
  not_if "test -f #{File.join(jobs['path'], "jobscheduler_#{jobs['platform']}.#{jobs['version']}.tar.gz")}"
end

## Install
template File.join(jobs['path'], 'jobscheduler_install.xml') do
  source "jobscheduler_install.xml.erb"
  mode 0644
  notifies :run, "execute[jobscheduler install]", :immediately
  variables({
    :install_path => jobs['path'],
    :user_path => jobs['user_path'],
    :database_dbms => jobs['database_adapter'],
    :database_port => jobs['database_port'],
    :database_schema => jobs['database_schema'],
    :database_user => jobs['database_user'],
    :database_password => jobs['database_password']
  })
end

#sudo -u #{jobs['user']} ./jobscheduler.#{jobs['version']}/setup.sh ./jobscheduler_install.xml
execute "jobscheduler install" do
  command <<-EOS
    tar xzf jobscheduler_#{jobs['platform']}.#{jobs['version']}.tar.gz
    sudo -u #{jobs['user']} ./jobscheduler.#{jobs['version']}/setup.sh ./jobscheduler_install.xml
  EOS
  cwd jobs['path']
  action :nothing
end

## Reload
template File.join(jobs['user_path'], 'scheduler', 'config', 'jetty.xml') do
  source "jobscheduler_jetty.xml.erb"
  user jobs['user']
  group jobs['group']
  notifies :run, "execute[jobscheduler start]", :immediately
end

execute "jobscheduler start" do
  command <<-EOS
    #{File.join(jobs['path'], 'scheduler', 'bin', 'jobscheduler.sh')} kill
    #{File.join(jobs['path'], 'scheduler', 'bin', 'jobscheduler.sh')} start
  EOS
  action :nothing
end


# Proxy
include_recipe "jobscheduler::nginx"
