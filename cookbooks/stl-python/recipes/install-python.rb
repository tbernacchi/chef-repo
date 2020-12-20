#
# Cookbook:: stl-python
# Recipe:: install-python 
#
# Copyright:: 2019, The Authors, All Rights Reserved.

yum_package 'python36' do
 action :install
 not_if "test -f /usr/bin/python3"
end

#install pip
yum_package 'python36-pip' do
 action :install
 not_if "test -f /usr/bin/pip3"
end

