#
# Cookbook:: stl-spacewalk
# Recipe:: client
#
# Copyright:: 2018, The Authors, All Rights Reserved.
template "/etc/yum.repos.d/spacewalk.repo" do
 source "spacewalk.repo.erb"
 owner "root"
 group "root"
 mode 0644
end

%w{ rhn-client-tools rhn-check rhn-setup rhnsd yum-rhn-plugin m2crypto}.each do |pkg|
 yum_package pkg do
 action :install
 not_if "rpm -q #{pkg}"
 end
end 

remote_file '/usr/share/rhn/RHNS-CA-CERT' do
 owner 'root'
 group 'root'
 mode '0644'
 source "http://#{node['stl-spacewalk']['server_name']}/pub/RHN-ORG-TRUSTED-SSL-CERT"
 not_if { File.exist?("/usr/share/rhn/RHN-CA-CERT") }
end

execute "register" do
 command "/usr/sbin/rhnreg_ks --profilename #{node['fqdn']} --serverUrl=http://#{node['stl-spacewalk']['server_name']}/XMLRPC --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --activationkey=#{node['stl-spacewalk']['activationkey']}"
 not_if { File.exist?("/etc/sysconfig/rhn/systemid") }
 ignore_failure true
end

#execute "Fix update (rpm)" do 
# command 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-*'
#end

template "/etc/sysconfig/rhn/rhnsd" do
 source "rhnsd.erb"
 mode 0644
 owner "root"
 group "root"
 notifies :restart, "service[rhnsd]", :delayed
end

service "rhnsd" do
  action [ :enable, :start ]
end

cookbook_file '/etc/cron.d/rhn_check' do
  source 'crond/rhn_check'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
