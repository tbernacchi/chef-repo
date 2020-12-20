#
# Cookbook:: stl-security 
# Recipe:: sudoers-block-commands
#
# Copyright:: 2018, The Authors, All Rights Reserved.
template '/etc/sudoers' do
 source 'sudoers.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/etc/sudoers.d/block-dev-commands.conf' do
 source 'block-dev-commands.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

link '/etc/sudoers.d/01-dev' do
 to '/etc/sudoers.d/block-dev-commands.conf'
end
