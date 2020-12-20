#
# Cookbook:: stl-zabbix-server
# Recipe:: zabbix-server
#
# Copyright:: 2019, The Authors, All Rights Reserved.

yum_package 'zabbix-web-mysql' do
  allow_downgrade true
  package_name    'zabbix-web-mysql'
  version         '3.4.6-1.el7.noarch'
  action          [ :install]
  not_if          "test -f /usr/sbin/zabbix_server"
end

yum_package 'zabbix-server-mysql' do
  allow_downgrade true
  package_name    'zabbix-server-mysql'
  version         '3.4.6-1.el7.noarch'
  action          [ :install]
  not_if          "test -f /usr/sbin/zabbix_server_mysql"
end


yum_package 'zabbix-java-gateway' do
  allow_downgrade true
  package_name    'zabbix-java-gateway'
  version         '3.4.6-1.el7.x86_64'
  action          [ :install]
  not_if          "test -f /usr/sbin/zabbix_java_gateway"
end

yum_package 'httpd' do
  allow_downgrade true
  package_name    'httpd'
  version         '2.4.6-67.el7.centos.6.x86_64'
  action          [ :install]
  not_if          "test -f /usr/sbin/httpd"
end

template "/etc/zabbix/zabbix_server.conf" do
  source "etc/zabbix/zabbix_server.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[daemon-zabbix-server]", :immediately
end

execute "daemon-zabbix-server" do
  user "root"
  command "systemctl restart zabbix-server"
  action :nothing
end

%w{ /usr/local/bin/zabbix-balancer /usr/local/bin/zabbix-stale /usr/local/bin/integracao-jira /usr/local/bin/zabbix-balancer }.each do |dirs|
    directory "#{dirs}" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end
end

cookbook_file '/etc/cron.d/zabbix-to-jira' do
  source 'etc/cron.d/zabbix-to-jira'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

cookbook_file '/etc/cron.d/zabbix-balancer-e-stale' do
  source 'etc/cron.d/zabbix-balancer-e-stale'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/integracao-jira/get-open-trigger-to-sd.sh' do
  source 'bin/integracao-jira/get-open-trigger-to-sd.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/integracao-jira/make-log.sh' do
  source 'bin/integracao-jira/make-log.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/zabbix-balancer/zabbix-balancer-make-list.sh' do
  source 'bin/zabbix-balancer/zabbix-balancer-make-list.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/zabbix-stale/get-stale-event.sh' do
  source 'bin/zabbix-stale/get-stale-event.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/integracao-jira/get-callcenter-to-zabbix.sh' do
  source 'bin/integracao-jira/get-callcenter-to-zabbix.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/etc/cron.d/callcenter-to-zabbix' do
  source 'etc/cron.d/callcenter-to-zabbix'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

cookbook_file '/etc/httpd/conf.d/zabbix-balancer.conf' do
  source 'etc/httpd/conf.d/zabbix-balancer.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

cookbook_file '/usr/share/zabbix/include/items.inc.php' do
  source 'usr/share/zabbix/include/items.inc.php'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end
