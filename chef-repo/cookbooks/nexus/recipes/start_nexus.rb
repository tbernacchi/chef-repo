#
# Cookbook:: nexus
# Recipe:: start_nexus
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/usr/lib/systemd/system/nexus.service' do
 source 'nexus.service'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 #not_if { File.exist? ('/etc/systemd/system/nexus.service') }
end

systemd_unit 'nexus.service' do
 supports :status => true, :restart => true, :start => true
 action [ :enable, :start ]
end
