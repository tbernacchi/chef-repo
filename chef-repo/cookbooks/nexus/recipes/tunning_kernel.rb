#
# Cookbook:: nexus
# Recipe:: tunning_kernel
#
# Copyright:: 2018, The Authors, All Rights Reserved.
if node['platform'] == 'centos'
  if node['platform_version'].to_i == 7
	directory "/etc/systemd/system/nginx.service.d/" do 
 	owner "root"
 	group "root"
 	mode 0755
end

directory "/etc/systemd/system/nexus.service.d/" do 
 owner "root"
 group "root"
 mode  "0755"
 action :create
end

cookbook_file "/etc/systemd/system/nginx.service.d/nofile_limit.conf" do 
      source "nofile_limit.conf.erb"
      owner "root"
      group "root"
      mode 0644
      notifies :run, 'execute[daemon-reload]', :immediately
end

cookbook_file "/etc/systemd/system/nexus.service.d/nofile_limit.conf" do 
      source "nofile_limit.conf.erb"
      owner "root"
      group "root"
      mode 0644
      notifies :run, 'execute[daemon-reload]', :immediately
end

execute "daemon-reload" do
      user "root"
      command "systemctl daemon-reload; systemctl restart nginx.service; systemctl restart nexus.service"
      action :nothing
end

  end
end
