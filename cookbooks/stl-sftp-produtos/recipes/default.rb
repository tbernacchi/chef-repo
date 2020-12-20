#
# Cookbook:: stl-sftp-produtos
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'stl-sftp-produtos::ssh' 
include_recipe 'stl-sftp-produtos::sftp-produtos'
include_recipe 'stl-sftp-produtos::sftp-produtos-nginx'
