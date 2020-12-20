#
# Cookbook:: stl-app-apimonitor 
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
cookbook_file "/tmp/yum.lock" do
  action :delete
  only_if { File.exists? ("/tmp/yum.lock") } 
end

include_recipe 'stl-app-apimonitor::apimonitor'

execute "rm /tmp/yum.lock" do
  command "rm -f /tmp/yum.lock"
  action :run
  only_if { File.exists? ("/tmp/yum.lock") }
end
