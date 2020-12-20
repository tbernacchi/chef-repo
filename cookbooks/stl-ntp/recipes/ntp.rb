if node['platform'] == 'oracle'
  if node['platform_version'].to_i == 6

   cookbook_file '/etc/ntp.conf' do
    source 'ntp.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    notifies :run, 'execute[ntpd-restart]', :immediately
   end

   execute 'chkconfig' do
    command '/sbin/chkconfig ntpd on'
    not_if '/sbin/chkconfig --list ntpd'
   end

   execute 'ntpd-restart' do
    command 'service ntpd restart'
    action :nothing
   end

   service 'ntpd' do
    action :start
   end
  end
end

if node['platform_version'].to_i == 7

  yum_package 'ntp' do
    action :install
    not_if  "test -f /usr/sbin/ntpd"
  end

  cookbook_file '/etc/ntp.conf' do
   source 'ntp.conf'
   owner 'root'
   group 'root'
   mode '0644'
   action :create
   notifies :run, 'execute[ntpd-restart]', :immediately
  end

  execute 'ntpd-restart' do
   command 'systemctl restart ntpd'
   action :nothing
  end

  systemd_unit 'ntpd' do 
   action [ :enable, :start ]   
  end
end
