#
# Cookbook:: nexus
# Recipe:: user
#
# Copyright:: 2018, The Authors, All Rights Reserved.
user 'nexus' do
  comment 'nexus user'
  system true 
  shell '/bin/bash'
  manage_home false
  action :create
  not_if "grep -q nexus /etc/passwd" 
end

