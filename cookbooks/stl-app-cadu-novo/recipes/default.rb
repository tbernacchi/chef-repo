#
# Cookbook:: stl-app-cadu-novo
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
cookbook_file "/tmp/yum.lock" do
  action :delete
  only_if { File.exists? ("/tmp/yum.lock") } 
end

include_recipe 'stl-app-cadu-novo::user-svc-validacao'
include_recipe 'stl-app-cadu-novo::rundeck-deploy'
include_recipe 'stl-app-cadu-novo::validacao-aceite'
include_recipe 'stl-app-cadu-novo::validacao-aceite-pessoa'
include_recipe 'stl-app-cadu-novo::validacao-cnae'
include_recipe 'stl-app-cadu-novo::validacao-conta'
include_recipe 'stl-app-cadu-novo::validacao-email'
include_recipe 'stl-app-cadu-novo::validacao-endereco'
include_recipe 'stl-app-cadu-novo::validacao-pessoa-onboard'
include_recipe 'stl-app-cadu-novo::validacao-pessoa'
include_recipe 'stl-app-cadu-novo::validacao-ec'
include_recipe 'stl-app-cadu-novo::validacao-telefone'

service "nginx" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

template "/etc/nginx/conf.d/healthcheck.conf" do
  source "etc/nginx/conf.d/healthcheck.conf.erb"
  notifies :restart, "service[nginx]", :delayed
end

execute "rm /tmp/yum.lock" do
  command "rm -f /tmp/yum.lock"
  action :run
  only_if { File.exists? ("/tmp/yum.lock") }
end 

