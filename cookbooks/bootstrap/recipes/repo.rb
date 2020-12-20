#
# Cookbook:: bootstrap
# Recipe:: repo
#
# Copyright:: 2018, The Authors, All Rights Reserved.
template '/etc/yum.repos.d/centos-tabajara.repo' do
 source 'centos-tabajara.repo.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

template '/etc/yum.repos.d/pacotes-dev-tabajara.repo' do
 source 'pacotes-dev-tabajara.repo.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

