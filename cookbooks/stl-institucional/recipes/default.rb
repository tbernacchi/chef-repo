#
# Cookbook:: stl-institucional
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'stl-nginx' 
include_recipe 'stl-institucional::confd' 
include_recipe 'stl-institucional::scripts' 
