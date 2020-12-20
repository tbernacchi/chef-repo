#
# Cookbook:: stl-repo-server
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-repo-server::repo-server'
include_recipe 'stl-repo-server::rundeck-deploy'
