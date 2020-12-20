#
# Cookbook:: stl-install
# Recipe:: bc
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_package 'jq' do 
 action :install
 not_if { File.exist? ("/usr/bin/jq") }
end
