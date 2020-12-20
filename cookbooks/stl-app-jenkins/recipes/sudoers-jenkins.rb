#
# Cookbook:: stl-app-jenkins
# Recipe:: sudoers-jenkins
#
# Copyright:: 2019, The Authors, All Rights Reserved.

cookbook_file '/etc/sudoers.d/jenkins-user' do
  source 'sudoers.d/jenkins-user'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end
