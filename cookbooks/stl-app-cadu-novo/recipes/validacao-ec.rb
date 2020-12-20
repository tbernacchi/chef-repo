#
# Cookbook:: stl-app-cadu-novo
# Recipe:: validacao-ec
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-java'
include_recipe 'stl-nginx::nginx'

%w{ /app /app/standalone/ /app/standalone/validacao-ec /app/standalone/validacao-ec/conf /app/log /app/log/standalone /app/log/standalone/validacao-ec }.each do |dirs|
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

yum_package "validacao-ec" do
  allow_downgrade true
  package_name "validacao-ec"
    if node.chef_environment == "prod"
    version node['novo-cadu']['app'][node.chef_environment]['validacao_ec_version']
    end
  action [ :upgrade]
end

template "/app/standalone/validacao-ec/conf/application.properties" do 
  source "app/standalone/validacao/conf/validacao-ec.erb"
  mode "0644"
  owner "svc-validacao" 
  group "root"
  action :create 
  notifies :run, 'execute[daemon-reload]', :immediately
end 

template '/etc/systemd/system/validacao-ec.service' do
  source 'etc/systemd/validacao-ec.erb'
  owner 'svc-validacao'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

link '/etc/systemd/system/multi-user.target.wants/validacao-ec.service' do
  to '/etc/systemd/system/validacao-ec.service'
end

file "/app/standalone/validacao-ec/validacao-ec.jar" do 
  mode '0644'
  owner 'svc-validacao'
  group 'root'
end 

service "validacao-ec" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

template "/etc/nginx/conf.d/validacao.conf" do
  source "etc/nginx/conf.d/validacao.conf.erb"
  notifies :restart, "service[nginx]", :delayed
end

service "nginx" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

