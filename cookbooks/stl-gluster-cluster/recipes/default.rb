#
# Cookbook:: stl-gluster-cluster
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-gluster-cluster::gluster-tunning'
include_recipe 'stl-gluster-cluster::export-gluster-conf'
