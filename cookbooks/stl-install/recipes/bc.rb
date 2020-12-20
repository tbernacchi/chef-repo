#
# Cookbook:: stl-install
# Recipe:: bc
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_package 'bc' do 
 action :install
 not_if { File.exist? ("/bin/bc") }
end
