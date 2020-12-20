#
# Cookbook:: stl-proxy-smtp
# Recipe:: proxy-smtp
#
# Copyright:: 2019, The Authors, All Rights Reserved.

yum_package 'cyrus-sasl-plain' do
  allow_downgrade true
  package_name 'cyrus-sasl-plain'
end


execute 'daemon-reload' do
  command 'postmap /etc/postfix/sasl_passwd && postmap /etc/postfix/main.cf && postmap /etc/postfix/header_checks && postmap /etc/postfix/sender_canonical_maps && systemctl restart postfix'
  action :nothing
end

cookbook_file '/etc/postfix/sasl_passwd' do
  source 'etc/postfix/sasl_passwd'
  owner 'root'
  group 'postfix'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

cookbook_file '/etc/postfix/header_checks' do
  source 'etc/postfix/header_checks'
  owner 'root'
  group 'postfix'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

cookbook_file '/etc/postfix/main.cf' do
  source 'etc/postfix/main.cf'
  owner 'root'
  group 'postfix'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

cookbook_file '/etc/postfix/sender_canonical_maps' do
  source 'etc/postfix/sender_canonical_maps'
  owner 'root'
  group 'postfix'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end
