#
# Cookbook:: stl-app-galera
# Recipe:: galera-monit
#
# Copyright:: 2019, The Authors, All Rights Reserved.

directory "/usr/local/bin/galera-cluster" do
  action :create
  recursive true
  owner "nobody"
  group "nobody"
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/galera-cluster/get-galera-status.sh' do
  source 'bin/galera-cluster/get-galera-status.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/cron.d/exec-galera-stats' do
  source 'crond/exec-galera-stats'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end


