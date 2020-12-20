#
# Cookbook:: stl-rundeck
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-rundeck::rundeck-core'
include_recipe 'stl-rundeck::create-project'
include_recipe 'stl-rundeck::rundeck-manuts'
