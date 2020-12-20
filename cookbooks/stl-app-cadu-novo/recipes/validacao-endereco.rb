#
# Cookbook:: stl-app-cadu-novo
# Recipe:: validacao-endereco
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-java'
include_recipe 'stl-nginx::nginx'

%w{ /app /app/standalone/validacao-endereco /app/standalone/validacao-endereco/conf /app/log /app/log/standalone /app/log/standalone/validacao-endereco }.each do |dirs|
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

yum_package "validacao-endereco" do
  allow_downgrade true
  package_name "validacao-endereco"
    if node.chef_environment == "prod"
    version node['novo-cadu']['app'][node.chef_environment]['validacao_endereco_version']
    end
  action [ :upgrade]
end

template "/app/standalone/validacao-endereco/conf/application.properties" do 
  source "app/standalone/validacao/conf/validacao-endereco.erb"
  mode "0644"
  owner "svc-validacao" 
  group "root"
  action :create 
  notifies :run, 'execute[daemon-reload]', :immediately
end 

template "/usr/lib/systemd/system/validacao-endereco.service" do
  source "etc/systemd/validacao-endereco.erb"
  mode "0644"
  owner "svc-validacao"
  group "root"
  action :create
end

file "/app/standalone/validacao-endereco/validacao-endereco.jar" do 
  mode '0644'
  owner 'root'
  group 'root'
end 

service "validacao-endereco" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

execute 'daemon-reload' do
  command "systemctl daemon-reload && systemctl restart validacao-endereco.service"
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

