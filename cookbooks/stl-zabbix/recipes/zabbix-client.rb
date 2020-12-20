#
# Cookbook:: stl-zabbix
# Recipe:: zabbix-client
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
yum_package 'zabbix-agent.x86_64' do
 action :install
 not_if "rpm -q zabbix-agent-3.4.5-1.el7.x86_64" 
end

yum_package 'zabbix-sender.x86_64' do
 not_if "rpm -q zabbix-sender-3.4.5-1.el7.x86_64" 
 action :install
end

template '/etc/zabbix/zabbix_agentd.conf' do
 source 'zabbix_agentd.conf.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[zabbix-agent-restart]', :immediately
end

execute 'zabbix-agent-restart' do
 command 'systemctl restart zabbix-agentd'
 action :nothing
end

systemd_unit 'zabbix-agent.service' do
 action [ :enable, :start ]
end
