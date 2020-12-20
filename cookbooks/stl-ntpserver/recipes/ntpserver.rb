#
# Cookbook:: stl-ntpserver
# Recipe:: stl-ntpserver
#
# Copyright:: 2018, The Authors, All Rights Reserved.
yum_package 'ntp' do
  action :install
end

cookbook_file '/etc/ntp.conf' do
 source 'ntpconfserver'
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
 action :start 
end 
