#
# Cookbook:: stl-bacula-backup
# Recipe:: bacula-backup.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Entrega do arquivo - DIR
cookbook_file '/etc/bacula/bacula-dir.conf' do
  source 'etc/bacula-dir.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Entrega do arquivo - DIR
cookbook_file '/etc/bacula/bconsole.conf' do
  source 'etc/bconsole.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Entrega do arquivo - SD
cookbook_file '/etc/bacula/bacula-sd.conf' do
  source 'etc/bacula-sd.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Entrega do arquivo - FD
cookbook_file '/etc/bacula/bacula-fd.conf' do
  source 'etc/bacula-fd.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Cria o diretorio para receber as confs
directory "/etc/bacula/bacula.d" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode 0755
    action :create
end

# Arquivo: storages
cookbook_file '/etc/bacula/bacula.d/storages.conf' do
  source 'etc/bacula.d/storages.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: schedules
cookbook_file '/etc/bacula/bacula.d/schedules.conf' do
  source 'etc/bacula.d/schedules.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: pools
cookbook_file '/etc/bacula/bacula.d/pools.conf' do
  source 'etc/bacula.d/pools.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: filesets.conf
cookbook_file '/etc/bacula/bacula.d/filesets.conf' do
  source 'etc/bacula.d/filesets.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: clients.conf
cookbook_file '/etc/bacula/bacula.d/clients.conf' do
  source 'etc/bacula.d/clients.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: autochangers.conf
cookbook_file '/etc/bacula/bacula.d/autochangers.conf' do
  source 'etc/bacula.d/autochangers.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: jobs.conf
cookbook_file '/etc/bacula/bacula.d/jobs.conf' do
  source 'etc/bacula.d/jobs.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Monitoria do Zabbix
#cookbook_file '/etc/bacula/bacula-zabbix.conf' do
#  source 'etc/bacula-zabbix.conf'
#  owner 'root'
#  group 'root'
#  mode '0644'
#  action :create
#  notifies :run, 'execute[daemon-bacula-restart]', :immediately
#end

# cookbook_file '/var/spool/bacula/bacula-zabbix.bash' do
#   source 'spool/bacula-zabbix.bash'
#   owner 'root'
#   group 'root'
#   mode '0644'
#   action :create
#   notifies :run, 'execute[daemon-bacula-restart]', :immediately
# end

## Script personalizados
##
# Arquivo: bacula-stop.sh
cookbook_file '/usr/local/bin/bacula-stop.sh' do
  source 'usr/bacula-stop.sh'
  owner 'root'
  group 'root'
  mode '0750'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: bacula-start.sh
cookbook_file '/usr/local/bin/bacula-start.sh' do
  source 'usr/bacula-start.sh'
  owner 'root'
  group 'root'
  mode '0750'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

# Arquivo: bacula-restart.sh
cookbook_file '/usr/local/bin/bacula-restart.sh' do
  source 'usr/bacula-restart.sh'
  owner 'root'
  group 'root'
  mode '0750'
  action :create
  notifies :run, 'execute[daemon-bacula-restart]', :immediately
end

#################################################
#################################################
# Reinicia o daemon do squid
execute "daemon-bacula-restart" do
 user "root"
 command "/usr/local/bin/bacula-restart.sh"
 action :nothing
end
