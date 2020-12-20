#
# Cookbook:: stl-proxy-squid
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'stl-proxy-squid::proxy-squid'
include_recipe 'stl-proxy-squid::stl-monit-urls'
