#
# Cookbook:: stl-conf
# Recipe:: conf-old
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
# Cookbook:: stl-base-centos
# Recipe:: confs
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/etc/sysctl.d/100-disable-ipv6.conf' do
  source '100-disable-ipv6.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/sysconfig/selinux' do
 source 'selinux'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/etc/crontab' do
 source 'crontab'
 owner 'root'
 group 'root'
 mode '0700'
 action :create
end

cookbook_file '/etc/motd' do
 source 'motd_tabajara'
 owner 'root'
 group 'root'
 mode '0700'
 action :create
end
