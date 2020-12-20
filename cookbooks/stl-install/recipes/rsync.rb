#
# Cookbook:: stl-install
# Recipe:: rsync
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_package 'rsync.x86_64' do 
 action :install
 not_if { File.exist? ("/usr/bin/rsync") }
end
