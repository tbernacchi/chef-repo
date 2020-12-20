#
# Cookbook:: stl-infra-scripts
# Recipe:: git-infra
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
cookbook_file '/usr/local/bin/backup-git-infra.sh' do
  source 'scripts/backup-git-infra.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/clean-backup-git.sh' do
  source 'scripts/clean-backup-git.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/cron.d/backup-git-infra' do
  source 'cron.d/backup-git-infra'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/cron.d/clean-git-bkp' do
  source 'cron.d/clean-git-bkp'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
