#
# Cookbook:: bootstrap
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'bootstrap::ntp'
include_recipe 'bootstrap::disable-ipv6'
include_recipe 'bootstrap::repo'
include_recipe 'bootstrap::integra'
