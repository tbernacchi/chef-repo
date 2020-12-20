#
# Cookbook:: stl-bacula
# Recipe:: bacula
#
# Copyright:: 2018, The Authors, All Rights Reserved.
yum_package 'bacula-client' do
 action :install
 #not_if { File.exist? ('') } 
end

cookbook_file '/etc/bacula/bacula-fd.conf' do
 source 'bacula-fd.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

systemd_unit 'bacula-fd' do
 action [ :enable, :start ]
end

