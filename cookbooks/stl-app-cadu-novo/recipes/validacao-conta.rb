#
# Cookbook:: stl-app-cadu-novo
# Recipe:: validacao-conta
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-java'
include_recipe 'stl-nginx::nginx'

%w{ /app /app/standalone /app/standalone/validacao-conta /app/standalone/validacao-conta/conf /app/log /app/log/standalone /app/log/standalone/validacao-conta }.each do |dirs|
  directory "#{dirs}" do
  owner "svc-validacao"
  group "nobody"
  mode 0755
  action :create
  end
end

execute "yum-clean-all" do
  command "touch /tmp/yum.lock && yum clean all"
  action :run
  not_if { File.exists? ("/tmp/yum.lock") }
end 

yum_package "validacao-conta" do
  allow_downgrade true
  package_name "validacao-conta"
    if node.chef_environment == "prod"
    version node['novo-cadu']['app'][node.chef_environment]['validacao_conta_version']
    end
  action [ :upgrade]
end

template "/app/standalone/validacao-conta/conf/application.properties" do 
  source "app/standalone/validacao/conf/validacao-conta.erb"
  mode "0644"
  owner "svc-validacao" 
  group "root"
  action :create 
  notifies :run, 'execute[daemon-reload]', :immediately
end 

template "/usr/lib/systemd/system/validacao-conta.service" do
  source "etc/systemd/validacao-conta.erb"
  mode "0644"
  owner "svc-validacao"
  group "root"
  action :create
end

link '/etc/systemd/system/multi-user.target.wants/validacao-conta.service' do
  to '/etc/systemd/system/validacao-conta.service'
end

file "/app/standalone/validacao-conta/validacao-conta.jar" do 
  mode '0644'
  owner 'root'
  group 'root'
end 

service "validacao-conta" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

execute 'daemon-reload' do
  command "systemctl daemon-reload && systemctl restart validacao-conta.service"
  action :nothing
end

template "/etc/nginx/conf.d/validacao.conf" do
  source "etc/nginx/conf.d/validacao.conf.erb"
  notifies :restart, "service[nginx]", :delayed
end

service "nginx" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

