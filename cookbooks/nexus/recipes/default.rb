#
# Cookbook:: nexus
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'nexus::java-1.8.0'
include_recipe 'nexus::user'
include_recipe 'nexus::installing_nexus'
include_recipe 'nexus::start_nginx'
include_recipe 'nexus::start_nexus'
include_recipe 'nexus::tunning_kernel' 
