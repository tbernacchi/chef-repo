#
# Cookbook:: stl-rundeck
# Recipe:: rundeck-core
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
# yum clean all
execute "yum-clean-all" do
       command "yum clean all"
       action :run
end

# java install
include_recipe 'stl-java'

# install nginx
include_recipe 'stl-nginx::nginx'

cookbook_file '/etc/yum.repos.d/rundeck-tabajara.repo' do
  source 'yum/rundeck-tabajara.repo'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# pkgs
# install rundeck core package e a dep config
yum_package 'rundeck' do
  allow_downgrade true
  package_name    'rundeck'
  version         '3.0.21.20190424-1.201904242240'
  action          [ :install]
  not_if          'test -f /var/lib/rundeck/bootstrap/rundeck-3.0.21-20190424.war'
end

yum_package 'rundeck-cli' do
  allow_downgrade true
  package_name 'rundeck-cli'
  version         '1.1.2-1'
  action          [ :install]
  not_if          'test -f /usr/bin/rd'
end

# forcando a resolucao interna
hostsfile_entry '0.0.0.0' do
  hostname  'rundeck.tabajara.intranet'
    action  :create_if_missing
end

# make dirs
%w{ /rundeck-logs-json }.each do |dirs|
    directory "#{dirs}" do
    owner 'rundeck'
    group 'rundeck'
    mode 0775
    recursive true
    action :create
  end
end

# mount point
mount '/rundeck-logs-json' do
  device '/dev/mapper/vg--rundeck-lv--rundeck'
  fstype 'xfs'
  options 'rw'
  action [:mount, :enable]
end

# Restart
execute 'daemon-reload' do
  command 'systemctl restart rundeckd'
  action :nothing
end

## Template
# template
template '/etc/rundeck/rundeck-config.properties' do
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  source 'etc/rundeck/rundeck-config.properties.erb'
  notifies :run, 'execute[daemon-reload]', :immediately
end

template '/etc/rundeck/profile' do
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  source 'etc/rundeck/profile.erb'
  notifies :run, 'execute[daemon-reload]', :immediately
end

# template
template  '/etc/rundeck/jaas-activedirectory.conf' do
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  source 'etc/rundeck/jaas-activedirectory.conf.erb'
  notifies :run, 'execute[daemon-reload]', :immediately
end

# template
template '/etc/rundeck/project.properties' do
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  source 'etc/rundeck/project.properties.erb'
  notifies :run, 'execute[daemon-reload]', :immediately
end

# template
template '/etc/rundeck/framework.properties' do
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  source 'etc/rundeck/framework.properties.erb'
  notifies :run, 'execute[daemon-reload]', :immediately
end

cookbook_file '/etc/rundeck/log4j.properties' do
  source 'etc/rundeck/log4j.properties'
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

# WS Nginx
service "nginx" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

template "/etc/nginx/conf.d/rundeck-ws.conf" do
  source "etc/nginx/conf.d/rundeck-ws.conf.erb"
  notifies :restart, "service[nginx]", :delayed
end

#logrotate
cookbook_file '/etc/logrotate.d/rotate-rundeck' do
  source 'etc/logrotate.d/rotate-rundeck'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

