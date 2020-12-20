#
# Cookbook:: stl-hardening
# Recipe:: history
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file "/etc/profile.d/history.sh" do
 source 'history' 
 owner "root"
 mode "0644"
 action :create
end
