#
# Cookbook:: stl-app-cadu-novo
# Recipe:: validacao-aceite
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-java'
include_recipe 'stl-nginx::nginx'

%w{ /app /app/standalone /app/standalone/validacao-aceite /app/standalone/validacao-aceite/conf /app/log /app/log/standalone /app/log/standalone/validacao-aceite }.each do |dirs|
  directory "#{dirs}" do
  owner "svc-validacao"
  group "nobody"
  mode 0744
  action :create
  end
end

execute "yum-clean-all" do
  command "touch /tmp/yum.lock && yum clean all"
  action :run
  not_if { File.exists? ("/tmp/yum.lock") }
end 

yum_package "validacao-aceite" do
  allow_downgrade true
  package_name "validacao-aceite"
    if node.chef_environment == "prod"
    version node['novo-cadu']['app'][node.chef_environment]['validacao_aceite_version']
    end
  action [ :upgrade]
end

template "/app/standalone/validacao-aceite/conf/application.properties" do 
  source "app/standalone/validacao/conf/validacao-aceite.erb"
  mode "0644"
  owner "svc-validacao" 
  group "root"
  action :create 
  notifies :run, 'execute[daemon-reload]', :immediately
end 
 
template '/etc/systemd/system/validacao-aceite.service' do
  source 'etc/systemd/validacao-aceite-pessoa.erb'
  owner 'svc-validacao'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

link '/etc/systemd/system/multi-user.target.wants/validacao-aceite.service' do
  to '/etc/systemd/system/validacao-pessoa.service'
end

file "/app/standalone/validacao-pessoa/validacao-aceite.jar" do 
  mode '0644'
  owner 'svc-validacao'
  group 'root'
end 

service "validacao-aceite" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

execute 'daemon-reload' do
  command "systemctl daemon-reload && systemctl restart validacao-aceite.service"
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

