yum_package 'nginx' do
 action :install
 not_if { File.exist? ('/etc/nginx/nginx.conf') }
end

template '/etc/nginx/nginx.conf' do
 source 'nginx.conf.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 #not_if { File.exist? ('/etc/nginx/nginx.conf') }
end

systemd_unit 'nginx.service' do
 supports :status => true, :restart => true, :start => true
 action [ :enable, :start ]
end

