cookbook_file '/etc/rsyslog.conf' do 
 source 'rsyslog-server.conf'
 owner 'root'
 group 'root' 
 mode '0644'
 action :create
 notifies :run, 'execute[rsyslog-restart]', :immediately
end

execute 'rsyslog-restart' do
 command "systemctl restart rsyslog"
 action :nothing 
end

systemd_unit 'rsyslog' do
 action [ :enable, :start ]
end

