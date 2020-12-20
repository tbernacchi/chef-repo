#
# Cookbook:: stl-httpd
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package 'httpd' do
	package_name 'httpd'
	version '2.4.6-88.el7.centos'
        action [ :install ]
        not_if "test -d /usr/sbin/httpd"
end

service "httpd" do
        supports :status => true, :restart => true, :reload => true
        action [ :start, :enable ]
end

template "/etc/httpd/conf/httpd.conf" do
        owner "root"
        group "root"
        mode 0644
        source "httpd.conf.erb"
        notifies :restart, "service[httpd]", :delayed
end
