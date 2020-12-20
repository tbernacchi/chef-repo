#
# Cookbook:: stl-app-mis
# Recipe:: elo-report
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Cria o diretorio
directory "/usr/local/bin/street_batch_transferfile" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# script para transferencia de arquivos de relatorios para elo
cookbook_file '/usr/local/bin/street_batch_transferfile/street_batch_report_transfer_file.sh' do
  source 'bin/street_batch_transferfile/street_batch_report_transfer_file.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# script para transferencia de arquivos para TRIBUTARIO/Arquivos Base Alelo
cookbook_file '/usr/local/bin/street_batch_transferfile/street_batch_transfer_alelo_file.sh' do
  source 'bin/street_batch_transferfile/street_batch_transfer_alelo_file.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
