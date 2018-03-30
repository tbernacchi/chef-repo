#
# Cookbook:: jetty
# Recipe:: user
#
# Copyright:: 2018, The Authors, All Rights Reserved.
user 'jetty' do
  comment 'jetty user'
  system true 
  shell '/bin/bash'
  manage_home true
  action :create
  not_if "grep -q jetty /etc/passwd" 
end
