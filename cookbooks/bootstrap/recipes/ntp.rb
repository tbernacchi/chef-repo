#
# Cookbook:: bootstrap
# Recipe:: ntp/timezone
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package 'ntp' do
  action :install
  not_if { File.exist?("/etc/ntp.conf") }
end

cookbook_file '/etc/ntp.conf' do
 source 'ntp.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

systemd_unit 'ntpd' do
 action [ :enable, :start ]
end

execute 'Setting automatic clock syncronization' do 
 command 'timedatectl set-ntp on'
end

systemd_unit 'ntpd' do
 action [ :start ]
end
