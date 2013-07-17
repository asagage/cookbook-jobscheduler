#
# Cookbook Name:: jobscheduler
# Recipe:: nginx
#

jobs = node['jobscheduler']

# Installation
package "nginx" do 
  action :install
end

# Site Configuration
path = platform_family?("rhel") ? "/etc/nginx/conf.d/jobscheduler.conf" : "/etc/nginx/sites-available/jobscheduler"
template path do
  source "nginx.erb"
  mode 0644
  variables({
    :host => jobs['host'],
    :port => jobs['port']
  })
end

if platform_family?("rhel")
  directory jobs['home'] do
    mode 0755
  end
else
  link "/etc/nginx/sites-enabled/jobscheduler" do
    to "/etc/nginx/sites-available/jobscheduler"
  end

  file "/etc/nginx/sites-enabled/default" do
    action :delete
  end
end

# Restart
service "nginx" do
  action :restart
end
