#
# Cookbook:: stl-install
# Recipe:: netcat
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_package 'nmap-ncat.x86_64' do 
 action :install
 not_if { File.exist? ("/bin/nc") }
end
