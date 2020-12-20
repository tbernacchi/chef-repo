#
# Cookbook:: stl-chef-client
# Recipe:: chef-client-chk
#
# Copyright:: 2018, The Authors, All Rights Reserved.
directory '/var/log/chef' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/init.d/chef-client' do
 source 'chef-client-chkconfig'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[chkconfig], service [chef-client]', :immediately
end

execute "chkconfig " do
 user "root"
 command "chkconfig add chef-client --level 345 on"
end

service 'chef-client' do
 action :start 
end

cookbook_file '/etc/logrotate.d/rotate-chef-client' do
 source 'rotate-chef-client'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end
