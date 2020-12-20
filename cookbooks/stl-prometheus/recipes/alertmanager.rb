#
# Cookbook:: stl-prometheus
# Recipe:: alertmanager
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory "/opt/monitoring/alertmanager" do
 recursive true 
 owner 'root'
 group 'root'
 mode '0755'
 not_if "{ ::Dir.exist? ( '/opt/monitoring/alertmanager') }"
end

remote_file '/opt/monitoring/alertmanager.tar.gz' do
 source 'http://repo.qa.tabajara.intranet/pacotes/prometheus-tabajara/alertmanager.tar.gz'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/opt/monitoring/alertmanager/alertmanager.tar.gz") }  
end

user 'prometheus' do
 comment 'prometheus user'
 shell '/bin/false'
 manage_home false
 comment 'prometheus user'
 action :create
 not_if "grep -q prometheus /etc/passwd"
end

bash 'Installing alertmanager' do
 cwd '/opt/monitoring/'
 user 'root'
 code <<-EOF
 tar zxvf alertmanager.tar.gz
 chown -R prometheus:prometheus alertmanager/
 EOF
 not_if { File.exist? ("/usr/bin/alertmanager") }  
end

systemd_unit 'alertmanager.service' do
  content({Unit: {
            Description: 'The alertmanager system',
            Wants: 'network-online.target',
            After: 'network-online.target',
            },
            Service: {
              Type:'simple',
              WorkingDirectory:'/opt/monitoring/alertmanager',
	      ExecStart:'/opt/monitoring/alertmanager/alertmanager --config.file=alertmanager.yml --storage.path=/var/lib/alertmanager/data',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
  action [ :create ]
  not_if '{ File.exist? ("/etc/systemd/system/alertmanager.service") }'
  notifies :run, 'execute[daemon-reload]', :immediately
end

cookbook_file '/opt/monitoring/alertmanager/alertmanager.yml' do 
 source 'alertmanager/alertmanager.yml'
 owner 'prometheus'
 group 'prometheus'
 mode '0644'
 action :create
 notifies :run, 'execute[alertmanager-restart]', :immediately
end

systemd_unit 'alertmanager' do 
 action [ :enable, :start ] 
end 

execute 'daemon-reload' do
 command 'systemctl daemon-reload'
 action :nothing
end

execute 'alertmanager-restart' do 
 command 'systemctl restart alertmanager'
end 
