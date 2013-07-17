name             'jobscheduler'
maintainer       'ogom'
maintainer_email 'ogom@outlook.com'
license          'MIT'
description      'Installs/Configures jobscheduler'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "jobscheduler::initial", "Setting the initial"
recipe "jobscheduler::install", "Installation"

%w{java database apt yum}.each do |dep|
  depends dep
end

%w{debian ubuntu}.each do |os|
  supports os
end
