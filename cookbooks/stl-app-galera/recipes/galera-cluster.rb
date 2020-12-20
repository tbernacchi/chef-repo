#
# Cookbook:: stl-app-galera
# Recipe:: galera-cluster
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Adicionando hosts do cluster do galera para nao depender de DNS
hostsfile_entry '10.150.251.41' do
  hostname  'balaio01.tabajara.intranet'
    action  :create_if_missing
end

hostsfile_entry '10.150.251.59' do
  hostname  'balaio02.tabajara.intranet'
    action  :create_if_missing
end

hostsfile_entry '10.150.251.57' do
  hostname  'balaio03.tabajara.intranet'
    action  :create_if_missing
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

# mysql limits
cookbook_file '/etc/security/limits.d/galera-limits.conf' do
  source 'limits/galera-limits.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# swappiness
cookbook_file '/etc/sysctl.d/200-galera-swappiness.conf' do
  source 'sysctl/200-galera-swappiness.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# Core file
cookbook_file '/etc/security/limits.d/galera-core.conf' do
  source 'limits/galera-core.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end
