#
# Cookbook:: stl-conf
# Recipe:: history-to-rsyslog
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/etc/bashrc' do 
 source 'bashrc'
 owner 'root'
 group 'root' 
 mode '0644'
 action :create
end

cookbook_file '/etc/rsyslog.conf' do 
 source 'rsyslog.conf'
 owner 'root'
 group 'root' 
 mode '0644'
 action :create
end

template "/etc/rsyslog.d/history-to-rsyslog.conf" do
 source 'history-to-rsyslog.erb'
 owner 'root'
 group 'root'
 mode 0644
 notifies :run, 'execute[rsyslog-restart]', :immediately
end

execute 'rsyslog-restart' do
 command "systemctl restart rsyslog"
 action :nothing 
end

systemd_unit 'rsyslog' do
 action [ :enable, :start ]
end
