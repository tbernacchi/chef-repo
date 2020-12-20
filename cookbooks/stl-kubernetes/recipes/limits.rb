#
# Cookbook:: stl-prometheus
# Recipe:: limits
#
# Copyright:: 2019, The Authors, All Rights Reserved.
cookbook_file "/etc/pam.d/common-session" do
 source "limits/common-session"
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ('/etc/pam.d/common-session') }
end

cookbook_file "/etc/security/limits.conf" do
 source "limits/limits.conf"
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if "grep -q 65000 /etc/security/limits.conf"
 notifies :run, 'execute[sysctl]', :immediately
end

execute 'sysctl' do
 command 'sysctl -p'
 action :nothing
end
