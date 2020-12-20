#
# Cookbook:: stl-security
# Recipe:: clean-remote-files
#
# Copyright:: 2019, The Authors, All Rights Reserved.
cookbook_file "/etc/cron.d/clean-remote-files" do
 source 'clean_remote_files' 
 owner "root"
 mode "0644"
 action :create
end

cookbook_file "/usr/local/bin/clean_remote_files.sh" do
 source 'clean_remote_files.sh'
 owner "root"
 mode "0755"
 action :create
end

