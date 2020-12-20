#
# Cookbook:: bootstrap_prod
# Recipe:: zabbix
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
yum_package 'zabbix-agent.x86_64' do
 action :install
end

yum_package 'zabbix-sender.x86_64' do
 action :install
end

template '/etc/zabbix/zabbix_agentd.conf' do
 source 'zabbix_agentd.conf.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

systemd_unit 'zabbix-agent.service' do
 action [ :enable, :start ]
end
