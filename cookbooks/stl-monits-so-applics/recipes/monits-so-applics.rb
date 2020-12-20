#
# Cookbook:: stl-monits-so-applics
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
# Cria o diretorio
directory '/usr/local/bin/check-time-so-java' do
    action :create
    recursive true
    owner 'root'
    group 'root'
    mode 0755
end

# Entrega do binario do java
#cookbook_file '/usr/local/bin/check-time-so-java/monitjavatime.class' do
#  source 'check-time-so-java/monitjavatime'
cookbook_file '/usr/local/bin/check-time-so-java/TestDate2.class' do
  source 'check-time-so-java/TestDate2'
  owner 'root'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# Entrega do script que executa a coleta do timestamp e envia para o zabbix
cookbook_file '/usr/local/bin/check-time-so-java/check-times.sh' do
  source 'check-time-so-java/check-times.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# Entrega a conf do zabbix agent
cookbook_file '/etc/zabbix/zabbix_agentd.d/check-dt-so-java.conf' do
  source 'zabbix_agentd.d/check-dt-so-java.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# Cria o diretorio
directory "/usr/local/bin/check-fstab" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# Entrega do script de monitoria dos mount point no  FSTAB
cookbook_file '/usr/local/bin/check-fstab/check-fstab-proc.sh' do
  source 'check-fstab/check-fstab-proc.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/etc/cron.d/exec-monit-fstab' do
  source 'crond/exec-monit-fstab'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end
