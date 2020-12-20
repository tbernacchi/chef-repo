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

cookbook_file '/etc/security/access.conf' do
 source 'access.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/etc/krb5.conf' do
 source 'krb5.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/etc/resolv.conf' do
 source 'resolv.conf'
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

directory '/etc/sssd' do
 action :create
 recursive true
 owner "sssd"
 group "sssd"
 mode 0644
 action :create
end

directory '/etc/sssd/conf.d' do
 action :create
 recursive true
 owner "sssd"
 group "sssd"
 mode 0644
 action :create
end

cookbook_file '/etc/sssd/sssd.conf' do
 source 'sssd.conf'
 owner 'root'
 group 'root'
 mode '0600'
 action :create
end

cookbook_file '/etc/pam.d/system-auth' do
 source 'system-auth'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/etc/crontab' do
 source 'crontab'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/etc/motd' do
 source 'motd_tabajara'
 owner 'root'
 group 'root'
 mode '0700'
 action :create
end
