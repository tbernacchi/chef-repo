#
# Cookbook:: stl-security
# Recipe:: vbnbus-access-rsyslog
#
# Copyright:: 2019, The Authors, All Rights Reserved.
template "/etc/rsyslog.d/vbnbus-access-rsyslog.conf" do
 owner "root"
 group "root"
 mode 0644
 source "vbnbus-access-rsyslog.erb"
 notifies :restart, "service[rsyslog]", :delayed
end

service "rsyslog" do
 supports :start => true, :stop => true, :restart => true, :status => true
 action [:enable, :start]
end
