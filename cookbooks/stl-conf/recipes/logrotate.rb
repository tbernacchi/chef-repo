#
# Cookbook:: stl-conf
# Recipe:: logrotate
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/etc/logrotate.d/syslog' do
 source 'syslog'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/usr/local/bin/run-logrotate-tabajara' do
 source 'run-logrotate-tabajara'
 owner 'root'
 group 'root'
 mode '0755'
 action :create
end

cookbook_file '/etc/cron.d/cron-logrotate-tabajara' do
 source 'cron-logrotate-tabajara'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end
