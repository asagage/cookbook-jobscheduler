#
# Cookbook Name:: jobscheduler
# Recipe:: update
#

jobs = node['jobscheduler']

# Packages
if platform?("ubuntu", "debian")
  package "ubuntu-desktop" do
    action :install
  end
end
