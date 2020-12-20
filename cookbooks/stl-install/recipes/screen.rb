#
# Cookbook:: stl-install
# Recipe:: screen
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_package 'screen.x86_64' do 
 action :install
 not_if { File.exist? ("/usr/bin/screen") }
end
