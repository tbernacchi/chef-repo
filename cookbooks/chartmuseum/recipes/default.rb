#
# Cookbook:: chartmuseum
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory "/opt/chartmuseum" do
 recursive true
 owner 'root'
 group 'root'
 mode '0755'
 not_if "{ ::Dir.exist? ( '/opt/chartmuseum') }"
end

remote_file '/opt/chartmuseum/chartmuseum' do
 source 'http://repo.qa.tabajara.intranet/pacotes/k8s/helm/chartmuseum/chartmuseum-0.9.0'
 owner 'root'
 group 'root'
 mode '0755'
 action :create
 not_if { File.exist? ("/opt/chartmuseum/chartmuseum") }
end

template '/opt/chartmuseum/startup.sh' do
  source 'startup.sh.erb'
  mode '0755'
end

template "/etc/systemd/system/chartmuseum.service" do
  source "chartmuseum.service.erb"
  mode '0755'
end

service "chartmuseum" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end
