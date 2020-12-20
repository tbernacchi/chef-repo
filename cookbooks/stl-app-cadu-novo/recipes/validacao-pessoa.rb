#
# Cookbook:: stl-app-cadu-novo
# Recipe:: validacao-pessoa
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-java'
include_recipe 'stl-nginx::nginx'

%w{ /app /app/standalone /app/standalone/validacao-pessoa /app/standalone/validacao-pessoa/conf /app/log /app/log/standalone /app/log/standalone/validacao-pessoa }.each do |dirs|
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

yum_package "validacao-pessoa" do
  allow_downgrade true
  package_name "validacao-pessoa"
    if node.chef_environment == "prod"
    version node['novo-cadu']['app'][node.chef_environment]['validacao_pessoa_version']
    end
  action [ :upgrade]
end

template "/app/standalone/validacao-pessoa/conf/application.properties" do 
  source "app/standalone/validacao/conf/validacao-pessoa.erb"
  mode "0644"
  owner "svc-validacao" 
  group "root"
  action :create 
  notifies :run, 'execute[daemon-reload]', :immediately
end 

template '/etc/systemd/system/validacao-pessoa.service' do
  source 'etc/systemd/validacao-pessoa.erb'
  owner 'svc-validacao'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload]', :immediately
end

link '/etc/systemd/system/multi-user.target.wants/validacao-pessoa.service' do
  to '/etc/systemd/system/validacao-pessoa.service'
end

file "/app/standalone/validacao-pessoa/validacao-pessoa.jar" do 
  mode '0644'
  owner 'svc-validacao'
  group 'root'
end 

service "validacao-pessoa" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

execute 'daemon-reload' do
  command 'systemctl daemon-reload && systemctl restart validacao-pessoa'
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

# Otimizando o uso do disco com a troca do scheduler
# passando a responsabilidade para o hypervisor
# # Set the IO Scheduler
node['block_device'].select { |device, info| device =~ /^.d.$/ && info['size'].to_i > 0 }.each do |device, info|
 execute "scheduler-#{device}" do
   command "echo 'noop' > /sys/block/#{device}/queue/scheduler"
   not_if "grep -F '[noop]' /sys/block/#{device}/queue/scheduler"
 end
end

