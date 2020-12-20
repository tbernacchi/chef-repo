#
# Cookbook:: stl-prometheus
# Recipe:: alertmanager-zabbix-webhook
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory "/opt/monitoring/" do
 owner 'root'
 group 'root'
 mode '0755'
 not_if "{ ::Dir.exist? ( '/opt/monitoring/') }"
end

remote_file '/opt/monitoring/alertmanager-zabbix-webhook.tar.gz' do 
 source 'http://repo.qa.tabajara.intranet/pacotes/prometheus/alertmanager-zabbix-webhook.tar.gz'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/opt/monitoring/alertmanager-zabbix-webhook/alertmanager-zabbix-webhook.tar.gz") }  
end

bash 'Installing alertmanager-zabbix-webhook' do
 cwd '/opt/monitoring/'
 user 'root'
 code <<-EOF
 tar zxvf alertmanager-zabbix-webhook.tar.gz
 chown -R prometheus:prometheus alertmanager-zabbix-webhook/
 EOF
 not_if { File.exist? ("/opt/monitoring/alertmanager-zabbix-webhook/alertmanager-zabbix-webhook") }  
end

systemd_unit 'alertmanager-zabbix-webhook.service' do
  content({Unit: {
            Description: 'The alertmanager system',
            Wants: 'network-online.target',
            After: 'network-online.target',
            },
            Service: {
              Type:'simple',
              WorkingDirectory:'/opt/monitoring/alertmanager-zabbix-webhook',
              ExecStart:'/opt/monitoring/alertmanager-zabbix-webhook/alertmanager-zabbix-webhook --config=config.yaml',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
  action [ :create ]
  not_if '{ File.exist? ("/etc/systemd/system/alertmanager-zabbix-webhook.service") }'
  notifies :run, 'execute[daemon-reload]', :immediately
end

execute 'daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

systemd_unit 'alertmanager-zabbix-webhook' do 
  action [ :enable, :start ] 
end 
