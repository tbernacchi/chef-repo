#
# Cookbook:: stl-infra-scripts
# Recipe:: wiki-infra
#
# Copyright:: 2020, The Authors, All Rights Reserved.
#
cookbook_file '/usr/local/bin/backup-wiki-infra.sh' do
  source 'scripts/backup-wiki-infra.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/clean-backup-wiki.sh' do
  source 'scripts/clean-backup-wiki.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/cron.d/backup-wiki-infra' do
  source 'cron.d/backup-wiki-infra'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/cron.d/clean-wiki-bkp' do
  source 'cron.d/clean-wiki-bkp'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
