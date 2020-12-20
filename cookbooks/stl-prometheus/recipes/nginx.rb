#
# Cookbook:: stl-prometheus
# Recipe:: nginx
#
# Copyright:: 2019, The Authors, All Rights Reserved.
user 'nginx' do
  comment 'nginx user'
  shell '/sbin/nologin'
  manage_home false
  action :create
  not_if "grep -q nginx /etc/passwd"
end

%w[ /opt/nginx /etc/nginx/conf.d /usr/local/nginx/ /var/log/nginx].each do |path|
  directory "#{path}" do
  owner 'nginx'
  group 'root'
  mode '0640'
  recursive true 
  not_if "{ ::Dir.exist? ( '#{path}') }"
 end
end

remote_file '/opt/nginx/nginx-ldap-1.13.10.tar.gz' do 
 source 'http://repo.qa.tabajara.intranet/pacotes/nginx-ldap/nginx-1.13.10.tar.gz'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/opt/nginx/nginx-ldap-1.13.10.tar.gz") }  
end

cookbook_file "/opt/nginx/extract.sh" do
 source "scripts/extract.sh"
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/opt/nginx/extract.sh") }  
end

bash "Extracting nginx-ldap-1.13.10.tar.gz" do
 user 'root'
 cwd '/opt/nginx'
 code <<-EOF
 sh -x extract.sh
 EOF
 not_if { File.exist? ("/usr/local/nginx/sbin/nginx") }
end

cookbook_file "/usr/local/nginx/conf/nginx.conf" do
 source "nginx/nginx.conf"
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file "/usr/lib/systemd/system/nginx.service" do
 source "nginx/nginx.service"
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[daemon-reload]', :immediately
end

execute 'daemon-reload' do
 command 'systemctl daemon-reload'
 action :nothing 
end

systemd_unit "nginx" do
 action [:enable, :start]
end
  
template "/etc/nginx/conf.d/prometheus.conf" do
 source "etc/nginx/conf.d/prometheus-conf.erb"
 notifies :restart, "systemd_unit[nginx]", :delayed  
end
