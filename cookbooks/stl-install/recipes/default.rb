#
# Cookbook:: stl-install
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'stl-install::network-sniffer'
include_recipe 'stl-install::netcat'
include_recipe 'stl-install::rsync'
include_recipe 'stl-install::screen'
include_recipe 'stl-install::bc'
include_recipe 'stl-install::jq'
