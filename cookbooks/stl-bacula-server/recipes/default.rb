#
# Cookbook:: stl-bacula-backup
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'stl-bacula-server::bacula-backup'
include_recipe 'stl-bacula-server::bacula-monit'
include_recipe 'stl-bacula-server::bacula-tools'
