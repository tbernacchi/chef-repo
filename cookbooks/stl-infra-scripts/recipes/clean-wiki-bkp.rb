#
# Cookbook:: stl-infra-scripts
# Recipe:: clean-wiki-bkp
#
# Copyright:: 2020, The Authors, All Rights Reserved.
#
cookbook_file '/usr/local/bin/clean-backup-mariadb.sh' do
  source 'scripts/clean-backup-wiki.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/cron.d/clean-wiki-bkp' do
  source 'cron.d/clean-wiki-bkp'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
