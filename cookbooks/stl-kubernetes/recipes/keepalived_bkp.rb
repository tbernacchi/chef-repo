#
# Cookbook:: stl-kubernetes
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-keepalived'

service "keepalived" do
 supports :start => true, :stop => true, :restart => true, :status => true
 action [:enable, :start]
end

template "/etc/keepalived/check_apiserver.sh" do
  owner "root"
  group "root"
  mode 0644
  source "etc/keepalived/check_apiserver.sh.erb"
  notifies :restart, "service[keepalived]", :delayed
end

template "/etc/keepalived/keepalived.conf" do
  owner "root"
  group "root"
  mode 0644
  source "etc/keepalived/keepalived.conf-nodes.erb"
  notifies :restart, "service[keepalived]", :delayed
end
