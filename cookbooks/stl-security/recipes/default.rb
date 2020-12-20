#
# Cookbook:: stl-security
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'stl-security::history' 
include_recipe 'stl-security::history-to-rsyslog' 
include_recipe 'stl-security::sudoers-block-commands' 
include_recipe 'stl-security::oddjobd' 
