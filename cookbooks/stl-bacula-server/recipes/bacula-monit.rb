#
# Cookbook:: stl-bacula-server
# Recipe:: bacula-monit
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Entrega do arquivo - DIR

# Cria o diretorio para receber as confs
directory "/usr/local/bin/grafs/" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode 0755
    action :create
end

cookbook_file '/usr/local/bin/grafs/grafs-trigger-backup-clients.sh' do
  source 'usr/grafs/grafs-trigger-backup-clients.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/cron.d/exec-grafs-monit' do
  source 'etc/crond/exec-grafs-monit'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end


