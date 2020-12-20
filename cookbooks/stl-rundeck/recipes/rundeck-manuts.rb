#
# Cookbook:: stl-rundeck
# Recipe:: rundeck-manuts
#
# Copyright:: 2019, The Authors, All Rights Reserved.
# make dirs
%w{ /usr/local/bin/manut-rundeck }.each do |dirs|
    directory "#{dirs}" do
    owner 'root'
    group 'root'
    mode 0775
    recursive true
    action :create
  end
end

cookbook_file '/usr/local/bin/manut-rundeck/clean-json-log.sh' do
  source 'bin/rundeck/manut-rundeck/clean-json-log.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# Entrega de arquivos do cron
cookbook_file '/etc/cron.d/exec-clean-json-log' do
  source 'etc/crond/exec-clean-json-log'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end


