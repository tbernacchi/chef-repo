#
# Cookbook:: stl-bacula-server
# Recipe:: bacula-tools
#
# Copyright:: 2019, The Authors, All Rights Reserved.
# Entrega do arquivo - DIR
# Cria o diretorio para receber as confs
directory "/usr/local/bin/tools" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode 0755
    action :create
end

cookbook_file '/usr/local/bin/tools/remove-vols-out-cataog.sh' do
  source '/usr/tools/remove-vols-out-cataog.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
