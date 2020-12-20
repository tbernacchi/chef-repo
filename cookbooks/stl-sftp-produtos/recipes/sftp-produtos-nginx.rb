#
# Cookbook:: stl-sftp-produtos
# Recipe:: stl-sftp-produtos-nginx.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end


service 'nginx' do
  action [ :enable, :start ]
end

service 'rsyslog' do
  action [ :enable, :start ]
end

# Cria o diretorio
directory "/var/www/html" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# Cria o diretorio do cache
directory "/var/cache/nginx/web_cache" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode 0644
    action :create
end

cookbook_file "/var/www/html/index.html" do
  source "ws/index.html"
  mode "0644"
end

cookbook_file "/var/www/html/probe.html" do
  source "ws/probe.html"
  mode "0644"
end

cookbook_file "/etc/nginx/conf.d/default.conf" do
  source "conf.d/default.conf"
  mode "0644"
  notifies :reload, "service[nginx]"
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  notifies :reload, "service[nginx]"
end

cookbook_file "/etc/rsyslog.d/sftp-ws-rsyslog.conf" do
  source "rsyslog/sftp-ws-rsyslog.conf"
  mode "0644"
  notifies :reload, "service[rsyslog]"
end

# Cria o diretorio e na sequencia entrega o arquivo
directory "/usr/local/bin/rotinas-sftp" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

cookbook_file "/usr/local/bin/rotinas-sftp/exec_rsync_gluster_2_local.sh" do
  source "bin/exec_rsync_gluster_2_local.sh"
  mode "0755"
end

## 
cookbook_file '/etc/cron.d/rotinas-sftp' do
  source 'crond/rotinas-sftp'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

