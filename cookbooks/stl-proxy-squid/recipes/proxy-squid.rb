#
# Cookbook:: stl-proxy-squid
# Recipe:: proxy-squid.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Entrega do arquivo do squid
cookbook_file '/etc/squid/squid.conf' do
  source 'squid.conf'
  owner 'root'
  group 'squid'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-squid-restart]', :immediately
end

# Entrega do arquivo do rsyslog enviando para o graylog via udp
cookbook_file '/etc/rsyslog.d/squid-rsyslog.conf' do
  source 'squid-rsyslog.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-rsyslog-restart]', :immediately
end

# Reinicia o daemon do squid
execute "daemon-squid-restart" do
 user "root"
 command "systemctl restart squid"
 action :nothing
end

# Reinicia o daemon do rsyslog
execute "daemon-rsyslog-restart" do
 user "root"
 command "systemctl restart rsyslog"
 action :nothing
end

# Instala o pacote do squid
package "squid" do
  action :install
  not_if "test -d /etc/squid"
end

# Adicionando por falha na configuracao de DNS para enderecos validos da tabajara 
# que sao direcionados para a rede interna ate a migracao para tabajara.intranet
hostsfile_entry '10.150.27.36' do
  hostname  'api.tabajara.com.br'
  action  :create_if_missing
end
