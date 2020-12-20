#
# Cookbook:: stl-institucional
# Recipe:: confd
#
# Copyright:: 2018, The Authors, All Rights Reserved.
directory '/var/www/Institucional/imagens' do
  owner 'root'
  group 'nginx'
  mode '0755'
  recursive true
  action :create
end

cookbook_file '/etc/nginx/conf.d/1-www.tabajara.com.br.conf' do
 source '1-www.tabajara.com.br.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[nginx-restart]', :immediately
end

cookbook_file '/etc/nginx/conf.d/2-imagens.tabajara.com.br.conf' do
 source '2-imagens.tabajara.com.br.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 notifies :run, 'execute[nginx-restart]', :immediately
end

execute 'nginx-restart' do
 command 'systemctl restart nginx'
 action :nothing
end

