#
# Cookbook:: stl-security
# Recipe:: chef-server-rsyslog
#
# Copyright:: 2019, The Authors, All Rights Reserved.
template "/etc/rsyslog.d/chef-server-rsyslog.conf" do
 source "chef-server-rsyslog.erb"
 owner "root"
 group "root"
 mode 0644
 notifies :restart, "service[rsyslog]", :delayed
end

service "rsyslog" do
 supports :start => true, :stop => true, :restart => true, :status => true
 action [:enable, :start]
end
