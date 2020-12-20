#
# Cookbook:: stl-zabbix-balancer
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
yum_package 'zabbix-agent.x86_64' do
 action :install
end

yum_package 'zabbix-sender.x86_64' do
 action :install
end

# Entrega do script para balancer o proxy do client
cookbook_file '/etc/zabbix/zabbix_agentd.d/.get-update-zbx-client.sh' do
  source 'get-update-zbx-client.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  sensitive true
  notifies :run, 'execute[daemon-get-proxy-zabbix]', :immediately
end

execute "daemon-get-proxy-zabbix" do
 user "root"
 command "/etc/zabbix/zabbix_agentd.d/.get-update-zbx-client.sh"
 action :run
end
