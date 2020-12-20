#
# Cookbook:: stl-chef-client 
# Recipe:: chef-client-service
#
# Copyright:: 2019, The Authors, All Rights Reserved.
%w{oracle centos redhat}.each do |dist|
if node['platform'] == dist 
 if node["platform_version"].start_with?('7')
  directory '/var/log/chef' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  end

  cookbook_file '/etc/sysconfig/chef-client' do
  source 'chef-client'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  end

  cookbook_file '/usr/lib/systemd/system/chef-client.service' do
  source 'chef-client.service'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
  end

  cookbook_file '/etc/logrotate.d/rotate-chef-client' do
  source 'rotate-chef-client'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  end

  execute "daemon-reload" do
  user "root"
  command "systemctl daemon-reload"
  action :nothing
  end

  systemd_unit 'chef-client.service' do
  action [ :enable, :start ] 
  end 
 end
end

if node['platform_version'].to_i == 6 

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
  mode '0744'
  action :create_if_missing
  end

  execute "chkconfig " do
  command '/sbin/chkconfig chef-client on'
  not_if "/sbin/chkconfig --list | egrep '3:|4:|5:' | grep chef-client" 
  end

  service "chef-client" do
  action :start 
  end 

  cookbook_file '/etc/logrotate.d/rotate-chef-client' do
  source 'rotate-chef-client'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  end
 end
end
