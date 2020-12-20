#
# Cookbook:: stl-conf
# Recipe:: svc-validacao
#
# Copyright:: 2019, The Authors, All Rights Reserved.
cookbook_file '/etc/sudoers.d/svc-validacao.conf' do 
 source 'etc/svc-validacao.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end
