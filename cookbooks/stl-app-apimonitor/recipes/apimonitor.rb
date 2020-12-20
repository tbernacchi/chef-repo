#
# Cookbook:: stl-app-apimonitor
# Recipe:: apimonitor
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-java'
include_recipe 'stl-nginx::nginx'

execute "yum-clean-all" do
  command "touch /tmp/yum.lock && yum clean all"
  action :run
  not_if { File.exists? ("/tmp/yum.lock") }
end 

%w{ /app /app/standalone /app/standalone/apimonitor /app/standalone/apimonitor/conf /app/log /app/log/standalone /app/log/standalone/apimonitor }.each do |dirs|
    directory "#{dirs}" do
    owner "svc-apimonitor"
    group "nobody"
    mode 0755
    action :create
  end
end

yum_package 'apimonitor' do
  allow_downgrade true
  package_name 'apimonitor'
  if node.chef_environment == "prod"
    version node['apimonitor']['api'][node.chef_environment]['app_version']
  end
  action [ :upgrade]
end

cookbook_file '/etc/systemd/system/apimonitor.service' do
  source 'systemd/apimonitor.service'
  owner 'svc-apimonitor'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

file "/app/standalone/apimonitor/apimonitor.jar" do 
  mode '0644'
  owner 'root'
  group 'root'
end 

execute 'daemon-reload' do
  command 'systemctl daemon-reload && systemctl restart apimonitor'
  action :nothing
end

template "/app/standalone/apimonitor/conf/application.properties" do
  source "app/standalone/apimonitor/conf/application.properties.erb"
  owner "svc-apimonitor"
  group "nobody"
  mode 0644
  notifies :restart, "service[apimonitor]", :delayed
end

service "apimonitor" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

service "nginx" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

template "/etc/nginx/conf.d/apimonitor.conf" do
  source "etc/nginx/conf.d/apimonitor-conf.erb"
  notifies :restart, "service[nginx]", :delayed
end

execute "rm /tmp/yum.lock" do
  command "rm -f /tmp/yum.lock"
  action :run
  only_if { File.exists? ("/tmp/yum.lock") }
end 

