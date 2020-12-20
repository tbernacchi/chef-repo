#
# Cookbook:: stl-app-mis
# Recipe:: tabajara-reports
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Cria o diretorio
directory "/usr/local/bin/move-transfer" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# script para transferencia de arquivos de relatorios "BASE-FULL" para tabajara
cookbook_file '/usr/local/bin/move-transfer/copy-reports-base-full-2-tws.sh' do
  source 'bin/move-transfer/copy-reports-base-full-2-tws.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# configuracao do cron para copiar os reports do servidor local para o TWS (vintws001)
cookbook_file '/etc/cron.d/copy-reports' do
  source 'etc/cron.d/copy-reports'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
