#
# Cookbook:: stl-app-galera
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-app-galera::galera-monit'
include_recipe 'stl-app-galera::galera-cluster'
