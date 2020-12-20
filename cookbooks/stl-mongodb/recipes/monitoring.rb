#
# Cookbook:: stl-mongodb
# Recipe:: monitoring
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory "/usr/local/bin/monit-mongo" do
 owner "root"
 group "root"
 mode 0755
 action :create
 recursive true
end

cookbook_file '/etc/cron.d/monit-mongo' do
 source 'etc/cron.d/monit-mongo'
 owner 'root'
 group 'root'
 mode 0644
 action :create_if_missing
end

template '/usr/local/bin/monit-mongo/mongo_monitoring.sh' do
 source 'mongo_monitoring.erb'
 owner 'root'
 group 'root'
 mode '0755'
end

