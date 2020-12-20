# Cookbook:: bootstrap
# Recipe:: integraSSHxAD
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/etc/resolv.conf' do
 source 'resolv.conf'
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
 not_if { File.exist? ("/etc/sssd/sssd.conf") }  
end

execute 'authentication-provider' do 
 command 'authconfig --enablekrb5 --krb5kdc=tabajaradc.local --krb5adminserver=tabajara.dc.local --krb5realm=TABAJARADC.LOCAL --enablesssd --enablesssdauth --update'
 not_if "getent group infraestrutura_admin | grep -q infra"  
end

cookbook_file '/root/expect_adcli.sh' do
 source 'expect_adcli.sh'
 owner 'root'
 group 'root'
 mode '0700'
 action :create
end

execute 'expect_adcli.sh' do 
 command '/root/expect_adcli.sh'
 not_if "getent group infraestrutura_admin | grep -q infra"  
end 

cookbook_file '/etc/sysconfig/selinux' do
 source 'selinux'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if 'getenforce | grep -q Disabled'
end

cookbook_file '/etc/pam.d/system-auth' do
 source 'system-auth'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/etc/pam.d/system-auth-ac") }  
end

cookbook_file '/etc/sudoers' do
 source 'sudoers'
 owner 'root'
 group 'root'
 mode '0440'
 action :create
end

cookbook_file '/etc/sudoers.d/dev-users' do
  source 'sudoers.d/dev-users'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end

cookbook_file '/etc/sudoers.d/implantacao-users' do
  source 'sudoers.d/implantacao-users'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end

cookbook_file '/etc/sudoers.d/infra-users' do
  source 'sudoers.d/infra-users'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end

cookbook_file '/etc/security/access.conf' do
 source 'access.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if "egrep -q 'infraestrutura|Des' /etc/security/access.conf"
end

systemd_unit 'sssd.service' do
 action [ :enable, :start ]
end

systemd_unit 'winbind.service' do
 action [ :enable, :start ]
end

cookbook_file '/etc/crontab' do 
 source 'crontab' 
 owner 'root'
 group 'root'
 mode '0700'
 action :create
end

cookbook_file '/root/home_mkdir.sh' do
 source 'home_mkdir.sh'
 owner 'root'
 group 'root'
 mode '0700'
 action :create
 not_if { File.exist? ("/root/home_mkdir.sh") }  
end

execute 'Home directories for infraestrutura_admin users' do 
 command 'sh /root/home_mkdir.sh'
end

execute 'Removing script home_mkdir.sh' do 
 command 'rm -rf /root/home_mkdir.sh'
 only_if { File.exist? ("/root/home_mkdir.sh") }  
end

execute 'Executing expect_adcli.sh' do 
 command 'expect /root/expect_adcli.sh'
 not_if "getent group infraestrutura_admin | grep -q infra"  
end 

execute 'Removing expect_adcli.sh' do 
 command 'rm -rf /root/expect_adcli.sh'
 only_if { File.exist? ("/root/expect_adcli.sh") }  
end


