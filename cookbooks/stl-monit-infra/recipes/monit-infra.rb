#
# Cookbook:: stl-monit-infra
# Recipe:: monit-infra.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#hosts
cookbook_file '/etc/hosts' do
  source 'etc/hosts'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Entrega de arquivos do cron
## monitoria do requests na SL
cookbook_file '/etc/cron.d/monit-slayer' do
  source 'crond/monit-slayer'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# monitoria dos vips
cookbook_file '/etc/cron.d/monit-slb' do
  source 'crond/monit-slb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

## monitoria do requests na certificados
cookbook_file '/etc/cron.d/monit-certs' do
  source 'crond/monit-certs'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

## monitoria diversas: jobs, arquivos e API
cookbook_file '/etc/cron.d/monit-jobs' do
  source 'crond/monit-jobs'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

## monitoria do vmware
cookbook_file '/etc/cron.d/monitoria-integrada-vmware' do
  source 'crond/monitoria-integrada-vmware'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Cria o diretorio
directory "/usr/local/bin/monit-slayer" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# Cria o diretorio
directory "/usr/local/bin/monitoria-integrada-vmware" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# Cria o diretorio
directory "/usr/local/bin/monitoria-datacenter" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# inicia a entrega de arquivos

# Monitoria da softlayer
cookbook_file '/usr/local/bin/monit-slayer/check-ticket-sl.sh' do
  source 'bin/check-ticket-sl.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

## monitoria do certificados
# Cria o diretorio
directory "/usr/local/bin/monit-certs" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

cookbook_file '/usr/local/bin/monit-certs/check-ssl.sh' do
  source 'bin/check-ssl.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-resource-virt.sh' do
  source 'bin/get-resource-virt.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-vcpu-2-cpu.sh' do
  source 'bin/get-vcpu-2-cpu.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-vmware-status.sh' do
  source 'bin/get-vmware-status.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-reduce-add-mem.sh' do
  source 'bin/get-reduce-add-mem.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# Cria o diretorio

# Cria o diretorio
directory "/usr/local/bin/monit-jobs" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

cookbook_file '/usr/local/bin/monit-jobs/check_monit-jobs-sftp-tabajara.sh' do
  source 'bin/check_monit-jobs-sftp-tabajara.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-jobs/check-portal-admin-new.sh' do
  source 'bin/check-portal-admin-new.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-jobs/check-runscope.sh' do
  source 'bin/check-runscope.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-jobs/check-pingdom.sh' do
  source 'bin/check-pingdom.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-jobs/check-credenciamento.sh' do
  source '/bin/check-credenciamento.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-jobs/check-terminalseller-api.sh' do
  source '/bin/check-terminalseller-api.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


cookbook_file '/usr/local/bin/monit-jobs/check-bitcoin-transaction.sh' do
  source '/bin/check-bitcoin-transaction.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-jobs/mandrill-email-quota.sh' do
  source '/bin/mandrill-email-quota.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-slayer/check-incident-sl.sh' do
  source '/bin/check-incident-sl.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-costop.sh' do
  source '/bin/get-costop.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-cpu-mem-cluster.sh' do
  source '/bin/get-cpu-mem-cluster.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-media-pico-cluster.sh' do
  source '/bin/get-media-pico-cluster.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-mhz-vms-vcops.sh' do
  source '/bin/get-mhz-vms-vcops.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-reduce-add-cpus.sh' do
  source '/bin/get-reduce-add-cpus.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monitoria-integrada-vmware/get-avg-mem.sh' do
  source '/bin/get-avg-mem.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monitoria-datacenter/get-status-hw-sl.sh' do
  source '/bin/get-status-hw-sl.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/monit-jobs/nc-hosts-zabbix.sh' do
  source '/bin/nc-hosts-zabbix.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end 

cookbook_file '/usr/local/bin/monit-jobs/check-mini-tabajara.sh' do
  source '/bin/check-mini-tabajara.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end 

cookbook_file '/usr/local/bin/monit-jobs/response-time-valid.sh' do
  source '/bin/response-time-valid.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end 

# cria o diretorio
directory '/usr/local/bin/monit-sustentacao' do
  recursive true
  owner 'nobody'
  group 'nobody'
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/monit-sustentacao/check-recadastro.sh' do
  source 'bin/check-recadastro.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end 


# Cria o diretorio
directory "/usr/local/bin/monit-rundeck" do
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

cookbook_file '/usr/local/bin/monit-rundeck/get-status-jobs-rundeck.sh' do
  source 'bin/monit-rundeck/get-status-jobs-rundeck.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/cron.d/monit-rundeck' do
  source 'crond/monit-rundeck'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end 

# matera monit
# Cria o diretorio
directory '/usr/local/bin/matera' do
  recursive true
  owner 'nobody'
  group 'nobody'
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/matera/monit-edi-matera.sh' do
  source 'bin/monit-edi-matera.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/etc/cron.d/monit-edi-matera' do
  source 'crond/monit-edi-matera'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/matera/copy-edi-matera.sh' do
  source 'bin/copy-edi-matera.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/monit-slb/create-vip-in-zabbix.sh' do
  source 'bin/create-vip-in-zabbix.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# redis
cookbook_file '/etc/cron.d/monit-redis' do
  source 'crond/monit-redis'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# Cria o diretorio
directory '/usr/local/bin/monit-redis' do
  recursive true
  owner 'nobody'
  group 'nobody'
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/monit-redis/redis-requests.sh' do
  source 'bin/monit-redis/redis-requests.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# Siloc
# Cria o diretorio
directory '/usr/local/bin/monit-siloc' do
  recursive true
  owner 'nobody'
  group 'nobody'
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/monit-siloc/check_health.py' do
  source 'bin/monit-siloc/check_health.py'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# 
cookbook_file '/etc/cron.d/monit-siloc' do
  source 'crond/monit-siloc'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# Cria o diretorio
directory '/usr/local/bin/send-slack' do
  recursive true
  owner 'nobody'
  group 'nobody'
  mode 0644
  action :create
end

cookbook_file '/usr/local/bin/send-slack/send-slack-aviso.sh' do
  source 'bin/send-slack/send-slack-aviso.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/send-slack/message.txt' do
  source 'bin/send-slack/message.txt'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end


# 
cookbook_file '/etc/cron.d/send-slack-aviso' do
  source 'crond/send-slack-aviso'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end
