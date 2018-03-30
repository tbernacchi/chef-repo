#
# Cookbook:: jetty
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'jetty::packages'
include_recipe 'jetty::user'
include_recipe 'jetty::installing_jetty'
include_recipe 'jetty::deploy_war'
include_recipe 'jetty::start_jetty'
